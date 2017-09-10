require 'parking_lot/version'
require 'command_operation'

module ParkingLot
  # Parking slot problem
  class ParkingLot < CommandOperation
    # execute by command line
    def command_line(create_parking_lot)
      vacant_slot = []
      vacant_slot, no_of_slots = initialise_vacant_slot(create_parking_lot,
                                                        vacant_slot)
      occupied_slot = []
      slots = []
      loop do
        command = gets.chomp
        operation(command, vacant_slot, occupied_slot, slots, no_of_slots)
      end
    end

    # execute by file read
    def file_read(file_name)
      lines = File.readlines(file_name)
      vacant_slot = []
      occupied_slot = []
      slots = []
      no_of_slots = 0
      if lines.first[0..17] == 'create_parking_lot'
        vacant_slot, no_of_slots = initialise_vacant_slot(lines.first,
                                                          vacant_slot)
      end
      lines.each do |line|
        operation(line, vacant_slot, occupied_slot, slots, no_of_slots)
      end
    end

    # run
    def run
      first_command = gets.chomp
      if first_command.include?('.txt')
        file_read(first_command)
      else
        command_line(first_command)
      end
    end
  end
end
ParkingLot::ParkingLot.new.run
