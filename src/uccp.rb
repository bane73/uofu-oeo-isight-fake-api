class Uccp
  
  def initialize 

    @cs_response = {
        :transaction_id => "9999999999901234567890",
        :req_reference_number => "123abcd4-12a3-45b6-a1b2-123a456bc78d",
        :auth_time => "2018-05-01T235900Z",
        :signed_date_time => "2018-05-01T235900Z"
      }
    
    @cs_healthCheck = {
        :status => "healthy", # healthy=current_and_validSyntax, sick=current_but_invalidSyntax, tired=notCurrent
        :cs_response => @cs_response
      }
    
    puts "Initialized: Uccp"
  end
    
  def getCyberSourceHealthCheck_json(request)  
      
    case rand(1...100)
    when 1..20        
      @cs_healthCheck[:status] = "sick"
    when 20..50
      @cs_healthCheck[:status] = "tired"
    else
      @cs_healthCheck[:status] = "healthy"
    end
    
    @cs_healthCheck.to_json
  end
  
  
  
end