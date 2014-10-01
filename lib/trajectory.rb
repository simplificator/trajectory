module Trajectory
end

require_relative 'trajectory/consumer'
require_relative 'trajectory/algorithms/stupid'

c = Trajectory::Consumer.new(Trajectory::Stupid.new)


c.on_line_detected do |json|
  puts "got line: #{json}"
end


c.point_received({
  'data' => {
    'x' => 0.5,
    'y' => 0.5
  },
  'created_at' => Time.now
})
c.point_received({
  'data' => {
    'x' => 0.5,
    'y' => 0.5
  },
  'created_at' => Time.now
}
)