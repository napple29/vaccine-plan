Rails.application.routes.draw do
  devise_for :users, path: ''
  resources :families, only: [:index]
  resources :settings, only: [:index]
  resources :children , only: %i[edit new create update] do
    resources :histories, only: %i[edit update index]
    resources :schedules, only: [:index]
  end
  root 'top#index'
  get '/pp', to: 'top#pp', as: 'pp'
  get '/tos', to: 'top#tos', as: 'tos'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
