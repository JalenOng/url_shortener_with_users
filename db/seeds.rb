10.times do
  User.create(
    username: Faker::Internet.user_name,
    password: Faker::Internet.password)
end