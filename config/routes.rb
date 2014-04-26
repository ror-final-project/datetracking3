RailsOmniauthFacebook::Application.routes.draw do
get '/' => 'home#index'

devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}, :path => '', :path_names => { :sign_in => 'login', :sign_out => 'logout',
            :password => 'password', :confirmation => 'verification',
            :unlock => 'unblock', :registration => 'signup',
            :sign_up => 'new' }

resources :users do 
  resources :datees
end

resources :experiences do
  resources :surveys
end


devise_scope :user do
    get   'login', to: 'devise/sessions#new'
    get   "logout", :to => "devise/sessions#destroy"
    get   "signup", :to => "devise/registrations#new"
    get   "password", :to => "devise/passwords#new"
    match 'users/secret', to: "devise/passwords#create", via: :post
    match 'sessions/user', to: 'devise/sessions#create', via: :post
    match 'users/signup', to: 'devise/registrations#create', via: :post
  end

root to: "home#index"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
