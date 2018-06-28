# -*- coding: utf-8 -*-
from __future__ import unicode_literals

import sys
import time

import numpy as np
import pandas
from django.shortcuts import render
from django.views import View
from sklearn.cross_validation import train_test_split
from sklearn.externals import joblib


class Popularity_recommender_py(View):
    def __init__(self):
        self.train_data = None
        self.user_id = None
        self.item_id = None
        self.popularity_recommendations = None

    # Create the popularity based recommender system model
    def create(self, train_data, user_id, item_id):
        self.train_data = train_data
        self.user_id = user_id
        self.item_id = item_id

        # Get a count of user_ids for each unique piece as recommendation score
        train_data_grouped = train_data.groupby([self.item_id]).agg(
            {self.user_id: 'count'}).reset_index()
        train_data_grouped.rename(columns={'user_id': 'score'}, inplace=True)

        # Sort the pieces based upon recommendation score
        train_data_sort = train_data_grouped.sort_values(
            ['score', self.item_id], ascending=[0, 1])

        # Generate a recommendation rank based upon score
        train_data_sort['Rank'] = train_data_sort['score'].rank(
            ascending=0, method='first')

        # Get the top 10 recommendations
        self.popularity_recommendations = train_data_sort.head(10)

    # Use the popularity based recommender system model to
    # make recommendations
    def recommend(self, user_id):
        user_recommendations = self.popularity_recommendations
        # Add user_id column for which the recommendations are being generated
        user_recommendations['user_id'] = user_id

        # Bring user_id column to the front
        cols = user_recommendations.columns.tolist()
        cols = cols[-1:] + cols[:-1]
        user_recommendations = user_recommendations[cols]

        return user_recommendations


