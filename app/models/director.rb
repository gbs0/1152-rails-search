class Director < ApplicationRecord
  has_many :movies, dependent: :destroy

  def full_name
    first_name + " " + last_name
  end
end
