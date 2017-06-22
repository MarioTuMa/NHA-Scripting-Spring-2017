require "open-uri"
require 'nokogiri'
require 'mechanize'
require "json"

fivethirtyeight=Nokogiri::HTML(open("https://projects.fivethirtyeight.com"))
headlines=[]
fivethirtyeight.css("p.hed").each do |thing|
  headlines.push(thing.text)
end
p headlines
