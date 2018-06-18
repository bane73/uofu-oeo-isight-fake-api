class Isight
  
  def initialize 
    
    @partyTypes_staffNonCred = [ "Staff","Non-Credit"]
    @partyTypes_student = [ "Freshman"]

    @oeoCourses = [
        {
            :code => "1234",
            :title => "An OEO Course",
            :date => "2000-01-02",
            :attendance => "Completed"
        },
        {
            :code => "4567",
            :title => "Another OEO Course",
            :date => "2000-01-03",
            :attendance => "Completed"
        }
      ]
    
    @person_mj = {
        :emplid => "01234567",  
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
    
    @person_js = {
        :emplid => "01234566",  
        :partyTypes => @partyTypes_student,
        :nameFirst => "John",
        :nameFirstPref => "John",
        :nameMiddle => "",
        :nameLast => "Smith",
        :email => "John.Smith@gmail.com",
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
        :empRcd => nil,
        :deptId => nil,
        :deptDescr => nil,
        :jobCode => nil,
        :jobDescr => nil,
        :mgrId => nil,
        :hireDate => nil,
        :termDate => nil,
        :area => nil,
        :oeoCourses => nil
      }
    
    @people = {
        "01234567" => @person_mj,
        "01234566" => @person_js
      }
    
    puts "Initialized: Isight"
  end
  
  def getPerson_json(request)   
    emplid = getSanitizedEmplidFromRequest(request)  
    person = @people[emplid]
    if person.nil?
      raise "Unknown emplid"
    end
    person.to_json
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