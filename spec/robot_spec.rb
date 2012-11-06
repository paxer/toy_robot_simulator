require_relative '../lib/robot'
require_relative '../lib/table'

describe 'Robot' do

  context 'can be placed on the square table' do
    it 'on default coordinates if not specified' do
      robot = Robot.new
      robot.report.should eql '0,0,NORTH'
    end

    it 'on specific coordinates' do
      robot = Robot.new :x => 2, :y => 3, :facing => :south
      robot.report.should eql '2,3,SOUTH'
    end
  end

  context 'non on the surface' do
    let(:robot) { Robot.new :x => 1, :y => 1, :facing => :south, :surface => nil }

    it 'can not move ' do
      robot.command :move
      robot.report.should eql '1,1,SOUTH'
    end

    it 'can not rotate left' do
      robot.command :left
      robot.report.should eql '1,1,SOUTH'
    end

    it 'can not rotate right' do
      robot.command :right
      robot.report.should eql '1,1,SOUTH'
    end
  end

  context 'on the surface' do

    let(:surface) { Table.new 5, 5 }

    context 'can move in the direction it is currently facing' do

      it 'move forward if facing is NORTH' do
        robot = Robot.new :surface => surface
        robot.command :move
        robot.report.should eql '0,1,NORTH'
      end

      it 'move backward if facing is SOUTH' do
        robot = Robot.new :x => 1, :y => 1, :facing => :south, :surface => surface
        robot.command :move
        robot.report.should eql '1,0,SOUTH'
      end

      it 'move left if facing is WEST' do
        robot = Robot.new :x => 1, :y => 1, :facing => :west, :surface => surface
        robot.command :move
        robot.report.should eql '0,1,WEST'
      end

      it 'move right if facing is EAST' do
        robot = Robot.new :x => 1, :y => 1, :facing => :east, :surface => surface
        robot.command :move
        robot.report.should eql '2,1,EAST'
      end

      it 'ignore move command if it will result to falling from the surface' do
        robot = Robot.new :x => 5, :y => 0, :facing => :east, :surface => surface
        robot.command :move
        robot.report.should eql '5,0,EAST'

        robot = Robot.new :x => 0, :y => 5, :facing => :north, :surface => surface
        robot.command :move
        robot.report.should eql '0,5,NORTH'

        robot = Robot.new :x => 0, :y => 0, :facing => :west, :surface => surface
        robot.command :move
        robot.report.should eql '0,0,WEST'
      end
    end

    context 'can rotate to the LEFT' do
      context 'when faced to the NORTH' do
        it 'change direction to the WEST' do
          robot = Robot.new :surface => surface
          robot.command :left
          robot.report.should eql '0,0,WEST'
        end
      end

      context 'when faced to the SOUTH' do
        it 'change direction to the EAST' do
          robot = Robot.new :facing => :south, :surface => surface
          robot.command :left
          robot.report.should eql '0,0,EAST'
        end
      end

      context 'when faced to the EAST' do
        it 'change direction to the NORTH' do
          robot = Robot.new :facing => :east, :surface => surface
          robot.command :left
          robot.report.should eql '0,0,NORTH'
        end
      end

      context 'when faced to the WEST' do
        it 'change direction to the SOUTH' do
          robot = Robot.new :facing => :west, :surface => surface
          robot.command :left
          robot.report.should eql '0,0,SOUTH'
        end
      end
    end

    context 'can rotate to the RIGHT' do
      context 'when faced to the NORTH' do
        it 'change direction to the EAST' do
          robot = Robot.new :surface => surface
          robot.command :right
          robot.report.should eql '0,0,EAST'
        end
      end

      context 'when faced to the SOUTH' do
        it 'change direction to the WEST' do
          robot = Robot.new :facing => :south, :surface => surface
          robot.command :right
          robot.report.should eql '0,0,WEST'
        end
      end

      context 'when faced to the EAST' do
        it 'change direction to the SOUTH' do
          robot = Robot.new :facing => :east, :surface => surface
          robot.command :right
          robot.report.should eql '0,0,SOUTH'
        end
      end

      context 'when faced to the WEST' do
        it 'change direction to the NORTH' do
          robot = Robot.new :facing => :west, :surface => surface
          robot.command :right
          robot.report.should eql '0,0,NORTH'
        end
      end
    end

    it 'return Exception on unknown command' do
      robot = Robot.new :surface => surface
      expect { robot.command :does_not_exist }.to raise_error(ArgumentError)
    end
  end
end