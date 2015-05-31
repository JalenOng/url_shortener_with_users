def current_user
    if session[:user_id]
      User.find session[:user_id]
    else
      nil
    end
end

def logged_in?
    if current_user
      true
    else
      false
    end
end

get '/create_user' do
 #display form for create user

erb :new_user
end


get '/' do

@all_url = Url.all

erb :index
end

get '/:short_url' do

  @short_url = params[:short_url]
  @url = Url.where(short_url: @short_url).first

  @url.visit
  redirect to @url.long_url
end

post '/post_url' do
 #shorten url
 @url = Url.create(params[:post])
 
 redirect to("/")

end

post '/login' do
 #shorten url
 @user = User.authenticate(params[:username], params[:password])
 if @user == nil
 	redirect to "/"
 else
 	session[:user_id] = @user.id
 	redirect to "/user/#{@user.id}"
 end

end



post '/create_user' do


@user = User.new(params[:user])

if @user.save
	redirect to "/user/#{@user.id}"
else
	redirect to "/create_user"

end

end

get '/user/:user_id' do

@user = User.find(params[:user_id])

#log out
erb :user_page

end

post '/user/:user_id/' do

 @user = User.find(params[:user_id])
 @url = Url.create(params[:post])
 @url.update(user_id: params[:user_id])

redirect to "/user/#{@user.id}"

end

delete '/logout' do

session.clear
redirect to "/"

end
