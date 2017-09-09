require 'parking_lot/version'
require 'command_operation'

module ParkingLot
  # Your code goes here...
  class ParkingLot < CommandOperation
    def run
      puts %(No of Parking Lots: )
      no_of_lots = gets.chomp.to_i
      puts %(No of Parking Lot is #{no_of_lots})
      vacant_lot = []
      (1..no_of_lots).each do |lot|
        vacant_lot << lot
      end
      occupied_lot = []
      lots = []
      loop do
        command = gets.chomp
        if command == 'status'
          status(lots)
        elsif command[0..3] == 'park'
          if occupied_lot.size != no_of_lots
            lots, occupied_lot, vacant_lot = parking(command,
                                                     lots,
                                                     occupied_lot,
                                                     vacant_lot)
          else
            puts 'parking is full'
          end
        elsif command[0..4] == 'leave'
          lots, occupied_lot, vacant_lot = leave(command,
                                                 lots,
                                                 occupied_lot,
                                                 vacant_lot)
        elsif command[0..32] == 'slot_numbers_for_cars_with_colour'
          color = command.split(' ')[1]
          fetch_coloured_car(color, lots)
        elsif command[0..34] == 'slot_number_for_registration_number'
          reg_no = command.split(' ')[1]
          fetch_slot_no(reg_no, lots)
        end
      end
    end
  end
end
ParkingLot::ParkingLot.new.run
