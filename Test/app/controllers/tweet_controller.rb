class TweetController < ApplicationController
  def input
  end
  
  def update
    if signed_in?
      client = Twitter::Client.new(
        :oauth_token => session[:oauth_token],
        :oauth_token_secret => session[:oauth_token_secret]
      )
      client.update(params[:message])
      @result = :success
    else
      @result = :not_signed_in
    end
  end
end
