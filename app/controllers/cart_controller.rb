class CartController < ApplicationController
 before_action :authenticate_user!
  
  def index
    if session[:cart] then
      @cart = session[:cart]
      
    else
      @cart = {}
  
    end
  
  end
  
  
  
  def add
    #find the id of the product to be added to the cart
    id = params[:id]
      #find the cart to put product in or create one
      if session[:cart] then #does cart exist
        cart = session[:cart] #if it does use it
      else
        session[:cart] = {} #if not make one
        cart = session[:cart]
      end
    
    #control the product in the cart
    if cart[id] then #see is the product in the cart
      
      cart[id] = cart[id] + 1 #if yes then increase quantity by 1
    else
      cart[id] = 1 # if no add one
    end
      #send user somewhere now item is added
      redirect_to :action  => :index
  end
  
  def clearcart
    
      session[:cart] = nil
      redirect_to :action  => :index
    
  end
  
  def remove
    
      id = params[:id]
      cart = session[:cart]
      cart.delete id 
      
      redirect_to :root
      
    
  end
  
  def decrease
      
      id = params[:id]
      cart = session[:cart]
      
      if cart[id] == 1 then
        cart.delete id
        
      else
      
      cart[id] = cart[id] -1
      
      end
      redirect_to :action  => :index
    
  end
  
  def increase
      
      id = params[:id]
      cart = session[:cart]
      
      cart[id] = cart[id] +1
      redirect_to :action  => :index
  end
      
  
  def createOrder
    
    #step 1 find user info
    @user = User.find(current_user.id)
    
    #step 2 build new order > link to current user
    @order = @user.orders.build(:order_date => DateTime.now, :status => 'Pending')
    @order.save
    
    #step 3 save each order item from the cart in to the orderitems table
    @cart = session[:cart] || {} #this gets the items from the users cart session
    @cart.each do | id, quantity |
      item = Item.find_by_id(id)
      
    @orderitem = @order.orderitems.build(:item_id => item.id, :title => item.title, :description => item.description, :quantity => quantity, :price => item.price)  
    @orderitem.save
    
    end
    
    @orders = Order.all
    @orderitems = Orderitem.where(order_id: Order.last)

    
  end
  
end