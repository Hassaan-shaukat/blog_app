Rails.application.routes.draw do
  devise_for :users

  resources :posts
  resource :likes, only: [:create]

  root "posts#index"
end
