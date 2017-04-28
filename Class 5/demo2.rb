require 'mechanize'

a = Mechanize.new
word="Backpack"

a.get('https://www.bradsdeals.com/search?query='+word) do |page|
  search_result = page.form_with(:name => 'f') do |search|
    #search.q = 'Hello worlds'
  end

  search_result.inputs.each do |link|
    puts link
  end
end


#https://www.google.com/alerts/preview?params=%5Bnull%2C%5Bnull%2Cnull%2Cnull%2C%5Bnull%2C%22s%22%2C%22com%22%2C%5Bnull%2C%22en%22%2C%22US%22%5D%2Cnull%2Cnull%2Cnull%2C0%2C1%5D%2Cnull%2C3%2C%5B%5Bnull%2C1%2C%22mtutuncumacias1%40gmail.com%22%2C%5Bnull%2Cnull%2C23%5D%2C2%2C%22en-US%22%2Cnull%2Cnull%2Cnull%2Cnull%2Cnull%2C%220%22%2Cnull%2Cnull%2C%22AB2Xq4hcilCERh73EFWJVHXx-io2lhh1EhC8UD8%22%5D%5D%5D%2C0%5D
