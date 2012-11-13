require_relative 'table'
require_relative 'controller'

class Robot
  attr_reader :surface, :controller

  def initialize(position = {})
    @surface = position.fetch :surface, Table.new(5, 5)
    @controller = position.fetch :controller, Controller.new(position, @surface)
  end

  def report
    "#{controller.x},#{controller.y},#{controller.facing_position}"
  end
end