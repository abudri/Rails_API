class BooksController < ApplicationController
  def index
    render json: Book.all
  end

  def create
    # Book.create(title: 'Harry Potter 1', author: 'JK Rowling') # this approach creates it withoutvalidating the parameters
    book = Book.new(title: params[:title], author: params[:author])  # this creates the object, but doesn't save to DB yet, allows us to validate parameters
    if book.save
      render json: book, status: :created # this renders JSON of object back, you could also just say success here too with no body with JSON
                                 # default success is 200, but we have a more specific one, a 201 response for record successfully created, so we use ``:created` above
    else
      render json: book.errors, status: :unprocessable_entity # :unprocessable_entity is for a 422, server understands request, unable to process instructions (parameters were wrong)
    end
  end

  private

  def book_params
    params.require(:book).permit(:author, :title)  # params method is made available by ApplicationController
    # above allows :title and :author parameters to be POSTed, but no others
  end
end
