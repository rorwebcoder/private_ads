class User < ActiveRecord::Base
		# Authlogic implementation
		acts_as_authentic do |option|
				#~ option.ignore_blank_passwords false
		end	
		
		
		def display_error_messages
				if !errors.empty?
						error_hash = errors.messages
						error_msg = []
						error_hash.each_pair do |k,value|
								error_msg << "#{k} - #{value}"
						end			
						error_msg.join(",")
				end				
		end		
end
