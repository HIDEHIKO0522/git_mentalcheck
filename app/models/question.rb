class Question < ApplicationRecord
  
  has_many :questions
  belongs_to :check
end