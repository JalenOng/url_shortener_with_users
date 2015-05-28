# OK!
get '/' do
  @all_url = Url.all
  if !session[:user_id].nil?
    @user = User.find(session[:user_id])
  end
  erb :index
end

# OK!
post '/' do
  params[:post][:user_id] = session[:user_id]
  @id = params[:post][:user_id]
  @url = Url.create(params[:post])
  if !session[:user_id].nil?
    redirect to "/users/#{@id}"
  else
    redirect to("#{@url.short_url}")
  end
end

# OK!
get '/users/:id' do
  @user = User.find(params[:id])
  if Url.find_by_user_id(@user.id) == nil
    @all_urls = []
  else
    @all_urls = Url.where(user_id: @user.id)
  end
  erb :user_urls
end

# OK!
post "/login" do
  @user = User.where(username: params[:post][:username])
  @auth_result = @user.authenticate(params[:post][:username], params[:post][:password])
  if @auth_result == nil
    redirect to "/"
  else
    session[:user_id] = @auth_result.id
    redirect to "/users/#{session[:user_id]}"
  end
end

# OK!
get "/create_user" do
  erb :create_user
end

# OK!
post "/create_user" do
  @user = User.create(params[:post])

  if @user.valid?
    session[:user_id] = @user.id
    redirect to "/users/#{@session[:user_id]}"
  else
    redirect to "/create_user"
  end
end

# ASK SHIFU WHY REDIRECT HERE?!?!?!
get '/:short_url' do
  short_url = "/" + params[:short_url]
  @url_object = Url.find_by_short_url(short_url)
  @url_object.visit
  erb :url
end

# OK!
delete '/logout' do
  session[:user_id] = nil
  redirect to "/"
end