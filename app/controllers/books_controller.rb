class BooksController < ApplicationController
	protect_from_forgery :except => [:destroy] #これがないとconformでない。deleteの特

	def top
	end

	def create
		@book = Book.new(book_params)
		@books = Book.all

		if  @book.save
			redirect_to book_path(@book.id)
		else
			render :index
		end
	end

	def index
		@book = Book.new
		@books = Book.all
	end

	def show
		@book = Book.find(params[:id] )
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		@book = Book.find(params[:id])    #36行目と同じどこでj
		if @book.update(book_params)
		  redirect_to book_path(@book)
		else
			# @book = Book.find(params[:id])  #ここをついか　renderとリダイレクトto
											#リダイレクトはパスで指定する。
											#renderはアクション名に紐付いたviwen
											#コントローラを経由せずに表示させる。
											#というところで、
											#レンダーと一緒に渡したいデータを上に記述
											#渡したい情報をすげて上に記述する。
											#こだわりがなければ、全部に＠をつける　インスタンス
			render :edit
		end
	end

	def destroy
		book = Book.find(params[:id])
		if book.destroy
		   redirect_to books_path
		end
	end

	private
	def book_params
		params.require(:book).permit(:title, :body)
	end
end