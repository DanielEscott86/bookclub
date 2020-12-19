class StaticPagesController < ApplicationController
  def home
    @departments = Department.all
    
  end

  def about
      #session[:cart] = nil
  end

  def contact
      #current_user.update_attribute :admin, true
  end
  
  def paid
      flash[:notice] = 'Transaction Complete'
    
      @order = Order.last
    
      @order.update_attribute(:status, 'Paid')
    
      session[:cart] = nil
  end
  
  def adminsection
      @orders = Order.all
      @users = User.all
  end
  
  def department
      genre = params[:title]
      @items = Item.where("department like ?", genre,)
  end
  
  def makeadmin
      @user = User.find_by(id: params[:id])
        @user.update_attribute(:admin, true)
        redirect_to "/"
      
  end 
  
  def removeadmin
      @user = User.find_by(id: params[:id])
        @user.update_attribute(:admin, false)
        redirect_to "/"
  end
  
  def welcome
      @user = User.find(current_user.id)
      @orders = @user.orders.all
      @orderitems = Orderitem.where(order_id: Order.last)
  end

end
