Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # get '/books' => 'books' # URL mapped to a controller/endpoint.  Add new API endpoint for listing books. hardcoded style
  # nicer way below
  resources :books, only: :index # `resources` generates all 7 RESTful resources, unless you do the `only: :index` portion
  # At this point, above is the `:books` controller, and `:index` is the only #action at this time
end
