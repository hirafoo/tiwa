post "/answer/create/:entry_id" do
  if Answer.fix_create(params)
    redirect "/entry/#{params[:entry_id]}"
  else
    @error = 'ポストに失敗しました。'
    erb :error
  end
end

post "/answer/rate/:answer_id" do
  if answer = Answer.fix_rate(params)
    redirect back
  else
    @error = 'ポストに失敗しました。'
    erb :error
  end
end
