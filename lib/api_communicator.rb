require 'rest-client'
require 'JSON'
require 'pry'
require 'net/http'
require 'open-uri'

def get_character_movies_from_api(character)
  response_string = RestClient.get('https://swapi.dev/api/people')
  response_hash = JSON.parse(response_string)
  character_data = response_hash["results"].find { |data| data["name"] == character } 
  film_urls = character_data["films"]
  film_details = film_urls.collect{|url| JSON.parse(RestClient.get(url)) }
  film_details 
end

def print_movies(films)
  films.map{|film| puts film["title"]}
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  print_movies(films_hash)
end
