Rails.application.routes.draw do
  
  resources :departments
  resources :items
  resources :orders do
  
    resources:orderitems
    
  end
    
  devise_for :users do
    
    resources:orders
    
  end
  get '/admin' => 'static_pages#adminsection'
  
  get '/checkout' => 'cart#createOrder'  
  
  get 'cart/index'

root 'static_pages#home'

  get '/' => 'static_pages#home'

  get '/about' => 'static_pages#about'

  get '/contact' => 'static_pages#contact'
  
  get '/books' => 'items#index'
  
  get '/cart' => 'cart#index'
  
  get '/cart/:id' => 'cart#add'
  
  get '/clearcart' => 'cart#clearcart'
  
  get '/remove/:id' => 'cart#remove'
  
  get '/decrease/:id' => 'cart#decrease'
  
  get '/increase/:id' => 'cart#increase'
  
  get '/paid/:id' => 'static_pages#paid'
  
  get '/makeadmin/:id' => 'static_pages#makeadmin'
  
  get '/removeadmin/:id' => 'static_pages#removeadmin' 
    
  get '/department/:title' => 'static_pages#department'
  
  get '/welcome' => 'static_pages#welcome'
  
  post '/search' => 'items#search'
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
