class SearchesController < ApplicationController
  def navbar_search
    twitter_api = TwitterApi.new
    cache_key = ["timeline", params[:q]]
    @tweets = Rails.cache.fetch(cache_key, expires_in: 5.minutes) do
      twitter_api.find_recent_tweets_for(params[:q])
    end
    render 'navbar_search', layout: 'application'
  end
end
