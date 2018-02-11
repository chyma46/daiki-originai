Rails.application.routes.draw do
  get 'microposts/create'

  get 'microposts/destroy'

  get 'reviews/create'

  get 'reviews/destroy'

  root to: 'toppages#index'
  resources :toppages, only: [:create]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create]

  resources :reviews, only: [:create, :destroy]
end