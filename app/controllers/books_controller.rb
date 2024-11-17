class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def index
    @user = user_path(current_user)
    @book = Book.new
    @books = Book.all
  end

  def show
    @user = user_path(current_user)

    @book = Book.find(params[:id])
  end
  
  def edit
    is_matching_login_user
    @book = Book.find(params[:id])
  end
  
  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to book_path(book.id)
    else
      @book = book
      render :edit
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    user = User.find(current_user.id)
    unless user.id == current_user.id
      redirect_to books_path
    end
  end
end
