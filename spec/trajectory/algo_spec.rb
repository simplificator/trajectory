require_relative '../spec_helper'

RSpec.describe Trajectory::VectorAngle do


  it 'does stuff' do
    points, lines_expected = PointsGenerator.new(:number_of_points => 3)
    algo = Trajectory::VectorAngle.new
    cons = Trajectory::Consumer.new(algo)

    result = []
    cons.on_line_detected do |json|
      result << json
    end

    points.each do |point|
      cons.point_received(point)
    end

    p result

  end
end
