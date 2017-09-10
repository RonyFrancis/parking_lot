module ParkingLot
  # Command Operation for Parking Lot
  class CommandOperation
    # Shows Status of Parking Lot
    def status(lots)
      puts 'Slot NO         Registration No           Colour'
      lots.each do |slot|
        puts %(#{slot[:slot_id]}       #{slot[:reg_no]}      #{slot[:color]})
      end
    end

    # Parking operation
    def parking(command, lots, occupied_lot, vacant_lot)
      _, reg_no, color = command.split(' ')
      lots << { reg_no: reg_no, color: color, slot_id: vacant_lot.first }
      occupied_lot << vacant_lot.first
      vacant_lot.delete(vacant_lot.first)
      lots.sort_by!{ |slot| slot[:slot_id] }
      return lots, occupied_lot, vacant_lot
    end

    # leaving Operation
    def leave(command, lots, occupied_lot, vacant_lot)
      lot_no = command.split(' ')[1].to_i
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

    def fetch_reg_no(color, slots)
      car_slots = []
      slots.each do |slot|
        car_slots << slot[:reg_no] if slot[:color] == color
      end
      puts car_slots.empty? ? 'Not Found' : car_slots.join(',')
    end

    def operation(line, vacant_lot, occupied_lot, lots, no_of_lots)
      if line.strip == 'status'
        status(lots)
      elsif line[0..3] == 'park'
        if occupied_lot.size != no_of_lots
          lots, occupied_lot, vacant_lot = parking(line,
                                                   lots,
                                                   occupied_lot,
                                                   vacant_lot)
        else
          puts 'parking is full'
        end
      elsif line[0..4] == 'leave'
        lots, occupied_lot, vacant_lot = leave(line,
                                               lots,
                                               occupied_lot,
                                               vacant_lot)
      elsif line[0..32] == 'slot_numbers_for_cars_with_colour'
        color = line.split(' ')[1]
        fetch_coloured_car(color, lots)
      elsif line[0..34] == 'slot_number_for_registration_number'
        reg_no = line.split(' ')[1]
        fetch_slot_no(reg_no, lots)
      elsif line[0..40] == 'registration_numbers_for_cars_with_colour'
        color = line.split(' ')[1]
        fetch_reg_no(color, lots)
      end
    end

    def initialise_vacant_slot(park_slot, vacant_slot)
      no_of_slots = park_slot.split(' ')[1].to_i
      (1..no_of_slots).each do |slot|
        vacant_slot << slot
      end
      return vacant_slot, no_of_slots
    end
  end
end
