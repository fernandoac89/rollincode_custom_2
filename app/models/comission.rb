class Comission < ApplicationRecord
  belongs_to :sale
  belongs_to :user
  enum status: [:pending, :payd] #mapeia para uma string
end
