require 'rest-client'
require 'JSON'
require 'pry'
require 'net/http'
require 'open-uri'

# return array of hashes, each hash = movie info
def get_character_movies_from_api(character)

  # API request for all_characters
  response_string = RestClient.get('https://swapi.dev/api/people')
  response_hash = JSON.parse(response_string)
  character_data = response_hash[:results]

  film_urls = character_data.each do |char| 
    if char[:name] === "Luke Skywalker"
        puts char[:films]
    end
  end 

  # char = character_data.map{|char| char[:name] == character}
  # # iterate to find collection of `films` for the given `character`
  # film_urls = character_data[:films]

  # collect film API urls, make a web request to each URL to get film details
  film_details = film_urls.map{|url| JSON.parse(RestClient.get(url)) }
  
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
end

# some iteration magic, puts out the movies by title in a nice list
def print_movies(films)
  films.map{|film| film.title}
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end
