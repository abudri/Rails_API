Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # get '/books' => 'books' # URL mapped to a controller/endpoint.  Add new API endpoint for listing books. hardcoded style
  # nicer way below
  resources :books, only: [:index,:create, :destroy] # `resources` generates all 7 RESTful resources, unless you do the `only:` part
end
