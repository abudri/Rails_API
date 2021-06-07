module Api
  module V1
    class BooksController < ApplicationController
      def index
        books = Book.all

        render json: BooksRepresenter.new(books).as_json # as_json, convention for returning Ruby hash that is ready to be converted to JSON by the controller, takes hash and return to API clicent
      end

      def create
        # Book.create(title: 'Harry Potter 1', author: 'JK Rowling') # this approach creates it withoutvalidating the parameters
        book = Book.new(book_params)  # this creates the object, but doesn't save to DB yet, allows us to validate parameters
        if book.save
          render json: book, status: :created # this renders JSON of object back, you could also just say success here too with no body with JSON
                                    # default success is 200, but we have a more specific one, a 201 response for record successfully created, so we use ``:created` above
        else
          render json: book.errors, status: :unprocessable_entity # :unprocessable_entity is for a 422, server understands request, unable to process instructions (parameters were wrong)
        end
      end

      def destroy
        Book.find(params[:id]).destroy!  # ActiveRecord Books model has a method given called `.find` which takes an id. From route book DELETE /books/:id(.:format), books#destroy
                              # destroy!, the ! will return true of successful, and will give an exception if not, which we handle later
        head :no_content # `head` doesn't give JSON, but returns a status code in head of the response but no body, :no_content is a 204 status code
      end

      private

      def book_params
        params.require(:book).permit(:title, :author)  # params method is made available by ApplicationController
        # above allows :title and :author parameters to be POSTed, but no others
      end
    end
  end
end