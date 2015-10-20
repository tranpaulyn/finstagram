
helpers do

  def logged_in?
    !!current_user
  end

  def current_user
    if cookies[:user_id]
      User.find(cookies[:user_id])
    end
  end
end


get '/' do
  @posts = Post.order 'created_at DESC'
  erb :index
end

get '/signup' do
  @user = User.new
  erb :signup
end

post '/signup' do
  @user = User.new params.slice('email', 'username', 'password', 'avatar_url')
  if @user.save
    cookies[:user_id] = @user.id
    redirect to("/")
  else
    erb :"posts/new"
  end
end


get '/login' do
  erb :login
end

post '/login' do 
  @user = User.find_by(username: params[:username], password: params[:password])
  if @user
    cookies[:user_id] = @user.id
    redirect to('/')
  else
    @error_messages = ['Invalid username or password, yo!']
    erb :login
  end
end

get '/posts/new' do
  @post = Post.new
  erb :"posts/new"
end

put '/posts/:id' do
  @post = Post.find(params[:id])
  halt unless logged_in? && @post.user == current_user
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