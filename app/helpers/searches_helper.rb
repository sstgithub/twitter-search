module SearchesHelper
  def parse_links_and_mentions_for(tweet)
    parse_mentions_for(Rinku.auto_link(tweet, :all, 'target="_blank"'))
  end

  def api_call_returned_error?
    @tweets.is_a?(Hash) && @tweets[:error]
  end

  def parse_mentions_for(tweet)
    mentions_arr = tweet.split("@")
    #return if no mentions in the tweet
    return tweet if mentions_arr.count == 1
    #the first word of each str in mentions_arr except the first is a mention
    parsed_str = mentions_arr.delete(mentions_arr.first)
    #put a tags around each mention
    mentions_arr.each do |str|
      #splits on any character not allowed in a twitter username (non alphanumeric characters)
      first_non_twitter_username_char = str.scan(/\W/).first
      split_str = str.split(first_non_twitter_username_char)
      first_word_of_str = split_str[0]
      #edge case: if nil then @mention directly after this @mention
      if first_non_twitter_username_char
        rest_of_str = first_non_twitter_username_char + split_str[1..-1].join(first_non_twitter_username_char)
        #add first_non_twitter_username_char to end if str originally ended with that char since split removes it
        if str.last == first_non_twitter_username_char
          rest_of_str += first_non_twitter_username_char
        end
      else
        rest_of_str = ""
      end
      parsed_str += "<a href='https://twitter.com/#{first_word_of_str}' target='blank'>@#{first_word_of_str}</a>#{rest_of_str}"
    end
    parsed_str
  end
end
