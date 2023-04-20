class Api::V1::BiometricsController < ApplicationController
	before_action :set_user, only: %i[ index show update destroy ]
	before_action :set_biometrics, only: %i[ show update ]

	# Paths are nested within /users/:user_id
	# GET /biometrics
	def index
		biometrics = @user.biometrics
		render json: biometrics
	end

	# GET /biometrics/:id
	def show
		render json: @biometrics
	end

	# POST /biometrics
	def create
		biometrics = Biometric.new(biometric_params)
		if biometrics.save
			render json: biometrics, status: :created
		else
			render json: { error: biometrics.errors.full_messages }, status: :unprocessable_entity
		end
	end

	# PATCH/PUT /biometrics/:id
	def update
		if @biometrics.update(biometric_params)
			render json: @biometrics
		else
			render json: { error: @biometrics.errors.full_messages }, status: :unprocessable_entity
		end
	end

	# DELETE /biometrics/:id
	def destroy
		if @biometrics.destroy
			head :no_content
		else
			render json: { error: @biometrics.errors.full_messages }, status: :unprocessable_entity
		end
	end

	private
		def set_user
			@user = User.find(params[:user_id])
		end

		def set_biometrics
			@biometrics = Biometric.find(params[:id])
		end

		def biometric_params
			params.require(:biometric).permit(:weight, :height, :heart_rate, :systolic_blood_pressure, :diastolic_blood_pressure, :glucose_concentration, :user_id)
		end
end
