require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "i2875th8ow3rhgwk"
  end

  get '/' do
    erb :welcome
  end

  get '/signup' do
    redirect_if_logged_in
    erb :"users/new"
  end

  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    redirect_if_logged_in
    erb :login
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if is_logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  helpers do
    def is_logged_in?
      !!session[:user_id]
    end

    def current_user
      @user ||= User.find(session[:user_id])
    end

    def redirect_if_logged_in
      redirect '/tweets' if is_logged_in?
    end

    def redirect_if_not_logged_in
      redirect '/login' if !is_logged_in?
    end
  end

end
