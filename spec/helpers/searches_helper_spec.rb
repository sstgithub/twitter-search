require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SearchesHelper. For example:
#
# describe SearchesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SearchesHelper, type: :helper do
  describe "parse tweets" do
    it "parse links and mentions" do
      text_with_links_and_mentions = "This is a tweet with a @mention, @here,and @here. and a double mention @like@this and a link here https://t.co/something"
      properly_parsed_text = "This is a tweet with a <a href='https://twitter.com/mention' target='blank'>@mention</a>, <a href='https://twitter.com/here' target='blank'>@here</a>,and <a href='https://twitter.com/here' target='blank'>@here</a>. and a double mention <a href='https://twitter.com/like' target='blank'>@like</a><a href='https://twitter.com/this' target='blank'>@this</a> and a link here <a href=\"https://t.co/something\" target=\"_blank\">https://t.co/something</a>"
      expect(helper.parse_links_and_mentions_for(text_with_links_and_mentions)).to eq(properly_parsed_text)
    end
  end

  describe "api call error?" do
    it "returns false for successful api call which returns array" do
      assign(:tweets, ["random arr"])
      expect(helper.api_call_returned_error?).to be_falsy
    end

    it "returns true for unsuccessful api call which returns custom hash" do
      assign(:tweets, {error: "random err"})
      expect(helper.api_call_returned_error?).to be_truthy
    end
  end
end
