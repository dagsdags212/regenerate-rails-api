# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

NUM_USERS = 5; NUM_DOCTORS = 5

# random fields for doctors
SPECIALIZATIONS = ['Immunology', 'Anesthesiology', 'Dermatology', 'Radiology', 'Emergency medicine', 'Family medicine', 'Neurology', 'Obstetrics and Gynecology', 'Opthalmology', 'Pathology', 'Pediatrics', 'Psychiatry', 'Radiology', 'Urology']
HOSPITALS = ['LBDH', 'HealthServ', 'The Medical City', 'St. Lukes', 'UERMMMC', 'PGH', 'Makati Med']

# random fields for medicine
PRESRIPTION_DRUGS = ['Lisinopril', 'Levothyroxine', 'Atorvastatin', 'Metformin', 'Simvastatin', 'Omeprazole', 'Amlodipine', 'Metoprolol', 'Acetaminophen', 'Albuterol']
COMMON_DOSAGE = [100, 200, 250, 500, 750, 1000] # measured in mgs

def generate_random_user
	user = {}
	user[:first_name] = Faker::Name.unique.first_name
	user[:last_name] = Faker::Name.unique.last_name
	user[:email] = "#{user[:first_name].downcase}_#{user[:last_name].downcase}@gmail.com"
	user[:contact_num] = rand() > 0.5 ? "09".concat(Faker::Number.number(digits: 9).to_s) : "+639".concat(Faker::Number.number(digits: 9).to_s)
	user[:password] = 'password123'
	user
end

def generate_random_doctor
	doctor = {}
	doctor[:first_name] = Faker::Name.unique.first_name
	doctor[:last_name] = Faker::Name.unique.last_name
	doctor[:specialization] = SPECIALIZATIONS.sample
	doctor[:hospital] = HOSPITALS.sample
	doctor
end

def generate_random_medicine
	med = {}
	med[:prescription_name] = PRESRIPTION_DRUGS.sample
	med[:dosage] = COMMON_DOSAGE.sample
	med[:frequency] = [1, 2, 3, 4, 5].sample
	med[:expiration_date] = Faker::Date.between(from: Date.today, to: 1.year.from_now)
	med
end

def generate_random_biometrics
	metrics = {}
	metrics[:weight] = rand(30..150)
	metrics[:height] = rand(120..220)
	metrics[:heart_rate] = rand(60..140)
	metrics[:systolic_blood_pressure] = rand(40..100)
	metrics[:diastolic_blood_pressure] = rand(80..180)
	metrics[:glucose_concentration] = rand(60..150)
	metrics
end

# Generate random users, each with biometric and medicine data
puts "========== Creating User Data =========="
for user_id in 1..NUM_USERS do
	puts "Generating data for user ##{user_id}..."
	user_data = generate_random_user
	user_data[:id] = user_id
	User.create(user_data)
	# generate medicine data for current user
	for med_id in 1..rand(3..6) do
		puts "Generating medicine data for user ##{user_id}..."
		med_data = generate_random_medicine
		# med_data[:id] = med_id * user_id
		med_data[:user_id] = user_id
		Medicine.create(med_data)
	end
	# generate 10 biometric datapoints per user
	for metric_id in 1..10 do
		puts "Generating datapoint for user ##{user_id}... (#{metric_id} of 10)"
		metric_data = generate_random_biometrics
		# metric_data[:id] = metric_id
		metric_data[:user_id] = user_id
		Biometric.create(metric_data)
	end
end

# Generate random doctor data
puts "========== Creating Doctor Data =========="
for doctor_id in 1..NUM_DOCTORS do
	puts "Generating doctor... (#{doctor_id} of #{NUM_DOCTORS})"
	doctor_data = generate_random_doctor
	doctor_data[:id] = doctor_id
	Doctor.create(doctor_data)
end

# Generate random appointment data
VALID_DOCTOR_IDS = Doctor.pluck(:id)
VALID_USER_IDS = User.pluck(:id)
puts "========== Creating Appointment Data =========="
for appointment_id in 1..20 do
	puts "Generating appointment... (#{appointment_id} of 20)"
	appointment_data = {}
	appointment_data[:appointment_date] = Faker::Date.between(from: Date.tomorrow, to: 1.year.from_now)
	appointment_data[:user_id] = VALID_DOCTOR_IDS.sample
	appointment_data[:doctor_id] = VALID_USER_IDS.sample
	Appointment.create(appointment_data)
end
