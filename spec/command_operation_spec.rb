require 'spec_helper'
require 'command_operation'
RSpec.describe ParkingLot::CommandOperation do
  before(:each) do
    @command_operation ||= ParkingLot::CommandOperation.new
  end
  describe 'initialise_vacant ' do
    before(:each) do
      @command = 'create_parking_lot 6'
    end
    it 'should create a array of 6' do
      vacant_slot, no_of_slots = @command_operation.initialise_vacant_slot(@command, [])
      expect(no_of_slots).to be 6
      expect(vacant_slot.class).to be Array
      expect(vacant_slot.size).to be 6
    end
  end

  describe 'parking' do
    before(:each) do
      @occupied_lot = []
      @vacant_lot = [1, 2, 3]
      @slots = []
      @command = 'park KA-01-HH-1234 White'
    end
    it 'create a new entry in slots' do
      @slots, @occupied_lot, @vacant_lot = @command_operation.parking(@command,
                                                                      @slots,
                                                                      @occupied_lot,
                                                                      @vacant_lot)
      expect(@slots.size).to be 1
      expect(@slots.first).to include(:reg_no, :color, :slot_id)
      expect(@occupied_lot.size).to be 1
      expect(@vacant_lot.size).to be 2
    end
  end

  describe 'leaving parking slot' do
    before(:each) do
      @occupied_lot = [1]
      @vacant_lot = [ 2, 3]
      @slots = [{ :reg_no=>"KA-01-HH-1234", :color=>"White", :slot_id=>1 }]
      @command = 'leave 1'
    end
    it 'delete entry in slots' do
      @slots, @occupied_lot, @vacant_lot = @command_operation.leave(@command,
                                                                      @slots,
                                                                      @occupied_lot,
                                                                      @vacant_lot)
      expect(@slots.size).to be 0
      expect(@occupied_lot.size).to be 0
      expect(@vacant_lot.size).to be 3
    end
  end

  describe 'fetch_coloured_car' do
    before(:each) do
      @slots = [{ :reg_no=>"KA-01-HH-1234", :color=>"White", :slot_id=>1 }]
      @command = 'slot_numbers_for_cars_with_colour White'
    end
    it 'return colored cars' do
      expect(@command_operation.fetch_coloured_car(@command, @slots)).to be (puts "1")
    end
  end
end
