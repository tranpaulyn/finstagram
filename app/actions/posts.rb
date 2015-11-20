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
  # "<html></html>"
end

post '/posts' do
  @post = Post.new params.slice('photo_url', 'user_id')
  if @post.save
    redirect to("/")
  else
    erb :"posts/new"
  end
end 