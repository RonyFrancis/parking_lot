module ParkingLot
  # Command Operation for Parking Lot
  class CommandOperation
    # Shows Status of Parking Lot
    def status(lots)
      puts 'this is status'
      puts 'Slot NO         Registration No           Colour'
      lots.each do |slot|
        puts %(#{slot[:slot_id]}       #{slot[:reg_no]}      #{slot[:color]})
      end
    end

    # Parking operation
    def parking(command, lots, occupied_lot, vacant_lot)
      _, reg_no, color = command.split(' ')
      lots << { reg_no: reg_no, color: color, slot_id: vacant_lot.first }
      puts 'this is command_operation'
      occupied_lot << vacant_lot.first
      vacant_lot.delete(vacant_lot.first)
      lots.sort_by!{|slot| slot[:slot_id]}
      return lots, occupied_lot, vacant_lot
    end

    # leaving Operation
    def leave(command, lots, occupied_lot, vacant_lot)
      lot_no = command.split(' ')[1].to_i
      puts lot_no
      puts %(lot no #{lot_no} has left)
      lots.delete_at(lot_no - 1)
      occupied_lot.delete(lot_no)
      vacant_lot << lot_no
      vacant_lot.sort!
      return lots, occupied_lot, vacant_lot
    end

    # fetch slots of car with specified color
    def fetch_coloured_car(color, slots)
      car_slots = []
      slots.each do |slot|
        car_slots << slot[:slot_id] if slot[:color] == color
      end
      puts car_slots.empty? ? 'Not Found' : car_slots.join(',')
    end

    # fetch slot no of car with specified registration no
    def fetch_slot_no(reg_no, slots)
      car_slots = []
      slots.each do |slot|
        car_slots << slot[:slot_id] if slot[:reg_no] == reg_no
      end
      puts car_slots.empty? ? 'Not Found' : car_slots.join(',')
    end
  end
end
