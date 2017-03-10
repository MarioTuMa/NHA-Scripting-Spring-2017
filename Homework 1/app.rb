require "csv"
ary=Array.new
goodnumbers=Array.new
File.open("import_telephone_numbers.csv").each do |line|
  ary.push(line)
end
ary.each do |row|
  characters= row.split("")
  justnumbers=Array.new
  characters.each do |character|
    if character== (character.to_i).to_s
      justnumbers.push(character)
    end

  end
  #p justnumbers
  goodnumbers.push(justnumbers)
end
CSV.open("formednumbers.csv", "wb") do |csv|
  goodnumbers.each do |telephonenumber|
    if telephonenumber.length==11

      csv << ["1-"+telephonenumber[1]+telephonenumber[2]+telephonenumber[3]+"-"+telephonenumber[4]+telephonenumber[5]+telephonenumber[6]+"-"+telephonenumber[7]+telephonenumber[8]+telephonenumber[9]+telephonenumber[10]]
    else

      csv << ["1-"+telephonenumber[0]+telephonenumber[1]+telephonenumber[2]+"-"+telephonenumber[3]+telephonenumber[4]+telephonenumber[5]+"-"+telephonenumber[6]+telephonenumber[7]+telephonenumber[8]+telephonenumber[9]]
    end
  end
end
