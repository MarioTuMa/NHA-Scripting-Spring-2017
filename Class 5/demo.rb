require "open-uri"
require 'nokogiri'
require 'mechanize'
require "json"
word="jacket"
doc=Nokogiri::HTML(open("https://www.bradsdeals.com/search?query="+word))
#puts doc.class
#p doc.css(".col")
offers= doc.css("script")
jsonthingineed=""
offers.each do |offer|
  #p offer.text[27..44]
  #p "searchesController"
  if offer.text[27..44]=="searchesController"
   jsonthingineed=offer.text
  else
    #p "L"
  end
end

#p (offers[offers.length-3].text).split("searchesControllerShow, ")
str= (offers[offers.length-12].text).chomp(");")
p str
str = str[52...str.length-3]
#p str

File.open("offersfrombrad.json", "wb") do |json|
  json << jsonthingineed[52...jsonthingineed.length-3]
end
