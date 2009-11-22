get %r{/entry/(\d+)} do
  entry_id = params[:captures].first

  if @entry = Entry.get(entry_id)
    @answers, @prev, @next = Answer.paginate({:page => params[:page], :entry_id => entry_id, :deleted => 0, :order => [:created_at.desc]})
    erb :"entry/index"
  else
    not_found
  end
end

post "/entry/create" do
  @result = Entry.valid_create(params[:post])
  erb :"entry/create"
end
