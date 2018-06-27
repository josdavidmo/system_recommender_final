# -*- coding: utf-8 -*-
from __future__ import unicode_literals
from models import Artwork
import pandas
import numpy as np
from rest_framework.views import APIView
from sklearn.cross_validation import train_test_split

from utils import Recommenders


class Recommendation(APIView):
    """
    used to manage users recommendations
    """

    def get_recommendation(self, piece_df_1, user_id):

        # Read userid-pieceid-listen_count triplets
        # This step might take time to download data from external sources
        triplets_file = 'data/train_data.csv'
        pieces_metadata_file = 'data/metadata.csv'

        # Read piece  metadata
        piece_df_2 = pandas.read_csv(pieces_metadata_file, header=0)
        piece_df_2['obraautor'] = piece_df_2['nombre'].map(
            str) + " - " + piece_df_2['autor']
        # Merge the two dataframes above to create input dataframe for recommender systems
        piece_df = pandas.merge(piece_df_1, piece_df_2, on="obra", how="left")
        # Merge piece title and artist_name columns to make a merged column
        piece_df['obraautor'] = piece_df['nombre'].map(
            str) + " - " + piece_df['autor']

        users = piece_df['usuario'].unique()
        paints = piece_df['obra'].unique()

        train_data, test_data = train_test_split(
            piece_df, test_size=0.20, random_state=0)
        is_model = Recommenders.item_similarity_recommender_py()
        is_model.create(train_data, piece_df_2, 'usuario', 'obra')

        user_id = users[user_id]
        user_items = is_model.get_user_items(user_id)

        # Recommend pieces for the user using personalized model
        return is_model.recommend(user_id)

    def post(self, request):
        pieces = UserRating.objects.all().values('user__full_name', 'artwork__url', 'rating')
        piece_df_1 = pandas.read_csv(triplets_file, header=0)
        user_id = request.data["user_id"]
        results = request.data["survey"]
        matrix = []
        for result in results:
            matrix.append([result["piece"], result["score"]])
        results = pandas.DataFrame(
            matrix, columns=["usuario", "obra", "puntuacion"])
        results_total = piece_df_1.append(results)
        recommendations = self.get_recommendation(user_id, results_total)
        pieces = []
        for index, row in recommendations.iterrows():
            pieces.append(row['obra'])
        return HttpResponse(pieces)
