require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  end
  
  get '/' do
    #send user to homepage where they can sign up or log in
    erb :index
end

helpers do

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end

#   You'll need to make sure that no one can create, read,
#    edit or delete any tweets unless they're logged in.

# You'll want to create two helper methods current_user and
#  logged_in?. You'll want to use these helper methods to
#   block content if a user is not logged in.

# It's especially important that a user should not be able 
# to edit or delete the tweets created by a different user.
#  A user can only modify their own tweets.


end
