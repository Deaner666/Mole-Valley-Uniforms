class OrdersController < ApplicationController

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @title = "Order summary"
    @order = Order.find(params[:id], :include => :line_items)
  end
  
  # GET /orders/new
  # GET /orders/new.xml
  def new
    @title = "Order Drinks"
    @order = Order.new
    for product in Product.all
      @order.line_items.build(:product_id => product.id)
    end

    respond_to do |format|
      format.html
      format.xml  { render :xml => @order }
    end
  end
  
  # POST /orders  
  # POST /orders.xml 
  def create
    @order = Order.new(params[:order])
    
    respond_to do |format|
      if @order.save
        format.html { redirect_to(order_path(@order),
                                  :notice => "Order was successfully created.") }
        format.xml { render :xml => @order, :status => :created, :location => @order }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @order.error, :status => :unprocessable_entity }
      end
    end
  end
  
end