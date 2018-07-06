# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.contrib.auth.models import User
from django.db import models
from django_pandas.managers import DataFrameManager


class Author(models.Model):
    """
    used to manage artworks authors
    """
    name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)
    objects = DataFrameManager()


class Gender(models.Model):
    """
    used to sort out artworks
    """
    name = models.CharField(max_length=50)
    objects = DataFrameManager()


class Artwork(models.Model):
    """
    used to represent an artwork
    """
    title = models.CharField(max_length=255)
    url = models.URLField()
    author = models.ForeignKey(Author)
    gender = models.ForeignKey(Gender)
    objects = DataFrameManager()


class UserRating(models.Model):
    """
    used to rating the artwork
    """
    user = models.ForeignKey(User)
    artwork = models.ForeignKey(Artwork)
    rating = models.IntegerField()
    objects = DataFrameManager()
