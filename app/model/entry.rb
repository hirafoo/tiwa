require 'app/model/base'

class Entry < Tiwa::Model::Base
  include DataMapper::Resource
  #has n, :answers

  property :id,            Serial
  property :name,          String,  :nullable => false, :default => '', :length => 0..255
  property :item_a,        String,  :nullable => false, :default => '', :length => 0..255
  property :item_b,        String,  :nullable => false, :default => '', :length => 0..255
  property :answers_count, Integer, :nullable => false, :default => 0
  property :deleted,       Boolean, :nullable => false, :default => 0
  timestamps :at

  def self.valid_create(params)
    entry = Entry.new(params)

    if entry.save
      return "投稿が完了しました。"
    else
      return "ポストに失敗しました。"
    end
  end
end
