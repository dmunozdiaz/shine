class CustomersController < ApplicationController
  def index
  	if params[:keywords].present?
  		@keywords = params[:keywords]
  		customer_serach_term = CustomerSearchTerm.new(@keywords)
  		@customers = Customer.where(customer_serach_term.where_clause,
  			customer_serach_term.where_args	 
  			).order(customer_serach_term.order)
  	else
  		@customers = []
  	end	
  end
end
