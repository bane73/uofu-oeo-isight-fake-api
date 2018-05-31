class Isight
  
  def initialize 
    
    @partyTypes = [ "Staff","Non-Credit"]

    @oeoCourses = [
        {
            :code => "4567",
            :title => "Another OEO Course",
            :date => "2000-01-02",
            :attendance => "Completed"
        },
        {
            :code => "4567",
            :title => "Another OEO Course",
            :date => "2000-01-02",
            :attendance => "Completed"
        }
      ]
    
    @person = {
        :emplid => "12345678",  
        :partyTypes => @partyTypes,
        :nameFirst => "Michael",
        :nameFirstPref => "Michael",
        :nameMiddle => "Jeffrey",
        :nameLast => "Jordan",
        :email => "Michael.Jordan@utah.edu",
        :phone => "801/555-1212",
        :phoneCell => "801/555-1212",
        :addr1 => "123 Main St.",
        :addr2 => "",
        :city => "Salt Lake City",
        :state => "UT",
        :country => "USA",
        :zip => "84111",
        :race => "HISPA",
        :gender => "M",
        :dob => "1992-01-02",
        :classStanding => "Freshman",
        :athlete => false,
        :fratSorority => "",
        :empRcd => "0",
        :deptId => "00411",
        :deptDescr => "Sociology",
        :jobCode => "1357",
        :jobDescr => "Director",
        :mgrId => "97292590",
        :hireDate => "2007-08-09",
        :termDate => nil,
        :area => "UOU",
        :oeoCourses => @oeoCourses
      }
    
    puts "Initialized: Isight"
  end
  
  def getPerson_json(request)   
    emplid = getSanitizedEmplidFromRequest(request)  
    @person[:emplid] = emplid
    @person.to_json
  end
  
  def getSanitizedEmplidFromRequest(request)

    emplid = JSON.parse(request.body.read)['emplid']
    if emplid.nil? || emplid.empty? || emplid.to_s.strip.empty?
      raise "No emplid found on request-body"
    end

    # whitespace trim & length-check
    emplid = emplid.to_s.strip
    if emplid.length != 8
      raise "Emplid found on request-body isn't exactly length 8"
    end

    # u1234567 or 01234567 
    pattern = Regexp.new(/^[u]|[0]\d{7}$/).freeze
    if !pattern.match?(emplid)
      raise "Emplid doesn't match format of u1234567 or 01234567"
    end

    # swap first 'u' for a '0'
    emplid = '0' + emplid[1,7]

    emplid
  end
  
  
end