class TweetsController < ApplicationController
  
  get '/tweets' do
    redirect_if_not_logged_in
    @tweets = Tweet.all
    erb :"tweets/index"
  end

  get '/tweets/new' do
    redirect_if_not_logged_in
    erb :'tweets/new'
  end

  post '/tweets' do
    if !params[:content].empty?
      @tweet = Tweet.create(content: params[:content], user: current_user)
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id' do
    redirect_if_not_logged_in
    @tweet = Tweet.find(params[:id])
    erb :"tweets/show"
  end

  get '/tweets/:id/edit' do
    redirect_if_not_logged_in
    @tweet = Tweet.find(params[:id])
    if @tweet.user == current_user
      erb :"tweets/edit"
    else
      redirect "/tweets"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if !params[:content].empty?
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end 
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.destroy if @tweet.user == current_user
    redirect '/tweets'
  end

end
