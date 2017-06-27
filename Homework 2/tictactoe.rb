require "google_drive"


session = GoogleDrive::Session.from_config("config.json")

ws = session.spreadsheet_by_key("1cRKFBIizSpddvWs91byJYrtJI1_x3lkx22ZQRBlgI7Y").worksheets[0]

def tosheet(number)
   unit=number%3
   ten=(number-unit)/3
   
   return [ten+2,unit+1]
end


board=[[ws[2, 1],ws[2, 2],ws[2, 3]],[ws[3, 1],ws[3, 2],ws[3, 3]],[ws[4, 1],ws[4, 2],ws[4, 3]]]
turn=1
def clearboard(ws)
  p "clearing board"
  [*0..8].each do |n|
    col=tosheet(n)[0]
    row=tosheet(n)[1]
    ws[col,row]=""
  end  
  ws.save()
end  




def getturn(board,ws)
  numberofnotfilled=0
  [*0..8].each do |n|
    col=tosheet(n)[0]
    row=tosheet(n)[1]
    if(ws[col,row]=="")
      numberofnotfilled = numberofnotfilled+1
    end
    
  end
  if numberofnotfilled==9
    p "The board is clear and the game has reset. Last game Player 1's name was " + ws[2,6] + " and Player 2's name was "+ ws[2,7]
    p "Would you like to change your names? Enter y if yes, anything else to continue with the same names."
    change = gets.chomp
    if(change=="y")
      p "What is Player 1's name?"
      p1 = gets.chomp
      ws[2,6]=p1
      p "What is Player 2's name?"
      p2 = gets.chomp
      ws[2,7]=p2
    end  
  end  



  numberfilled=9-numberofnotfilled




  if(numberfilled%2==0)
    return true
  else
    return false
  end      
end











def boardfillchars(board,ws)
  filledboard=board
  [*0..8].each do |n|
    col=tosheet(n)[0]
    row=tosheet(n)[1]
    
    if(ws[col,row]=="")
      filledboard[col-2][row-1]=n.to_s
    end
  
  end 
  return filledboard
end
def printboard(board,ws)
  p boardfillchars(board,ws)[0]
  p boardfillchars(board,ws)[1]
  p boardfillchars(board,ws)[2]
end

def eval(board,ws,turn)
  list=[]
  winningcombos=[[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
  p "Evaluating."
  if(turn)
    [*0..8].each do |n|
      if(ws [tosheet(n)[0],tosheet(n)[1]]=="X")
        list.push(n)
      end
    end 
  else 
    [*0..8].each do |n|
      if(ws [tosheet(n)[0],tosheet(n)[1]]=="O")
        list.push(n)
      end
    end   
  end 
 
  if(list.length>=3)
    sublists=[]

    for i in 0..(list.length) do
      sublists = sublists + list.combination(i).to_a
    end
    win=false
    sublists.each do |sublist|
      winningcombos.each do |combo|
        if(sublist==combo)
          win=true
        end  
      end    
    end
    if (win)
      if (turn)
        p "Player 1 Wins"
        sleep(0.5)
        ws[2,8]=ws[2,8].to_i+1
        clearboard(ws)

      else
        p "Player 2 Wins"
        sleep(0.5)
        ws[2,9]=ws[2,9].to_i+1
        clearboard(ws)
      end

    else
      p "No win"
    end          
  else
    p "No win"
  end    
end



p "Here is the board so you remember what is where. Type the number of where you want to play. The X's and O's can't be replaced but the numbers can."
printboard(board,ws)
turn=getturn(board,ws)
#p turn
if(turn)
  puts "It's your turn Player 1."
else
  puts "It's your turn Player 2"
end
placement = gets.chomp
if (placement.to_i.to_s != placement)
  p "Pls put a number"
else

  validity=false
  [*0..8].each do |n|
    if(n==placement.to_i)
      validity=true
    end
  end 
  
  if validity
    str= ws [tosheet(placement.to_i)[0],tosheet(placement.to_i)[1]]
    if (str != "")
      p "pick an empty box plxaroo"
    else  
      if(turn) 
        #p [tosheet(placement.to_i)[0],tosheet(placement.to_i)[1]]
      ws [tosheet(placement.to_i)[0],tosheet(placement.to_i)[1]]="X"
      else
  
        #p [tosheet(placement.to_i)[0],tosheet(placement.to_i)[1]]
        ws [tosheet(placement.to_i)[0],tosheet(placement.to_i)[1]]="O"
      end    
      
      board=[[ws[2, 1],ws[2, 2],ws[2, 3]],[ws[3, 1],ws[3, 2],ws[3, 3]],[ws[4, 1],ws[4, 2],ws[4, 3]]]
      printboard(board,ws)
      recap=ws[2, 1]+","+ws[2, 2]+","+ws[2, 3]+","+ws[3, 1]+","+ws[3, 2]+","+ws[3, 3]+","+ws[4, 1]+","+ws[4, 2]+","+ws[4, 3]
      #p recap
      ws[2,10]=recap
      ws.save()
      eval(board,ws,turn)
    end  
  else
    "Pick a number from 0 to 8 plx"
  end  
 end

