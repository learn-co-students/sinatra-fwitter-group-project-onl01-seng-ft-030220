class TweetsController < ApplicationController


    get '/tweets' do
        if logged_in?
           
            @tweets = Tweet.all 
        erb :'tweets/tweets'
        else 
            redirect to '/login'
        end
        #create a view that will display all tweets for the logged in user and other users. 
        # If a user is not logged in, it will redirect to /login.
    end

    get '/tweets/new' do
        if logged_in?
        erb :'/tweets/create_tweet'
        else
            redirect '/login'
        end
        # load the create tweet form
    end

    post '/tweets' do 
        if params[:content] == ""
            redirect to '/tweets/new'
        else
        @tweet = current_user.tweets.build(content: params[:content])
        if @tweet.save
          redirect to "/tweets/#{@tweet.id}"
        else
          redirect to "/tweets/new"
        end
        end
        #process the form submission
        #The tweet should be created and saved to the database
    end

    get '/tweets/:id' do 
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            erb :'tweets/show_tweet'
          else
            redirect to '/login'
          end
    end

    get '/tweets/:id/edit' do
       
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
        if @tweet && @tweet.user == current_user
            
            erb :'tweets/edit_tweet'
        else
            redirect to '/tweets'
          end
        else
            redirect to '/login'
        end
        # load the form to edit 
    end

    patch '/tweets/:id' do
        if logged_in?
            if params[:content] == ""
              redirect to "/tweets/#{params[:id]}/edit"
            else
              @tweet = Tweet.find_by_id(params[:id])
              if @tweet && @tweet.user == current_user
                if @tweet.update(content: params[:content])
                  redirect to "/tweets/#{@tweet.id}"
                else
                  redirect to "/tweets/#{@tweet.id}/edit"
                end
              else
                redirect to '/tweets'
              end
            end
          else
            redirect to '/login'
        end
    end
      

    delete '/tweets/:id/delete' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet && @tweet.user == current_user
                @tweet.delete
            end
              redirect to '/tweets'
        else
            redirect to '/login'
        end
        #The form to delete a tweet should be found on the tweet show page.
        #The delete form doesn't need to have any input fields, just a submit button.
    end
end

