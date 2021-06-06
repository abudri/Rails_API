class ApplicationController < ActionController::API
  # code in here is for use in any of our own custom controllers we made, since they inherit from ApplicationController, ie meaning like BooksController
  rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed # not_destroyed is a private method

  private 

  def not_destroyed(e)
    render json: { errors: e.record.errors }, status: :unprocessable_entity # now when `.destroy!` a few lines up fails, rather than just giving an error, we capture error and raise a response back to user with status code telling them request they formed was correct, but we were not not able perform the operation
  end
end
