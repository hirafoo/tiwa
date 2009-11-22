#!/usr/bin/ruby
require "rubygems"
require 'sinatra'
require "dm-core"
require "dm-timestamps"
require 'dm-validations'
require "yaml"
require "pp"

@env = ENV["TIWA_ENV"] || "development"
db  = YAML::load_file('config/database.yaml')[@env]

DataMapper.setup(:default, {
  :adapter  => db["adaptor"],
  :database => db["database"],
  :username => db["username"],
  :password => db["password"],
  :host     => db["host"]
})

if @env == 'development'
  DataObjects::Mysql.logger = DataObjects::Logger.new('./tmp/dm.log', 0)
end

(Dir::glob("app/{controller,model}/*.rb")).each do |file|
  require file
end

not_found do
  @error = 'ページが見つかりません。'
  erb :error
end

helpers do
  alias_method :h, :escape_html

  def post2twitter(entry, answer)
    "#{entry.item_a} と #{entry.item_b} の違い…#{answer.content.gsub(/<br \/>/, ' ')} - http://tiwa.hirafoo.net/entry/#{entry.id}"
  end

  def fix_request(org_url, http_host, forwarded_host)
    org_url.sub(/#{http_host}/, forwarded_host)
  end

  def partial(template, options = {})
    erb "_#{template}".to_sym, options.merge(:layout => false)
  end
end

set :views, File.dirname(__FILE__) + '/../app/view'
#enable :sessions
