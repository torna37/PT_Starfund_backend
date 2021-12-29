# frozen_string_literal: true

10.times do
  user = User.create!(
    username: Faker::Fantasy::Tolkien.character
  )
  # if user.persisted?
  # rand(1..5).times do
  puts user.inspect
  post = Post.create!(
    title: Faker::TvShows::BigBangTheory.character,
    content: Faker::TvShows::BigBangTheory.quote,
    likes_counter: 0,
    user_id: user.id
  )
  puts post.inspect
  comment = Comment.create!(
    content: Faker::TvShows::BigBangTheory.quote,
    likes_counter:0,
    post_id: post.id,
    user_id: user.id
  )
  # end
  # end
end
