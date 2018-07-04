# -*- coding: utf-8 -*-
from __future__ import unicode_literals

import numpy as np
import pandas
from rest_framework.views import APIView
from sklearn.cross_validation import train_test_split

from models import Artwork, UserRating
from rest_framework.response import Response
from serializers import ArtworkSerializer
from utils import item_similarity_recommender_py


class Recommendation(APIView):
    """
    used to manage users recommendations
    """

    def get_recommendation(self, piece_df_1, user_id):
        # Read piece  metadata
        qs = Artwork.objects.all().extra(select={'artwork__id': 'id'}).values(
            'artwork__id', 'title', 'url', 'author__id', 'gender__id')
        piece_df_2 = qs.to_dataframe()
        piece_df_2['obraautor'] = piece_df_2['title'].map(
            str) + " - " + piece_df_2['author_id']
        # Merge the two dataframes above to create input dataframe for recommender systems
        piece_df = pandas.merge(piece_df_1, piece_df_2,
                                on="artwork__id", how="left")
        # Merge piece title and artist_name columns to make a merged column
        piece_df['obraautor'] = piece_df['artwork__id'].map(
            str) + " - " + piece_df['author_id']

        users = piece_df['user__id'].unique()
        paints = piece_df['artwork__id'].unique()

        train_data, test_data = train_test_split(
            piece_df, test_size=0.20, random_state=0)
        is_model = item_similarity_recommender_py()
        is_model.create(train_data, piece_df_2, 'user__id', 'author__id')

        user_id = users[user_id]
        user_items = is_model.get_user_items(user_id)

        # Recommend pieces for the user using personalized model
        return is_model.recommend(user_id)

    def post(self, request):
        qs = UserRating.objects.all().values('user__id', 'artwork__id', 'rating')
        piece_df_1 = qs.to_dataframe()
        user_id = request.data["user_id"]
        results = request.data["survey"]
        matrix = []
        for result in results:
            matrix.append([result["piece"], result["score"]])
        results = pandas.DataFrame(
            matrix, columns=["user__id", "artwork__id", "rating"])
        results_total = piece_df_1.append(results)
        recommendations = self.get_recommendation(
            user_id, results_total, piece_df_1)
        pieces = []
        for index, row in recommendations.iterrows():
            pieces.append(row['obra'])
        return HttpResponse(pieces)

class ArtworkList(APIView):

    """
    List all artsworks, or create a new snippet.
    """
    def get(self, request, format=None):
        artworks = Artwork.objects.order_by('?')[:30]
        serializer = ArtworkSerializer(artworks, many=True)
        return Response(serializer.data)
