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

get '/logout' do
  cookies[:user_id] = nil
  redirect to('/')
end