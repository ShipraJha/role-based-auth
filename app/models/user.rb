class User < ApplicationRecord
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles

  validates :name, presence: true, uniqueness: true

  def has_access?(action_type_name)
    return true if super_admin?

    roles.each do |role|
      return true if role.action_types.exists?(name: action_type_name)
    end

    false
  end
end
