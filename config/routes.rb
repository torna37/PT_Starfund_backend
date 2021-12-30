Rails.application.routes.draw do
  resources :posts do
    member do
      patch 'upvote'
      patch 'downvote'
    end
  end
  resources :users
  resources :comments


end
