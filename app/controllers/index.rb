get '/' do
  session.clear
  @events = Event.all
  erb :index
end

get '/events/:id/show' do |id|
  @event = Event.find(id)
  erb :event_show
end

get '/events/new' do
  @errors = {}
  @organizer_name, @organizer_email, @title, @date = nil, nil, nil, nil
  erb :event_create
end

post '/events/create' do
  p params
  @organizer_name, @organizer_email = params[:organizer_name], params[:organizer_email]
  @title, @date = params[:title], params[:date]
  @errors = {}
  @date = nil if unvalid_date?(@date)
  @title = nil if unvalid_title?(@title)
  @organizer_name = nil if unvalid_name?(@organizer_name)
  @organizer_email = nil if unvalid_email?(@organizer_email)
  if @errors.empty?
    event = Event.create(organizer_name: @organizer_name, organizer_email: @organizer_email,
  title: @title, date: Date.parse(@date))
  redirect "/events/#{event.id}/show"
  end
  erb :event_create
end
