class CatRentalRequestsController < ApplicationController
  before_filter :require_login
  def new
    render :new
  end

  def create
    params[:cat_rental_request][:status] = "undecided"
    cat_rental_request = CatRentalRequest.new(params[:cat_rental_request])
    if cat_rental_request.save
      redirect_to cat_url(params[:cat_rental_request][:cat_id])
    else
      render :text => "Cannot rent this cat", :status => :unprocessable_entity
    end
  end


  def update
    cat_request = CatRentalRequest.find_by_id(params[:id])
    if @current_user.cats.include?(cat_request.cat)

      if params[:cat_rental_request][:status] == "approved"
        cat_request.approve
      elsif params[:cat_rental_request][:status] == "declined"
        cat_request.decline
      end
      redirect_to cat_url(cat_request.cat_id)
    else
      flash[:status] = "You can't rent out somebody else's cat. You cheater!"
      redirect_to :back
    end

  end


end
