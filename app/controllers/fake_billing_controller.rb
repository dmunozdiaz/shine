class FakeBillingController < ApplicationController
  skip_before_action	:authenticate_user!
  def show
  	if params[:cardholder_id]
  		
  		render json: {
  			lastFour: Faker::Business.credit_card_number[-4..-1],
  			cardType: Faker::Business.credit_card_type,
			expirationMonth: Faker::Business.credit_card_expiry_date.month, 
			expirationYear: Faker::Business.credit_card_expiry_date.year,
			detailsLink: Faker::Internet.url,
		}
	else
			head :not_founf
	end		
  end
end
