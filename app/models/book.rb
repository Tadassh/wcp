class Book < ApplicationRecord
    belongs_to :user

    validates :body, length: { maximum: 50 }
    validates :title, presence: true


end
