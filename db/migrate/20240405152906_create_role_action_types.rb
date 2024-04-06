class CreateRoleActionTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :role_action_types do |t|
      t.references :role, null: false, foreign_key: true
      t.references :action_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
