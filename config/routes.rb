Rails.application.routes.draw do
  resources :posts do
    member do
      patch 'upvote'
      patch 'downvote'
      get 'comments'
    end
  end
  resources :users
  resources :comments


end
