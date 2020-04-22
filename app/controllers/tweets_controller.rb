class TweetsController < ApplicationController
  
  get '/tweets' do 
    if logged_in?
      @user=current_user
      @tweets=Tweet.all 
      erb :'/tweets/index'
    else 
      redirect '/login'
    end 
  end 
  
  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else 
      redirect '/login'
    end 
  end 
  
  post '/tweets' do
    if params[:content].empty?
      redirect '/tweets/new'
    else 
      @user=current_user
      @tweet=current_user.tweets.create(params)
      redirect "/tweets/#{@tweet.id}"
      
    end 
  end 
  
  get '/tweets/:id' do 
    
    if logged_in?
      @user=current_user
      @tweet=Tweet.find_by_id(params[:id])
      erb :'/tweets/show'
    else 
      redirect '/login'
    end 
  end 
  
  get '/tweets/:id/edit' do 
    if logged_in?
      @tweet=Tweet.find_by_id(params[:id])
      erb:'tweets/edit'
    else 
      redirect '/login'
    end 
  end 
  
  patch '/tweets/:id' do 
    @tweet=Tweet.find(params[:id])
    if @tweet.user == current_user 
      if !params[:content].empty?
        @tweet.update(:content=>params[:content])
        redirect "tweets/#{@tweet.id}"
      else 
        redirect "/tweets/#{params[:id]}/edit"
      end 
    else 
      redirect "/login"
    end 
  end 
  
  
  delete '/tweets/:id/delete' do 
   
    if logged_in?
      @tweet=Tweet.find_by(params[:id])
      if @tweet.user==current_user
        @tweet.delete
        redirect '/tweets'
      else 
        redirect '/login'
      end 
    else 
      redirect '/login'
    end 
  end 

end
