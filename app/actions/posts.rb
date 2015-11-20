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
  # params => { post: { photo_url: '', title  } }  
  @post = current_user.posts.new(params[:post])
  if @post.save
    redirect to("/")
  else
    erb :"posts/new"
  end
end 