class UsersController < ApplicationController
 before_action :authenticate_user!

    def index
      @users = User.all
      @user = current_user
      @book = Book.new
    end

    def show
     @user = User.find(params[:id])
     @books = @user.books
     @book = Book.new

    end

    def new
     @book = Book.new
    end

    def create

       @book = Book.new(book_params)
    if @book.save
     redirect_to book_path(@book.id)
    else
       @books = Book.all
     render :index
    end
    end

    def edit
     @user = User.find(params[:id])
     if @user == current_user
      render :edit
     else
     redirect_to current_user
     end
    end



    def update
     @user = User.find(params[:id])
    if@user.update(user_params)
     flash[:success] = "You have updated user successfully."
     redirect_to user_path(@user.id)
    else
      render :edit
    end
    end



     def destroy
     @book = Book.find(params[:id])
     @book.destroy
     redirect_to books_path
     end

     private

    def user_params
     params.require(:user).permit(:name, :profile_image, :introduction)
    end



end