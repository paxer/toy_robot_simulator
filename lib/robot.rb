require_relative 'table'

class Robot
  attr_reader :x, :y, :facing, :surface

  FACING_POSITIONS = {:north => 'NORTH', :south => 'SOUTH', :east => 'EAST', :west => 'WEST'}

  def initialize(position = {})
    @x = position.fetch :x, 0
    @y = position.fetch :y, 0
    @facing = position.fetch :facing, :north
    @surface = position.fetch :surface, Table.new(5, 5)
  end

  def report
    "#{@x},#{@y},#{FACING_POSITIONS.fetch @facing}"
  end

  def command(command)
    if @surface
      case command
        when :move
          move
        when :left
          left
        when :right
          right
        else
          raise ArgumentError, 'Unknown command!'
      end
    end
  end

  private

  def move
    case @facing
      when :north
        @y = @y + 1 unless @y == @surface.y
      when :south
        @y = @y - 1 unless @y == 0
      when :east
        @x = x + 1 unless @x == @surface.x
      when :west
        @x = x - 1 unless @x == 0
    end
  end

  def left
    case @facing
      when :north
        @facing = :west
      when :south
        @facing = :east
      when :east
        @facing = :north
      when :west
        @facing = :south
    end
  end

  def right
    case @facing
      when :north
        @facing = :east
      when :south
        @facing = :west
      when :east
        @facing = :south
      when :west
        @facing = :north
    end
  end
end