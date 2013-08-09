class UsersController < ApplicationController
  def create
    user = User.new(params[:user])
    if user.save
      redirect_to new_session_url
    else
      render :text => "Registration failed.", :status => :unprocessable_entity
    end
  end

  def new
    render :new
  end

end
