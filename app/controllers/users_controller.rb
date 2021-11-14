class UsersController < ApplicationController
  before_action :authenticate_user!


  def index
    @users = User.all
    @user = User.find(current_user.id)
    @book = Book.new
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = Book.where(user_id: params[:id])
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render action: :edit
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user info successfully."
      redirect_to user_path(@user.id)
    else
      session[:error] = @user.errors.full_messages
      render action: :edit

      #redirect_back(fallback_location: root_path)
    end

  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
