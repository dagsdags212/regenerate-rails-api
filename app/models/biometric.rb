class Biometric < ApplicationRecord
    belongs_to :user

    validates :weight, :height, :glucose_concentration, numericality: { only_integer: true }
    validates :heart_rate, :systolic_blood_pressure, :diastolic_blood_pressure, numericality: true
end
