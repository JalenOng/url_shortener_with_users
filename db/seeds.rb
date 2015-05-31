n = 1

10.times do
  User.create(
    username: Faker::Internet.user_name,
    password: n)
  n += 1
end