class BookRepresenter  # this is a regular Ruby class, for single book
  def initialize(book)  # initialize with books, take single book into the class
    @book = book # assign `books` to instance variable so we can access it inside the class
  end

  def as_json  # returns a hash for a single book
    {
      id: book.id,
      title: book.title,
      author_name: author_name(book),
      author_age: book.author.age
    }
  end  # above, will have an array of ActiveRecord book objects coming in, and will convert them to an array of hashes, which are the objects returned from our API

  private

  attr_reader :book  # attribute reader for letting us access books by .books method, but only available inside the class / private
  
  def author_name(book)
    "#{book.author.first_name} #{book.author.last_name}"
  end
end