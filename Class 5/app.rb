require "open-uri"
require 'nokogiri'
require 'mechanize'
require "json"
company="highsierra"
doc=Nokogiri::HTML(open("https://www.retailmenot.com/view/"+company+".com"))
#puts doc.class
#p doc.css(".col")
number= doc.css("li.js-offer-toggle")[0].children.to_s.split('data-main-tab="/out/')[1].split('"')[0]
offerpage=Nokogiri::HTML(open("https://www.retailmenot.com/view/"+company+".com?c="+number))
codes=[]
offerpage.css(".button-code").each do |thing|
  codes.push(thing.text)
end
p codes
