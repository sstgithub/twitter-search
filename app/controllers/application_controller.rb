class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  http_basic_authenticate_with name: 'showmethe', password: 'tweets'

  def index
    render html: "Search for a username to see something here", layout: 'application'
  end

  def navbar_search
    render 'navbar_search', layout: 'application'
  end
end
