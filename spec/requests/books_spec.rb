require 'rails_helper'

describe 'Books API', type: :request do  # high level `describe` block, option specify the :type, a `:request` spec. describe contains all tests about Book API and then we have the `it` blocks for specific tests we want to write
  describe 'GET /books' do   # /api/v1/books
    before do  # this `before` block code will get run before every test inside the enclosing `describe block`
      FactoryBot.create(:book, title: '1984', author: 'George Orwell')  # create two books in our test database, this line and below
      FactoryBot.create(:book, title: 'The Good Earth', author: 'Pearl Buck')
    end
    it 'returns all books' do  # this is the actual test, should return all books
      get '/api/v1/books'   # GET request to the index controller, should return all books in system

      expect(response).to have_http_status(:success)  # expected response, checking that it is a 200, ie :success, but this doesn't check that any books are actually being returned, so we need to check the actual response body next, below
      expect(JSON.parse(response.body).size).to eq(2)  # check the number of books in the response body, which at this time should be 2 books. we use JSON.parse to convert response from JSON to something usable by Rspec methods
    end
  end

  describe 'POST /books' do # /api/v1/books
    it 'creates a new book' do
      expect {
        post '/api/v1/books', params: {
          book: { title: 'Nannette & the Baggette' },
          author: { first_name: 'Mo', last_name: 'Willems', age: '44' }
        }
      }.to change { Book.count }.from(0).to(1)  # this line checks for actual book creation, not just checking the response like the line above. Book.count checks number of rows in the test DB

      expect(response).to have_http_status(:created)  # we return status :created in the #create controller action
      expect( Author.count).to eq(1)  # author created with book in this recent change
    end
  end

  describe 'DELETE /api/v1/books' do  # /api/v1/books 
    let!(:book) { FactoryBot.create(:book, title: 'The Good Earth', author: 'Pearl Buck') }  # create a book in test database for this test.  use `let` creates the factory and assigns to book, kinda like before
                # above, withouth the `!` on `let`, the :book is lazy loaded, and isn't there until we hit book.id below.  So `let!` allows us to have 1 book in test DB before test starts
    it 'deletes a book' do
      expect {
        delete "/api/v1/books/#{book.id}"  # interpolation here with the #{ }, so we don't hardcode the id of 1, in `/api/v1/books/1`, for the book created two lines above
      }.to change { Book.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end