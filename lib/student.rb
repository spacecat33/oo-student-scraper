class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.each do |key, value|
      self.class.attr_accessor(key)
      self.send("#{key}=", value)
    end
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      student = self.new(student)
      # student.name = post.css("h4").text
      # student.location = post.css("p").text

    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |key, value|
      self.class.attr_accessor(key)
      self.send("#{key}=", value)
    end
  end

  def self.all
    @@all
  end
end

# ("./fixtures/student-site/index.html")