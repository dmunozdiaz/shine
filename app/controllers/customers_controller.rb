class CustomersController < ApplicationController
  PAGE_SIZE = 10
  def index
    @user = current_user

    @page = (params[:page || 0]).to_i
  	if params[:keywords].present?
  		@keywords = params[:keywords]
  		customer_serach_term = CustomerSearchTerm.new(@keywords)
  		@customers = Customer.where(customer_serach_term.where_clause,
  			customer_serach_term.where_args	 
  			)
        .order(customer_serach_term.order)
        .offset(PAGE_SIZE * @page).limit(PAGE_SIZE)
  	else
  		@customers = []
  	end	

    respond_to do |format|
        format.html {}
        format.json {render json: @customers}
    end 

  end

  def show
    customer_detail = CustomerDetail.find(params[:id])
    
    respond_to do |format|
      format.json { render json: customer_detail }
    end 
 
  end

  def update
    customer_detail = CustomerDetail.find(params[:id]) 
    customer_detail.update(params)
    head :ok
  end 

end
