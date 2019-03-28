Rails.application.routes.draw do
  root 'users#index'

  post 'auth' => 'user_token#create'

  resources :users, only: [:create]
end
