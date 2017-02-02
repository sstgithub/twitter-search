require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  describe "GET #navbar_search" do
    it 'makes correct call to method and renders template' do
      twitter_api = double("twitter_api")
      tweet = instance_double("Tweet", text: "test text")
      expect(TwitterApi).to receive(:new).and_return(twitter_api)
      expect(twitter_api).to receive(:find_recent_tweets_for).with("testname").and_return([tweet])
      
      #set credentials for http basic auth
      credentials = ActionController::HttpAuthentication::Basic.encode_credentials("twitter", "tweets")
      request.env["HTTP_AUTHORIZATION"] = credentials

      get :navbar_search, params: {q: "testname"}
      expect(response).to render_template(:navbar_search)
    end
  end
end
