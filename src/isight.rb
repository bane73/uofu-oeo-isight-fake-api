class Isight
  
  def initialize 
    
    @partyTypes_staffNonCred = [ "Staff","Non-Credit"]
    @partyTypes_student = [ "Undergraduate"]
    @partyTypes_studentStaff = [ "Staff", "Graduate"]

    @oeoCourses_0 = [
        {
            :code => nil,
            :title => nil,
            :date => nil,
            :attendance => nil
        }
      ]
    @oeoCourses_2 = [
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
        :fratSorority => nil,
        :empRcd => nil,
        :deptId => nil,
        :deptDescr => nil,
        :jobCode => nil,
        :jobDescr => nil,
        :mgrId => nil,
        :hireDate => nil,
        :termDate => nil,
        :area => "Academic HSC",
        :oeoCourses => @oeoCourses_0
      }
    
    @person_mj = {
        :emplid => "01234567",  
        :partyTypes => @partyTypes_staffNonCred,
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
        :fratSorority => nil,
        :empRcd => "0",
        :deptId => "00411",
        :deptDescr => "Sociology",
        :jobCode => "1357",
        :jobDescr => "Director",
        :mgrId => "97292590",
        :hireDate => "2007-08-09",
        :termDate => nil,
        :area => "UOU",
        :oeoCourses => @oeoCourses_2
      }
    
    @person_jb = {
        :emplid => "01234568",  
        :partyTypes => @partyTypes_studentStaff,
        :nameFirst => "Jason",
        :nameFirstPref => "Jason",
        :nameMiddle => "",
        :nameLast => "Bourne",
        :email => "jbourne@example.com",
        :phone => "801/555-1234",
        :phoneCell => "801/555-1234",
        :addr1 => "123 Ultimatum St.",
        :addr2 => "",
        :city => "Salt Lake City",
        :state => "UT",
        :country => "USA",
        :zip => "84112",
        :race => "WHITE",
        :gender => "M",
        :dob => "1975-12-15",
        :classStanding => "Masters",
        :athlete => false,
        :fratSorority => nil,
        :empRcd => "1",
        :deptId => "01234",
        :deptDescr => "Operations",
        :jobCode => "1234",
        :jobDescr => "Director",
        :mgrId => "01234567",
        :hireDate => "2018-06-20",
        :termDate => nil,
        :area => "UOU",
        :oeoCourses => @oeoCourses_0
      }
    
    @people = {
        "01234566" => @person_js,
        "01234567" => @person_mj,
        "01234568" => @person_jb
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