class User < ApplicationRecord
	has_many :biometrics, dependent: :destroy
	has_many :medicines, dependent: :destroy
	has_many :appointments, dependent: :destroy
	has_many :doctors, through: :appointments, dependent: :destroy

	email_regex = /\A[^@\s]+@[^@\s]+\z/
	contact_num_regex = /(09|\+63)(\d{9,10})/

	validates :first_name, :last_name, :email, :contact_num, :password, presence: { strict: true }
	validates :first_name, :last_name, length: { minimum: 2 }
	validates :email, length: { minimum: 2 }, format: { with: email_regex }, uniqueness: true
	validates :contact_num, length: { minimum: 11, maximum: 13 }, format: { with: contact_num_regex }
	validates :password, length: { minimum:8 }

	def avg_heart_rate
		biometrics.average(:heart_rate).round(2).to_f
	end

	def avg_weight
		biometrics.average(:weight).round(2).to_f
	end
end
