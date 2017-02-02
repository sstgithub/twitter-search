require 'rails_helper'

RSpec.describe TwitterApi, type: :model do
  describe "#find_recent_tweets_for" do
    before :each do
      @client = double("client")
      allow(Twitter::REST::Client).to receive(:new).and_return(@client)
    end

    it "finds recent tweets for username (defaults to 25 most recent)" do
      allow(@client).to receive(:user_timeline).with("testname", count: 25).and_return(file_fixture('statuses.json').read)
      expect(TwitterApi.new.find_recent_tweets_for("testname")).to eq(file_fixture('statuses.json').read)
    end

    it "returns an error if the username does not exist" do
      allow(@client).to receive(:user_timeline).with("testname", count: 25).and_raise(Twitter::Error::NotFound)
      expect(TwitterApi.new.find_recent_tweets_for("testname")).to eq({error: "This user does not exist, please try again!"})
    end

    it "returns an error if there are no tweets on the user's account" do
      allow(@client).to receive(:user_timeline).with("testname", count: 25).and_return([])
      expect(TwitterApi.new.find_recent_tweets_for("testname")).to eq({error: "This user has no tweets!"})
    end
  end
end
