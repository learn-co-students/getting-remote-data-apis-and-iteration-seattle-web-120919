require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request


  response_string = RestClient.get('http://swapi.dev/api/people')
  response_hash = JSON.parse(response_string)

  character = response_hash["results"].find do |data|
    data["name"] == character_name
  end 

  film_urls = character["films"]

  film_info = film_urls.collect do |url|
    JSON.parse(RestClient.get(url))

    # response_string = RestClient.get(url)
    # response_hash = JSON.parse(response_string)
  end 

  print_movies(film_info)

  # print_movies(film_urls)
  
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end

def print_movies(film_info)
  # some iteration magic and puts out the movies in a nice list
  array = film_info.map do |movie|
    movie_title = movie["title"]
    movie_title
  # correct_films = films.each do |film|
  #   response_string = RestClient.get(film)
  #   response_hash = JSON.parse(response_string)
  # end 
  end.uniq 

  array.each do |movie_title|
    puts movie_title
  end 

end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
