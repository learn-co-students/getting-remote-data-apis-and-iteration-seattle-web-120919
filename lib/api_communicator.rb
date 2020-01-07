require "rest-client"
require "json"
require "pry"

def get_character_movies_from_api(character_name)
  #make the web request
  response_hash = get_info_from_api_url("http://www.swapi.co/api/people/")

  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  character_hash = {}
  people_aoh = response_hash["results"]

  people_aoh.each do |person_hash|
    if (person_hash["name"] == character_name)
      character_hash = person_hash
      break
    end
  end

  film_urls = character_hash["films"]

  # collect those film API urls, make a web request to each URL to get the info
  #  for that film

  films = []
  film_urls.each { |film_url| films << get_info_from_api_url(film_url) }
  films
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  num = 1
  films.each do |film|
    puts "#{num}. #{film["title"]}"
    num += 1
  end
end

def get_info_from_api_url(api_url)
  response_string = RestClient.get(api_url)
  response_hash = JSON.parse(response_string)
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
