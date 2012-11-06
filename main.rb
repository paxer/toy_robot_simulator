require_relative 'lib/robo_script'
require_relative 'lib/table'

puts 'Executing example "a" ...'
example_a = RoboScript.new 'test_data/a'
puts "#{example_a.execute}\n"

puts 'Executing example "b" ...'
example_b = RoboScript.new 'test_data/b'
puts "#{example_b.execute}\n"

puts 'Executing example "c" ...'
example_c = RoboScript.new 'test_data/c'
puts "#{example_c.execute}\n"