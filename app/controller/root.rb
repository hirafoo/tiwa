get '/' do
  @entries, @prev, @next = Entry.paginate({:page => params[:page], :order => [:id.desc]})
  @type = 'entry'
  erb :index
end

get '/answer' do
  @entries, @prev, @next = Entry.paginate({:page => params[:page], :order => [:updated_at.desc]})
  @type = 'entry'
  erb :index
end

get '/rate' do
  @answers, @prev, @next = Answer.paginate({:page => params[:page], :order => [:rate.desc]})
  @type = 'answer'
  erb :index
end

get '/author' do
  erb :author
end
