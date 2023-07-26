Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "slides#index"

  resources :slides, only: :index
  get :start, to: "slides#start"
end
