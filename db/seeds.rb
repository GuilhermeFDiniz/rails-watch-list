# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'net/http'
require 'json'

url = "https://tmdb.lewagon.com/movie/top_rated"
uri = URI(url)
response = Net::HTTP.get(uri)
json = JSON.parse(response)

puts "Cleaning Database"
Movie.destroy_all
puts "Creating a new Database"

json["results"].each do |movie|
  new_movie = Movie.new(title: movie["original_title"], overview: movie["overview"], poster_url: "https://image.tmdb.org/t/p/original/#{movie["poster_path"]}", rating: movie["vote_average"])
puts "Movie: #{new_movie.title} created "
if new_movie.save
  puts "Saved"
else
  puts "something went wrong"
end
end

puts "Finished"
