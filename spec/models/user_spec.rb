require "rails_helper.rb"

describe User do 
	
	describe "email" do
		let(:user){
			User.create!(email: "foo@example.com",
						password: "qwertyuiop",
						password_confirmation: "qwertyuiop")
		}

		it "absolutely prevents invalid email addreses" do 
			expect {
				user.update_attribute(:email, "foo@bar.com")
			}.to raise_error(ActiveRecord::StatementInvalid, /email_must_be_company_email/i)
		end
	end

end