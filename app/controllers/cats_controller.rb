class CatsController < ApplicationController
  before_filter :require_login, :except => [:index, :show]
  before_filter :authorized, :except => [:index, :show, :new, :create]
  before_filter :set_current_user
  def index
    @cats = Cat.all
    render :index
  end

  def new
    render :new
  end

  def create

    cat = current_user.cats.new(params[:cat])
    if cat.save
      redirect_to cat_url(cat)
    else
      render :text => "Cannot create your cat, sorry. :(",
             :status => :unprocessable_entity
    end
  end

  def show
    @current_user = current_user
    @cat = Cat.find(params[:id])
    render :show
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
      if Cat.update(params[:id], params[:cat])
        redirect_to cat_url(params[:id])
      else
        render :text => "Cannot update your cat, sorry. :(",
               :status => :unprocessable_entity
      end
  end

  def destroy
    cat = Cat.find_by(params[:id])
    if cat.destroy
      redirect_to cats_url
    else
      render :text => "Could not delete cat.", :status => :unprocessable_entity
    end
  end

  protected
  def authorized
    if !current_user.cats.find_by_id(params[:id])
      flash[:status] = "Cannot modify someone else's cat!"
      redirect_to cats_url
    end
  end

  def set_current_user
    @current_user = current_user
  end
end
