# frozen_string_literal: true

10.times do
  user = User.create!(
    username: Faker::Fantasy::Tolkien.character
  )
  puts user.inspect
  post = Post.create!(
    title: Faker::Movie.title,
    content: Faker::TvShows::BigBangTheory.quote,
    likes_counter: 0,
    user_id: user.id
  )
  rand(1..5).times do
    puts post.inspect
    comment = Comment.create!(
      content: Faker::Games::Pokemon.move,
      post_id: post.id,
      user_id: user.id
    )
  end
end
