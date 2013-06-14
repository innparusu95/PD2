class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :signed_in?

  private
  def signed_in?
    true if session[:oauth_token]
  end 
end
