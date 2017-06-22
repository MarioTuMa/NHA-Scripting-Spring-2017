require "open-uri"
require 'nokogiri'
require 'mechanize'
require "json"


quora=Nokogiri::HTML(open("https://www.quora.com/pinned/New-York-City"))

descriptions=[]
quora.css("title").each do |thing|
  descriptions.push(thing.text)
end
p descriptions
p "That works with a 1/2 chance. Plesase try up to 5 times before giving up."
