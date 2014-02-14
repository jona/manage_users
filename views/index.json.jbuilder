json.current_user current_user, :id, :email, :role, :created_at
json.users (@users) do |user|
  json.extract! user, :id, :name, :email, :created_at
  json.admin user.has_role?('admin') ? true : false
end
