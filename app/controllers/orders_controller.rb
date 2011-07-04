class OrdersController < ApplicationController  
  
  before_filter :find_order
  
  # GET /orders/1
  # GET /orders/1.xml
  def show
    @title = "Order summary"
  end
  
  # GET /orders/new
  # GET /orders/new.xml
  # def new
  #     @title = "Order Uniforms"
  #     @order = Order.new
  #     for product in Product.all
  #       @order.line_items.build(:product_id => product.id, :product_name => product.name)
  #     end
  # 
  #     respond_to do |format|
  #       format.html
  #       format.xml  { render :xml => @order }
  #     end
  #   end
  
  # POST /orders  
  # POST /orders.xml
  # def create
  #     @order = Order.new(params[:order])
  #     
  #     respond_to do |format|
  #       if @order.save
  #         format.html { redirect_to(order_path(@order),
  #                                   :notice => "Order was successfully created.") }
  #         format.xml { render :xml => @order, :status => :created, :location => @order }
  #       else
  #         ids = []
  #         for li in @order.line_items do
  #           ids << li.product_id
  #         end
  #         for product in Product.all
  #           unless ids.include?(product.id)
  #             @order.line_items.build(:product_id => product.id, :product_name => Product.find(product.id).name)
  #           end
  #         end
  #         flash.now[:alert] = "There was a problem with your order."
  #         format.html { render :action => "new" }
  #         format.xml { render :xml => @order.error, :status => :unprocessable_entity }
  #       end
  #     end
  #   end
  
  def edit
      @title = "Your Order"
      # ids = []
      # for li in @order.line_items do
      #   ids << li.product_id
      # end
      # for product in Product.all
      #   unless ids.include?(product.id)
      #     @order.line_items.build(:product_id => product.id, :product_name => Product.find(product.id).name)
      #   end
      # end
    end
  
  # PUT /orders/1
  # PUT /orders/1.xml
  def update
      @order = Order.find(params[:id])
      respond_to do |format|
        if @order.update_attributes(params[:order])
          format.html do
            OrderMailer.order_email(@order).deliver
            session[:order] = nil
            redirect_to(products_path, :notice => 'Order successfully submitted.')
          end
          format.xml  { head :ok }
        else
          format.html { render :action => "show" }
          format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
        end
      end
    end
  
  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    respond_to do |format|
      if @order.destroy
        session[:order] = nil
        format.html { redirect_to(root_path, :notice => "Your order has been reset.") }
        format.xml  { head :ok }
      else
        format.html { redirect_to(root_path, :alert => "Sorry, your order could not be reset.") }
        format.xml { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # def send_order
  #   if params[:id]
  #     @order = Order.find(params[:id])
  #     OrderMailer.order_email(@order).deliver
  #     redirect_to(new_order_path, :notice => "Order was sent successfully.")
  #   else
  #     redirect_to(new_order_path, :error => "We're sorry, something went wrong.")
  #   end
  # end
  
end
