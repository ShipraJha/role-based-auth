class ActionType < ApplicationRecord
  has_many :role_action_types
  has_many :roles, through: :role_action_types
end
