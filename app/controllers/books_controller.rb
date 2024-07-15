class BooksController < ApplicationController
  def index
    @book = Book.new
    @books = Book.all
    @users = User.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id)
    else
    @books = Book.all
    @user = User.find(current_user.id)
      render :index
      return
    end
  end

  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    redirect_to book_path(@book.id)
    else
    @books = Book.all
    @user = User.find(current_user.id)
      render :edit
      return
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :opinion)
  end
end

