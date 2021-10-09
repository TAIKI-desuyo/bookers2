class BooksController < ApplicationController
  before_action :authenticate_user!
  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
    @book_comment = BookComment.new
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user

  end


  def new
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end

   def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
    @books =Book.all
    if @book.save
    flash[:success] = "You have created book successfully."
    redirect_to book_path(@book.id)
    else
    render :index
    end
   end


  def update
    @book =Book.find(params[:id])
  if @book.update(book_params)
    flash[:success] = "You have updated book successfully."
    redirect_to book_path(@book.id)
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

  def book_params
    params.require(:book).permit(:title, :body,)
  end
end