# Class for Item similarity based Recommender System model
class Item_similarity_recommender_py(View):
    def __init__(self):
        self.train_data = None
        self.user_id = None
        self.item_id = None
        self.metadata = None
        self.cooccurence_matrix = None
        self.item_similarity_recommendations = None

    # Get unique items (pieces) corresponding to a given user
    def get_user_items(self, user):
        user_data = self.train_data[self.train_data[self.user_id] == user]
        user_items = list(user_data[self.item_id].unique())

        return user_items

    # Get unique users for a given item (piece)
    def get_item_users(self, item):
        item_data = self.train_data[self.train_data[self.item_id] == item]
        item_users = set(item_data[self.user_id].unique())

        return item_users

    # Get unique items (pieces) in the training data
    def get_all_items_train_data(self):
        all_items = list(self.train_data[self.item_id].unique())

        return all_items

    # Construct cooccurence matrix
    def construct_cooccurence_matrix(self, user_pieces, all_pieces):
        ####################################
        # Get users for all pieces in user_pieces.
        ####################################
        user_pieces_users = []
        for i in range(0, len(user_pieces)):
            user_pieces_users.append(self.get_item_users(user_pieces[i]))
        ###############################################
        # Initialize the item cooccurence matrix of size
        # len(user_pieces) X len(pieces)
        ###############################################
        cooccurence_matrix = np.matrix(
            np.zeros(shape=(len(user_pieces), len(all_pieces))), float)

        #############################################################
        # Calculate similarity between user pieces and all unique pieces
        # in the training data
        #############################################################
        for i in range(0, len(all_pieces)):
            # Calculate unique listeners (users) of piece (item) i
            pieces_i_data = self.train_data[self.train_data[self.item_id]
                                            == all_pieces[i]]
            users_i = set(pieces_i_data[self.user_id].unique())
            for j in range(0, len(user_pieces)):
                # Get unique listeners (users) of piece (item) j
                users_j = user_pieces_users[j]
                genero1 = self.metadata[self.metadata[self.item_id]
                                        == all_pieces[i]]['genero'].values[0]
                genero2 = self.metadata[self.metadata[self.item_id]
                                        == user_pieces[j]]['genero'].values[0]
                autor1 = self.metadata[self.metadata[self.item_id]
                                       == all_pieces[i]]['autor'].values[0]
                autor2 = self.metadata[self.metadata[self.item_id]
                                       == user_pieces[j]]['autor'].values[0]
                # Calculate intersection of listeners of pieces i and j
                users_intersection = users_i.intersection(users_j)
                if genero1 == genero2 and autor1 == autor2:
                    metadata_weight = 1
                elif genero1 == genero2 or autor1 == autor2:
                    metadata_weight = 0.5
                else:
                    metadata_weight = 0
                # Calculate cooccurence_matrix[i,j] as Jaccard Index
                if len(users_intersection) != 0:
                    # Calculate union of listeners of pieces i and j
                    users_union = users_i.union(users_j)
                    cooccurence_matrix[j, i] = (
                        float(len(users_intersection)) / float(len(users_union)) + metadata_weight) / 2
                else:
                    cooccurence_matrix[j, i] = metadata_weight / 2

        np.savetxt('concurrencia.csv', cooccurence_matrix, delimiter=',')
        return cooccurence_matrix

    # Use the cooccurence matrix to make top recommendations
    def generate_top_recommendations(self, user, cooccurence_matrix, all_pieces, user_pieces):
        print("Non zero values in cooccurence_matrix :%d" %
              np.count_nonzero(cooccurence_matrix))

        # Calculate a weighted average of the scores in cooccurence matrix for all user pieces.
        user_sim_scores = cooccurence_matrix.sum(
            axis=0) / float(cooccurence_matrix.shape[0])
        user_sim_scores = np.array(user_sim_scores)[0].tolist()

        # Sort the indices of user_sim_scores based upon their value
        # Also maintain the corresponding score
        sort_index = sorted(((e, i) for i, e in enumerate(
            list(user_sim_scores))), reverse=True)

        # Create a dataframe from the following
        columns = ['user_id', 'obra', 'score', 'rank']
        # index = np.arange(1) # array of numbers for the number of samples
        df = pandas.DataFrame(columns=columns)

        # Fill the dataframe with top 10 item based recommendations
        rank = 1
        for i in range(0, len(sort_index)):
            if ~np.isnan(sort_index[i][0]) and all_pieces[sort_index[i][1]] not in user_pieces and rank <= 10:
                df.loc[len(df)] = [user, all_pieces[sort_index[i][1]],
                                   sort_index[i][0], rank]
                rank = rank + 1

        # Handle the case where there are no recommendations
        if df.shape[0] == 0:
            print(
                "The current user has no pieces for training the item similarity based recommendation model.")
            return -1
        else:
            return df

    # Create the item similarity based recommender system model
    def create(self, train_data, metadata, user_id, item_id):
        self.train_data = train_data
        self.metadata = metadata
        self.user_id = user_id
        self.item_id = item_id

    # Use the item similarity based recommender system model to
    # make recommendations
    def recommend(self, user):

        ########################################
        # A. Get all unique pieces for this user
        ########################################
        user_pieces = self.get_user_items(user)

        print("No. of unique pieces for the user: %d" % len(user_pieces))

        ######################################################
        # B. Get all unique items (pieces) in the training data
        ######################################################
        all_pieces = self.get_all_items_train_data()

        print("no. of unique pieces in the training set: %d" % len(all_pieces))

        ###############################################
        # C. Construct item cooccurence matrix of size
        # len(user_pieces) X len(pieces)
        ###############################################
        cooccurence_matrix = self.construct_cooccurence_matrix(
            user_pieces, all_pieces)

        #######################################################
        # D. Use the cooccurence matrix to make recommendations
        #######################################################
        df_recommendations = self.generate_top_recommendations(
            user, cooccurence_matrix, all_pieces, user_pieces)

        return df_recommendations

    # Get similar items to given items
    def get_similar_items(self, item_list):

        user_pieces = item_list

        ######################################################
        # B. Get all unique items (pieces) in the training data
        ######################################################
        all_pieces = self.get_all_items_train_data()

        print("no. of unique pieces in the training set: %d" % len(all_pieces))

        ###############################################
        # C. Construct item cooccurence matrix of size
        # len(user_pieces) X len(pieces)
        ###############################################
        cooccurence_matrix = self.construct_cooccurence_matrix(
            user_pieces, all_pieces)

        #######################################################
        # D. Use the cooccurence matrix to make recommendations
        #######################################################
        user = ""
        df_recommendations = self.generate_top_recommendations(
            user, cooccurence_matrix, all_pieces, user_pieces)

        return df_recommendations

def get_recommendation(piece_df_1,user_id):

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
    piece_df['obraautor'] = piece_df['nombre'].map(str) + " - " + piece_df['autor']

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
    # for index, row in recommendations.iterrows():
    #     print row['obra']
    # print recommendations

def registry_survey(request):
    triplets_file = 'data/train_data.csv'
    piece_df_1 = pandas.read_csv(triplets_file, header=0)
    user_id = request.POST["usert_id"]
    results = request.POST["survey"]
    matrix = []
    for result in results:
        matrix.append([result["piece"],result["score"]])
    results = pandas.DataFrame(matrix,columns=["usuario","obra","puntuacion"])
    results_total = piece_df_1.append(results)
    recommendations = get_recommendation(user_id,results_total)
    pieces = []
    for index, row in recommendations.iterrows():
        pieces.append(row['obra'])
    return HttpResponse(pieces)
