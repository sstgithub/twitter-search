# README

## App Info
- Heroku Website: https://secret-waters-84335.herokuapp.com/
- HTTP auth username: twitter
- HTTP auth password: tweets

## Local environment setup
1. Install rails and download github directory
2. Run `bundle install`
3. Run `rails s` to start the rails server
4. Go to `localhost:3000` and use search bar to search for tweets


## Running tests
- `bundle exec rspec`

## Design decisions
- I did this TDD style (though not complete coverage) and implemented caching and parse mentions and links for the tweet texts
- The basic flow is:
  1. User searches on index page or from another search page
  2. The search param is passed to `SearchesController#navbar_search`
  3. `navbar_search` method uses the `TwitterApi model` methods, which first initializes a Twitter::REST::API object using the twitter gem, to do a call to the Twitter API and obtain the last 25 tweets. Error handling is in place in case the user doesn't exist or the user doesn't have any tweets.
  4. The tweets are rendered in the `navbar_search` view which uses the link and mentions parsing methods in `searches_helper` to display each tweet text properly
- Used gems where it made sense like the official twitter ruby gem which is up to date with the normal REST API that twitter provides
- Used an automatic link parser for hyperlinks (Rinku gem)
- Note: My text parser does not currently parse the proper links for emails (due to the "@" which gets parsed as a mention). This would be a fairly easy fix since the gem I use for links also parses emails; I would just have to add logic to have my mentions parser ignore anything within a mail tag in the string.
