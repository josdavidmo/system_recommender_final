# -*- coding: utf-8 -*-
from __future__ import unicode_literals

import numpy as np
import pandas
from django.contrib.auth.models import User
from django.http import JsonResponse
from rest_framework.response import Response
from rest_framework.views import APIView
from sklearn.cross_validation import train_test_split

from models import Artwork, UserRating
from serializers import ArtworkSerializer
from utils import item_similarity_recommender_py


class RecommendationList(APIView):

    """
    used to manage users recommendations
    """

    def get_recommendation(self, piece_df_1, user_id):
        # Read piece metadata
        qs = Artwork.objects.all().extra(select={'artwork__id': 'id'}).values(
            'artwork__id', 'title', 'url', 'author__id', 'gender__id')
        piece_df_2 = qs.to_dataframe()
        piece_df_2['artwork__id'] = piece_df_2['artwork__id'].map(str)
        piece_df_2['obraautor'] = piece_df_2['artwork__id'].map(
            str) + " - " + piece_df_2['author__id'].map(str)
        # Merge the two dataframes above to create input dataframe for recommender systems
        piece_df = pandas.merge(piece_df_1, piece_df_2,
                                on="artwork__id", how="left")
        # Merge piece title and artist_name columns to make a merged column
        piece_df['obraautor'] = piece_df['artwork__id'].map(
            str) + " - " + piece_df['author__id'].map(str)

        train_data, test_data = train_test_split(
            piece_df, test_size=0.20, random_state=0)
        is_model = item_similarity_recommender_py()
        is_model.create(train_data, piece_df_2, 'user__id', 'artwork__id')

        user_items = is_model.get_user_items(user_id)
        # Recommend pieces for the user using personalized model
        return is_model.recommend(user_id)

    def post(self, request):
        qs = UserRating.objects.all().values('user__id', 'artwork__id', 'rating')
        piece_df_1 = qs.to_dataframe()
        username = request.data["user_id"]
        user, created = User.objects.get_or_create(username=username)
        user.set_password(username)
        user.save()
        results = request.data["survey"]
        matrix = []
        for result in results:
            userRating = UserRating()
            userRating.user = user
            userRating.artwork_id = result["piece"]
            userRating.rating = result["score"]
            userRating.save()
            matrix.append([user.id, result["piece"], result["score"]])
        results = pandas.DataFrame(
            matrix, columns=["user__id", "artwork__id", "rating"])
        results_total = piece_df_1.append(results)
        recommendations = self.get_recommendation(results_total, user.id)
        pieces = []
        for index, row in recommendations.iterrows():
            pieces.append(int(row['obra']))
        artworks = Artwork.objects.filter(id__in=pieces)
        serializer = ArtworkSerializer(artworks, many=True)
        return Response(serializer.data)


class ArtworkList(APIView):

    """
    List all artworks.
    """

    def get(self, request, format=None):
        artworks = Artwork.objects.order_by('?')[:30]
        serializer = ArtworkSerializer(artworks, many=True)
        return Response(serializer.data)
