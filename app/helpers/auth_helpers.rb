helpers do

  def logged_in?
    !!current_user
  end

  def current_user
    if cookies[:user_id].present?
      User.find(cookies[:user_id])
    end
  end
  
end
