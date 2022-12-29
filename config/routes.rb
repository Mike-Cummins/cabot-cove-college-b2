Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/residents", to: 'residents#index'
  get "/residents/:id", to: 'residents#show'
end

