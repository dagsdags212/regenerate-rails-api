class CreateBiometrics < ActiveRecord::Migration[7.0]
  def change
    create_table :biometrics do |t|
      t.float :weight
      t.float :height
      t.integer :heart_rate
      t.integer :systolic_blood_pressure
      t.integer :diastolic_blood_pressure
      t.float :glucose_concentration
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
