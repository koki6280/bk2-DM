class UsersController < ApplicationController
    before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @current_entry = Entry.where(user_id: current_user.id)
    @anothet_entry = Entry.where(user_id: @user.id)
    
    unless @user.id == current_user.id
      @current_entry.each do |current|
        @anothet_entry.each do |another|
          if current.room_id == another.room_id
            @is_roomn = true
            @room_id = current.room_id
          end
        end
      end

      unless @is_roomn
        @room = Room.new
        @entry = Entry.new
      end
    end
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
      @user = User.find(params[:id])
      user = current_user
    if
      @user.id == current_user.id
      render action: :edit
    else
      redirect_to user_path(user.id)
    end
  end

  def update
       @user = User.find(params[:id])
    if @user.update(user_params)
       redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
       render action: :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end