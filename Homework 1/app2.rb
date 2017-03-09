require "csv"
require "json"

water=Array.new
crime_offences=Array.new
crime_lat=Array.new
crime_lng=Array.new
crime=Array.new
File.open("Water_Quality_complaints.csv").each do |line|
    line=line.split(",")
    if line[8]==(line[8].to_i).to_s
      water.push(line[6]+", "+line[8])
    end

end


File.open("NYPD_Complaint_Data_Current_YTD.csv").each do |line|
    line=line.split(",")
    ind=line.length
    crime.push(line[7]+","+line[ind-2]+","+line[ind-2])
    crime_offences.push(line[7])
    crime_lat.push(line[ind-4])
    crime_lng.push(line[ind-3])
end

File.open("places.json", "wb") do |json|
  json << '{"water":['
  i=0
  water.each do |complaint|
    i=i+1
    complaints=complaint.split(", ")
    json<< '{"zip": '+complaints[1]+', "reason_for_complaint": "'+complaints[0]+'"}'
    if i<water.length
      json<< ','
    end
  end
  json<< '],"crime":['
  j=-1
  crime_offences.each do |complaint|
    j=j+1
    if (crime[j].split(",").length==3) && (j != 0)

      json<< '{"coordinates": {"lat":'+crime_lat[j]+','+'"lng":'+crime_lng[j]+'}, "crime": "'+crime_offences[j]+'"}'
      if j<crime_offences.length-1
        json<< ','
      end
    end
  end
  json<< ']}'
end
