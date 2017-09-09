require 'parking_lot/version'

module ParkingLot
  # Your code goes here...
  class ParkingLot
    def run
      puts %(No of Parking Lots: )
      no_of_lots = gets.chomp.to_i
      puts %(No of Parking Lot is #{no_of_lots})
      lots = []
      pointer = 0
      loop do
        command = gets.chomp
        case
        when command == 'status'
          puts 'this is status'
          puts lots.inspect
        when command[0..3] == 'park'
          puts 'this is parking'
          _, reg_no, color = command.split(' ')
          lots << { register_no: reg_no,
                    color: color }
          pointer++
        when command[0..4] == 'leave'
          _, lot_no = command.split(' ')
          puts %(lot no #{lot_no} has left)
          lots[lot_no - 1][:register_no], lots[lot_no - 1][:color] = '', ''
          pointer = lot_no
        end
      end
    end
  end
end
ParkingLot::ParkingLot.new.run
