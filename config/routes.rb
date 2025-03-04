Rails.application.routes.draw do
  namespace :api do
    resources :categories, only: [:index, :create]
    resources :transactions, only: [:index, :create]
  end
end
