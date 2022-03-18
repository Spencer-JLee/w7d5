class UsersController < ApplicationController

  before_actions :require_logged_in, only: [:show,:index,:update,:destroy]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to users_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end
  
  def index
    @users = User.all
    render :index
  end

  def edit
    @user = User.find(params[:id])
    render :edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update
      redirect_to user_url(@user)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url
  end

  def user_params
    params.require(:user).permit(:username,:password)
  end
end
