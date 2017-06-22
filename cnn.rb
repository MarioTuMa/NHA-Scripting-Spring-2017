require "open-uri"
require 'nokogiri'
require 'mechanize'
require "json"

cnn=Nokogiri::HTML(open("http://edition.cnn.com"))

headers=[]
cnn.css("span").each do |thing|
  headers.push(thing.text)
end
p headers
