require 'rest_client'

class Client
  
  def initialize
    puts "REST client"
    puts "This application allows you to make a Google search and examine its results.\n"
    new_uri
  end
  
  def new_uri
    puts "Please enter the query:"
    input = gets.chomp.downcase
    input.gsub!(/ /, "+")
    @uri = "http://www.google.com/search?q=#{input}"
  end
  
  def get_method
    response = RestClient.get @uri
    puts
    puts "GET #{@uri}"
    get_code(response)
    get_headers(response)
    get_cookies(response)
  end
  
  private
  
  def get_code (response)
    print 'Response code: '
    puts response.code
    puts
  end

  def get_headers (response)
    print 'Response headers: '
    puts response.headers
    puts
  end

  def get_cookies (response)
    print 'Response cookies: '
    puts response.cookies
    puts
  end
end

client = Client.new
client.get_method

try_again = true
while try_again
  puts "Make another query (y/n)?"
  choice = gets.chomp.downcase
  while choice !~ /^[yn]$/
    puts "Invalid input, y/n only:"
    choice = gets.chomp.downcase
  end
  case choice
  when "y"
    client.new_uri
    client.get_method
  when "n"
    try_again = false
    puts "Quitting..."
  end
end
