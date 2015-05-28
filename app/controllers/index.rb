get '/' do
  @all_url = Url.all
  erb :index
end

post '/' do
  long_url = params[:post]
  @url = Url.create(long_url)
  redirect to("#{@url.short_url}")
end

get '/:short_url' do

  short_url = "/" + params[:short_url]
  @url_object = Url.find_by_short_url(short_url)
  @url_object.visit
  erb :url
end