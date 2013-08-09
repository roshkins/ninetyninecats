class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_username_and_password(*params[:user].values)
    if user
      user.set_token
      session[:token] = user.session_token
      redirect_to cats_url
    else
      flash[:status] = "No soup for you!"
      redirect_to new_session_url
    end
  end

  def destroy
    session[:token] = nil

    redirect_to new_session_url
  end

end
