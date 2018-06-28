"""
system_recommender URL Configuration
"""

from django.conf.urls import url

from system_recommender import views

urlpatterns = [
    url(r'^registry_survey$', views.registry_survey,
        name='registry-survey'),
        ]
