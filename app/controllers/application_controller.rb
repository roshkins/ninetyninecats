class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    User.find_by_session_token(session[:token])
  end

  protected

  def require_login
    if session[:token].nil? #|| !User.find_by_session_token(session[:token])
      redirect_to new_session_url
    end
    @current_user = current_user
  end




end
