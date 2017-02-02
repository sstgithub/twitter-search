class SearchesController < ApplicationController
  def navbar_search
    twitter_api = TwitterApi.new
    @tweets = twitter_api.find_recent_tweets_for(params[:q])
    render 'navbar_search', layout: 'application'
  end
end
