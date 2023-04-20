class Doctor < ApplicationRecord
	has_many :appointments
	has_many :users, through: :appointments

	validates :first_name, :last_name, :specialization, presence: { strict: true }, length: { minimum: 2 }
end
