"""
system_recommender URL Configuration
"""

from django.conf.urls import url


from system_recommender import views
from system_recommender.api import ArtworkList
from system_recommender.api import RecommendationList

urlpatterns = [
    url(r'^artworks/$', ArtworkList.as_view()),
    url(r'^recommendations/$', RecommendationList.as_view()),
    url(r'^registry_survey$', views.registry_survey, name='registry-survey')
]
