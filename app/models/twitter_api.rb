class TwitterApi
  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["twitter_consumer_key"]
      config.consumer_secret     = ENV["twitter_consumer_secret"]
      config.access_token        = ENV["twitter_access_token"]
      config.access_token_secret = ENV["twitter_access_token_secret"]
    end
  end

  def find_recent_tweets_for(username, num = 25)
    #parse with or without @ at beginning
    recent_tweets = @client.user_timeline(username, count: num)
    if recent_tweets.blank?
      {error: "This user has no tweets!"}
    else
      recent_tweets
    end
  rescue Twitter::Error::NotFound
    {error: "This user does not exist, please try again!"}
  end
end
