class Movie < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:title, :synopsis]

  scope :find_by_genre, -> (genre) { where(genre: genre) }

  pg_search_scope :global_search,
  against: [:title, :synopsis, :genre],
  associated_against: {
    director: [ :first_name, :last_name]
  },
  using: {
    tsearch: { prefix: true }
  }

  # A query :global_search representa este sql:
  # sql_query = <<~SQL
  #       movies.title @@ :query
  #       OR movies.synopsis @@ :query
  #       OR movies.genre @@ :query
  #       OR directors.first_name @@ :query
  #       OR directors.last_name @@ :query
  #     SQL

  GENRES = %w[action adventure comedy drama fantasy]
  belongs_to :director
end
