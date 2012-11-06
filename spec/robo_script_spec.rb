require_relative '../lib/robot'
require_relative '../lib/robo_script'

describe 'RoboScript' do
  let(:surface) { Table.new 5, 5 }
  let(:robo_script) { RoboScript.new 'spec/fixtures/example_robo_script' }

  it 'read script from the file path and create commands array' do
    robo_script.robot_commands.should_not be_empty
  end

  it 'raise and exception if PLACE command is not first' do
    expect { RoboScript.new 'spec/fixtures/incorrect_robo_script' }.to raise_error(ArgumentError)
  end

  context 'commands' do
    it 'create @robot instance on initialize' do
      robo_script.execute
      robo_script.robot.should be_a_kind_of(Robot)
    end

    it 'execute correctly' do
      robo_script.execute.should eql "--------------------------\nPLACE 0,0,NORTH\nRIGHT\nMOVE\nLEFT\nMOVE\nREPORT\nOutput: 1,1,NORTH\n"
    end
  end
end