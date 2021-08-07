class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order
    @book = Book.new
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def followeds
    @user = User.find(params[:id])
    @followeds = @user.followed_users
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.follower_users
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end

