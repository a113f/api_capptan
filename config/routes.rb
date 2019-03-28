Rails.application.routes.draw do
  root 'users#index'

  post 'auth' => 'user_token#create'

  resources :users, only: [:create]
  resources :guidelines, except: [:index, :edit, :new]
  get 'active', to: 'guidelines#active'
  patch 'activate/:id', to: 'guidelines#activate'

  get 'inactive', to: 'guidelines#inactive'
  patch 'disable/:id', to: 'guidelines#disable'
end
