require_relative 'robot'

class RoboScript
  attr_reader :robot_commands, :robot

  def initialize(robo_script_path)
    robot_commands = IO.readlines(robo_script_path)
    raise ArgumentError, 'PLACE should be first' unless robot_commands.first.include?('PLACE')
    @robot_commands = robot_commands.map { |command| command.chomp }
  end

  def execute
    result = "--------------------------\n"

    @robot_commands.each do |command|
      result += "#{command}\n"

      case command
        when /^PLACE/
          command_and_arguments = command.split(' ')
          arguments = command_and_arguments[1].split(',')

          x = arguments[0].to_i
          y = arguments[1].to_i
          facing = Robot::FACING_POSITIONS.key(arguments[2])

          @robot = Robot.new :x => x, :y => y, :facing => facing
        when 'MOVE'
          @robot.command :move
        when 'LEFT'
          @robot.command :left
        when 'RIGHT'
          @robot.command :right
        when 'REPORT'
          result += "Output: #{@robot.report}\n"
        else
          result += "Unknown command!\n"
      end
    end
    result
  end
end