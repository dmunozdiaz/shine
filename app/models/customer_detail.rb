class CustomerDetail
	QUERY = %{
		SELECT
			customers.id,
			customers.first_name,
			customers.last_name,
			customers.email,
			customers.username,
			customers.created_at,
			billing_address.id,
			billing_address.street,
			billing_address.city,
			billing_state.code,
			billing_address.zipcode AS billing_zipcode, 
			shipping_address.id AS shipping_address_id, 
			shipping_address.street AS shipping_street, 
			shipping_address.city AS shipping_city, 
			shipping_state.code AS shipping_state, 
			shipping_address.zipcode AS shipping_zipcode
		FROM
			customers
		JOIN customers_billing_addresses ON
			customers.id = customers_billing_addresses.customer_id	
		JOIN addresses billing_address ON
			billing_address.id = customers_billing_addresses.address_id
		JOIN states billing_state ON 
			billing_address.state_id = billing_state.id
		JOIN customers_shipping_addresses ON
			customers.id = customers_shipping_addresses.customer_id 
			AND customers_shipping_addresses.primary = true
		JOIN addresses shipping_address ON
			shipping_address.id = customers_shipping_addresses.address_id
		JOIN states shipping_state ON 
			shipping_address.state_id = shipping_state.id		
	}

	def self.find(customer_id)
		ActiveRecord::Base.connection.execute(
			QUERY + " WHERE customers.id = #{customer_id}"
			).first
	end	
end
