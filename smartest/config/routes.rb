Rails.application.routes.draw do
  get 'healthcheck', to: 'agents#healthcheck'
  get 'discover', to: 'agents#discover'
  
  resources :agents, only: [:index, :create, :destroy], param: :id do
    collection do
      get :discover
    end
  end
  
  root 'agents#index'
end
