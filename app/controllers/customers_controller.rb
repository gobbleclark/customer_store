class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  def index
    #active record
    # @customers = current_user.customers

    # SQL --- 
    @customers = Customer.all_customers(current_user.id)
  end

  def show
  end

  def new
    @customer = current_user.customers.new
  end
  
  def create
    # Active Record
    #@customer = current_user.customers.new(customer_params)

    # Create By SQL
    @customer = Customer.create_customer( customer_params, current_user.id)
    redirect_to customers_path
  end

  def edit
    render partial: "form"

  end


  def update
    Customer.update_customer(@customer.id, customer_params)
    redirect_to customers_path(@customer)
  end

  def destroy

    @customer.destroy
    redirect_to customers_path

  end 

  private
  def set_customer
    # Active Record
   # @customer = current_user.customers.find(params[:id])

    # Find By SQL
    @customer = Customer.single_customer(current_user.id, params[:id])
  end 

  def customer_params

    params.require(:customer).permit(:first_name, :last_name, :email, :phone)

  end


end
