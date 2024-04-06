action_types = ActionType.create([
  { name: 'READ' },
  { name: 'WRITE' },
  { name: 'DELETE' }
])

resources = Resource.create([
  { name: 'Resource 1' },
  { name: 'Resource 2' },
  { name: 'Resource 3' }
])

roles = Role.create([
  { name: 'Admin' },
  { name: 'Editor' },
  { name: 'Viewer' }
])

roles.each do |role|
  case role.name
  when 'Admin'
    role.action_types << action_types
  when 'Editor'
    role.action_types << [action_types[0], action_types[1]]
  when 'Viewer'
    role.action_types << action_types[0]
  end
end

users = User.create([
  { name: 'admin', super_admin: true },
  { name: 'editor' },
  { name: 'viewer' }
])

users[0].roles << Role.find_by(name: 'Admin')
users[1].roles << Role.find_by(name: 'Editor')
users[2].roles << Role.find_by(name: 'Viewer')
