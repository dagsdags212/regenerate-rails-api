class Medicine < ApplicationRecord
    belongs_to :user

    validates :prescription_name, presence: true
    validates :dosage, :frequency, numericality: true
end
