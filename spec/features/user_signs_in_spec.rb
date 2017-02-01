require 'spec_helper'

feature 'User visits page and enters username and password for basic http auth' do
  scenario 'renders page' do
    visit root_url
    
  end
end
