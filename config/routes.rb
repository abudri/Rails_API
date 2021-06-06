Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :books, only: [:index,:create, :destroy] # `resources` generates all 7 RESTful resources, unless you do the `only:` part
    end
  end
end
