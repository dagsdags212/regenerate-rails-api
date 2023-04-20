class Api::V1::MedicinesController < ApplicationController
	before_action :set_user, only: %i[ index show update destroy ]
	before_action :set_medicine, only: %i[ show update ]

	# Paths are nested within /users/:user_id
	# GET /medicines
	def index
		medicines = @user.medicines
		render json: medicines
	end

	# GET /medicines/:id
	def show
		if @medicine
			render json: @medicine
		else
			render json: { error: "No medicine found" }
		end
	end

	# POST /medicines
	def create
		medicine = Medicine.new(medicine_params)
		if medicine.save
			render json: medicine, status: :created
		else
			render json: { error: medicine.errors.full_messages }, status: :unprocessable_entity
		end
	end

	# PATCH/PUT /medicines/:id
	def update
		if @medicine.update(medicine_params)
			render json: @medicine
		else
			render json: { error: @medicine.errors.full_messages }, status: :unprocessable_entity
		end
	end

	# DELETE /medicines/:id
	def destroy
		if @medicine.destroy
			head :no_content
		else
			render json: { error: @medicine.errors.full_messages }, status: :unprocessable_entity
		end
	end

	private
		def set_user
			@user = User.find(params[:user_id])
		end

		def set_medicine
			@medicine = Medicine.find(params[:id])
		end

		def medicine_params
			params.require(:medicine).permit(:prescription_name, :dosage, :frequency, :expiration_date, :user_id)
		end
end
