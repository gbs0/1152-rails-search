require "open-uri"
require "yaml"

file = "https://gist.githubusercontent.com/dmilon/e897669bfa411bfdd92c9f59f91dd6fe/raw/d1e1b06e25616771fddf44bf066765f518b0655d/imdb.yml"
sample = YAML.load(URI.open(file).read)

puts "Creating directors..."
directors = {}  # slug => Director
sample["directors"].each do |director|
  director_params = director.slice("first_name", "last_name")
  directors[director["slug"]] = Director.create!(director_params) 
end

puts "Creating movies..."
sample["movies"].each do |movie|
  Movie.create! movie.slice("title", "year", "synopsis").merge(director: directors[movie["director_slug"]], genre: Movie::GENRES.sample)
end

puts "Creating tv shows..."
sample["tv_shows"].each do |tv_show|
  TvShow.create! tv_show
end
puts "Finished!"