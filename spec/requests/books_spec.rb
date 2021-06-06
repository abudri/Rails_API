require 'rails_helper'

describe 'Books API', type: :request do  # high level `describe` block, option specify the :type, a `:request` spec. describe contains all tests about Book API and then we have the `it` blocks for specific tests we want to write
  it 'returns all books' do  # this is the actual test, should return all books
    FactoryBot.create(:book, title: '1984', author: 'George Orwell')  # create two books in our test database, this line and below
    FactoryBot.create(:book, title: 'The Good Earth', author: 'Pearl Buck')

    get '/api/v1/books'   # GET request to the index controller, should return all books in system

    expect(response).to have_http_status(:success)  # expected response, checking that it is a 200, ie :success, but this doesn't check that any books are actually being returned, so we need to check the actual response body next, below
    expect(JSON.parse(response.body).size).to eq(2)  # check the number of books in the response body, which at this time should be 2 books. we use JSON.parse to convert response from JSON to something usable by Rspec methods
  end
end