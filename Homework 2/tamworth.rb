require "google_drive"


session = GoogleDrive::Session.from_config("config.json")

ws = session.spreadsheet_by_key("1gtwcWduoh0sALs3OCIk3HgX3Q70gA36Wv-5_9DpVrx0").worksheets[0]

def tosheet(number)
   unit=number%10
   ten=(number-unit)/10
   
   return [ten+1,unit+1]
end
# Gets content of A2 cell.
#p ws[2, 1]  #==> "hoge"

# Changes content of cells.
# Changes are not sent to the server until you call ws.save().
arr=[*0..99]
arr=arr.shuffle

[*0..99].each do |n|
  col=tosheet(arr[n])[0]
  row=tosheet(arr[n])[1]
  ws[col,row]=""
end
[*0..14].each do |n|
  col=tosheet(arr[n])[0]
  row=tosheet(arr[n])[1]
  ws[col,row]="F"
end
ws.save()
# Dumps all cells.
(1..ws.num_rows).each do |row|
  (1..ws.num_cols).each do |col|
    #p ws[row, col]
  end
end

# Yet another way to do so.
#p ws.rows  #==> [["fuga", ""], ["foo", "bar]]

# Reloads the worksheet to get changes by other clients.
ws.reload
