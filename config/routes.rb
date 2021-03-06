Lzacademy::Application.routes.draw do

  devise_for :teachers
  devise_for :parents

  resources :registrations, :locations, :programs, :session_terms, :teachers, :parents, :students, :emergency_forms, :recommendations
  
  resources :courses do
    collection do
      get :overview
    end
  end
  
  resources :parents do
    resources :students
  end
  
  resources :students do
    resources :registrations
    resource :emergency_form
    resource :recommendation do
      get :thank_you
    end
  end
  
  resources :registrations do
    resources :comments
    resources :notification_addresses
  end
  
  root :to => "about#index"
  
  match "contact" => "about#contact"
  match "comments/pending" => "comments#pending", :as => :pending_comments
  
  get "school/locations"
  get "school/schedule"
  get "school/languages"
  get "school/register"
  
  get "camp/locations"
  get "camp/schedule"
  get "camp/typical_day"
  get "camp/typical_session"
  get "camp/discounts"
  get "camp/register"
  
  get "about/index"
  get "about/philosophy"
  get "about/history"
  get "about/faculty"
  get "about/gallery"
  get "about/testimonials"
  get "about/us"
  get "about/contact"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
