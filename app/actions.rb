require_relative 'helpers'
require_relative 'actions/posts'
require_relative 'actions/auth'

get '/' do
  @posts = Post.order 'created_at DESC'
  erb :index
end

post '/comments' do
  halt(400) unless logged_in?
  Comment.create params.slice('text', 'post_id', 'user_id')
  redirect back
end

post '/likes' do
  Like.create params.slice('post_id', 'user_id')
  redirect back
end

delete '/likes/:id' do
  Like.find(params[:id]).destroy
  redirect back
end