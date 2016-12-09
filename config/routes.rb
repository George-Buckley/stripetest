Rails.application.routes.draw do
  get 'subscribe/new'

  devise_for :users
  devise_scope :user do
    get 'signin', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
  end
  resources :subscribe
  delete '/cancel_plan' => 'subscribe#cancel_plan'
  resources :notes
  authenticated :user do
    root 'notes#index', as: "authenticated_root"
  end

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
