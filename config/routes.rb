Rails.application.routes.draw do
  root to: redirect('/oauth/manage')

  use_doorkeeper do
    controllers applications: 'oauth/applications'
  end
  get 'oauth/token/old_info/:token_string', to: 'token_info#show'

  namespace :oauth do
    get 'manage', to: 'manage#index'
    resources :users, only: [:index, :show]
    resources :owners, only: [:index, :create, :destroy], controller: 'authorization_server_owners'
  end

  match 'auth/ncu_portal_open_id/callback', to: 'sessions#create', via: [:get, :post]
  post 'sign_in', to: 'sessions#new'
  get 'sign_in', to: 'sessions#index'
  match 'sign_out', to: 'sessions#destroy', via: [:get, :delete]
end
