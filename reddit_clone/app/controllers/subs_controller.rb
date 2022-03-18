class SubsController < ApplicationController

  before_action :ensure_moderator, only: [:edit,:update]

  def ensure_moderator
    sub = Sub.find(params[:id])
    redirect_to subs_url unless current_user.id == sub.moderator_id
  end

  def index
    @subs = Sub.all
    render :index
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
    else  
      flash.now[:errors] = @sub.errors.full_messages
    end
    redirect_to subs_url
  end

  def new
    @sub = Sub.new
    render :new
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      
    else  
      flash.now[:errors] = @sub.errors.full_messages
    end
    redirect_to sub_url(@sub)
  end
  
  def destroy
    @sub = Sub.find(params[:id])
    if @sub && @sub.destroy
      redirect_to subs_url
    else
      redirect_to subs_url
    end
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
