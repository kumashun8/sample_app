# frozen_string_literal: true

User.create!(
  name: 'Example User',
  email: 'example@hoge.com',
  password: 'password',
  password_confirmation: 'password',
  admin: true
)

99.times do |_n|
  name = Faker::Name.name
  email = 'example-#{n+1}@hoge.com'
  password = 'password'
  User.create(
    name: name,
    email: email,
    password: password,
    password_confirmation: password
  )
end
