class Role < ApplicationRecord
  has_many :user_roles
  has_many :users, through: :user_roles
  has_many :role_action_types
  has_many :action_types, through: :role_action_types
  has_many :role_resources
  has_many :resources, through: :role_resources
end
