class UserSession < Authlogic::Session::Base
		def display_error_messages
				#<OrderedHash {:base=>["You did not provide any details for authentication."]}>
				#<OrderedHash {:password=>["cannot be blank"]}>
				#<OrderedHash {:login=>["cannot be blank"]}>
				#<OrderedHash {:password=>["is not valid"]}>
				
				if !errors.empty?
						error_hash = errors.messages
						(error_hash.keys[0] == "base".to_sym) ? "#{error_hash.values.flatten[0].to_s}" : "#{error_hash.keys[0]} - #{error_hash.values.flatten[0].to_s}"
				end				
		end
end