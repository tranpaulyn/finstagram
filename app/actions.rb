get '/' do
  @posts = Post.order 'created_at DESC'
  erb :index
end

get '/signup' do
  @user = User.new
  erb :signup
end

get '/login' do
  erb :login
end

get '/posts/new' do
  @post = Post.new
  erb :"posts/new"
end

get '/posts/:id' do
  @post = Post.find params[:id]
  erb :"posts/show"
end

post '/posts' do
  @post = Post.new params.slice('photo_url', 'user_id')
  if @post.save
    redirect to("/")
  else
    erb :"posts/new"
  end
end

post '/comments' do
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