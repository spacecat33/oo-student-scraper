
require 'open-uri'
require 'pry'

class Scraper 

  def self.scrape_index_page(index_url)
    # The return value of this method should be an array of hashes in which each hash represents a single student.
    
    page = Nokogiri::HTML(URI.open(index_url))
    
    students = []
   
    page.css(".student-card").each do |student|     #or:   page.css("div.student-card").each do |student|
    
      students << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.children[1].attributes["href"].value
     }
    
    end
    students
  end
  
 def self.scrape_profile_page(profile_url)  
  # The return value of this method should be a hash in which the key/value pairs describe an individual student.
  
  page = Nokogiri::HTML(URI.open(profile_url))

  student_profiles = {}
  
  social_links = page.css(".social-icon-container").children.css("a").collect {|e| e.attribute("href").value}
  social_links.each do |social_link|
    if social_link.include?("twitter")
      student_profiles[:twitter] = social_link 
    elsif social_link.include?("linkedin")
      student_profiles[:linkedin] = social_link 
    elsif social_link.include?("github")
      student_profiles[:github] = social_link
    else
      student_profiles[:blog] = social_link
    end
  end

    # student_profiles[:twitter] = page.css(".social-icon-container").children.css("a")[0].attribute("href").value
    # # if page.css(".social-icon-container").children.css("a")[0]
    # student_profiles[:linkedin] = page.css(".social-icon-container").children.css("a")[1].attribute("href").value if page.css(".social-icon-container").children.css("a")[1]
    # student_profiles[:github] = page.css(".social-icon-container").children.css("a")[2].attribute("href").value if page.css(".social-icon-container").children.css("a")[2]
    # student_profiles[:blog] = page.css(".social-icon-container").children.css("a")[3].attribute("href").value if page.css(".social-icon-container").children.css("a")[3]
  
    student_profiles[:profile_quote] = page.css(".profile-quote").text if page.css(".profile-quote")
    student_profiles[:bio] = page.css("div.bio-content.content-holder div.description-holder p").text if page.css("div.bio-content.content-holder div.description-holder p")

    student_profiles
    
  end

end



# draft
    #       title = social_link.css("img.social-icon src a").text
#       student_profiles[title.to_sym] = {
#         student_profile[:twitter] = if social_link.include?("twitter")
#         #     student_profile[:linkedin] = e if e.include?("linkedin")
#         #     student_profile[:github] = e if e.include?("github")
           
#       }

#     end

#     student_profiles

#     end
#   # social_links = page.css("a").each {|e| e.attributes["href"].value = {} }
   
#   # social_links = page.css(".social-icon-container").css("a")
#   # puts links.length   # => ?
#   # puts links[0].text   # => Click here
#   # puts links[0]["href"] # => http://www.google.com
  
#  end
#   social_links = page.css(".social-icon-container").children.css("a").collect {|e| e.attribute("href").value}   #or:  profile_pages = page.css("div.social-icon-container")

#   social_links.detect.do |e|
#     student_profile[:twitter] = e if e.include?("twitter")
#     student_profile[:linkedin] = e if e.include?("linkedin")
#     student_profile[:github] = e if e.include?("github")
   
#  end
#     student_profile[:blog] = social_links[3] if social_links[3] != nil
#     student_profile[profile_quote] = page.css(".profile-quote")[0].text
#     student_profile[:bio] = page.css("description-holder").css("p")[0].text
#     student_profiles
# # end

# end


