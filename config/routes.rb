Rails.application.routes.draw do
  resources :posts
  resources :users
  resources :comments
end
