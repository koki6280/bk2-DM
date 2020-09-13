Rails.application.routes.draw do
  get 'rooms/index'
  get 'rooms/show'
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  
  resources :books do
  	resources :book_comments, only: [:create, :destroy]
  	resource :favorites, only: [:create, :destroy]
  end

  resources :messages, only: [:create, :destroy]
  resources :rooms, only: [:create, :index, :show]
  
  root 'home#top'
  get 'home/about'
end