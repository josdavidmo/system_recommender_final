# -*- coding: utf-8 -*-
from __future__ import unicode_literals
from django_pandas.managers import DataFrameManager
from django.contrib.auth.models import User

from django.db import models

class Author(models.Model):
    name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)
    objects = DataFrameManager()

class Gender(models.Model):
    name = models.CharField(max_length=50)
    objects = DataFrameManager()

class Artwork(models.Model):
    title = models.CharField(max_length=255)
    url = models.URLField()
    author = models.ForeignKey(Author)
    gender = models.ForeignKey(Gender)
    objects = DataFrameManager()

class UserRating(models.Model):
    user = models.ForeignKey(User)
    artwork = models.ForeignKey(Artwork)
    rating = models.IntegerField()
    objects = DataFrameManager()
