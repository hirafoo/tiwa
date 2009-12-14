require 'app/model/base'

class Answer < Tiwa::Model::Base
  include DataMapper::Resource
  belongs_to :entry

  property :id,       Serial
  property :entry_id, Integer, :required => true, :default => 0
  property :name,     String,  :required => true, :default => '', :length => 0..255
  property :rate,     Integer, :required => true, :default => 0
  property :content,  String,  :required => true, :default => '', :length => 0..255
  property :deleted,  Boolean, :required => true, :default => 0
  timestamps :at

  def self.fix_create(params)
    if params[:content].length != 0 and params[:name].length != 0 and entry = Entry.get(params[:entry_id])
      params["content"] = ERB::Util.html_escape(params["content"])
      params["content"].gsub!(/\r\n|\r|\n/, "<br />")
      self.create(params)
      entry.increment('answers_count')
    else
      nil
    end
  end

  def self.fix_rate(params)
    if answer = Answer.get(params[:answer_id])
      answer.increment('rate')
      return answer
    else
      nil
    end
  end
end
