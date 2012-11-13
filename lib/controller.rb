class Controller
  attr_reader :x, :y, :facing

  FACING_POSITIONS = {:north => 'NORTH', :south => 'SOUTH', :east => 'EAST', :west => 'WEST'}

  def initialize(position = {}, surface)
    @x = position.fetch :x, 0
    @y = position.fetch :y, 0
    @facing = position.fetch :facing, :north
    @surface = surface
  end

  def facing_position
    FACING_POSITIONS.fetch @facing
  end

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
    end if @surface
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
    end if @surface
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
    end if @surface
  end
end