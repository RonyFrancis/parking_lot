module ParkingLot
  # Command Operation for Parking Lot
  class CommandOperation
    # Shows Status of PArking Lot
    def status(lots)
      puts 'this is status'
      puts 'this CommandOperation'
      puts lots.inspect
    end

    # Parking operation
    def parking(command, lots, occupied_lot, vacant_lot)
      _, reg_no, color = command.split(' ')
      lots << { register_no: reg_no, color: color }
      puts 'this is command_operation'
      occupied_lot << vacant_lot.first
      vacant_lot.delete(vacant_lot.first)
      return lots, occupied_lot, vacant_lot
    end

    # leaving Operation
    def leave(command, lots, occupied_lot, vacant_lot)
      lot_no = command.split(' ')[2]
      puts %(lot no #{lot_no} has left)
      lots[lot_no - 1][:register_no] = ''
      lots[lot_no - 1][:color] = ''
      occupied_lot.delete(lot_no)
      vacant_lot << lot_no
      vacant_lot.sort!
      return lots, occupied_lot, vacant_lot
    end
  end
end
