before '/posts/:post_id/*' do 
  halt(400) unless logged_in?
end

before '/posts/:post_id/comments' do 
  @post = Post.find(params[:post_id])
  halt(400) if @post.user == current_user
end

post '/posts/:post_id/comments' do
  @comment = @post.comments.new params.slice('text')

  # @comment = Comment.new params.slice('text', 'post_id')
  @comment.user = current_user
  if @comment.save
    redirect back
  else 
    erb :'posts/new'
  end
end

post '/likes' do
  Like.create params.slice('post_id', 'user_id')
  redirect back
end

delete '/likes/:id' do
  Like.find(params[:id]).destroy
  redirect back
end
