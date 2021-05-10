Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api , defaults: { format: :json } do
    namespace :v1 do 
      resources :messages, only: [:index, :create] do
        collection do
          put 'approve'
          get 'top_ten'
        end
      end
    end
  end
  
  root to: 'home#home_page'
end
