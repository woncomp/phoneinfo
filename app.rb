require 'json'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'digest'

# Commands to run
#
# Things to try
# * have the page display "Howdy!"
# * have the page display some HTML (paste some HTML in the string)
#
# Bonus
# * have the page display the current time (google "ruby current time")
# * have the page display the current time, formatted in a nicer way. (google "ruby strftime" which stands for string-format-time)

get '/' do
  "Hello World! Welcome to Ruby!"
end

post '/submit' do
  data = JSON.parse request.body.read
  hash_name = Digest::SHA256.base64digest data.to_s
  
  puts '----------'
  puts hash_name
  puts data.inspect
  puts '----------'
  
  'OK'
end