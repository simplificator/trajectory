require_relative '../spec_helper'

RSpec.describe Trajectory::VectorAngle do


  it 'does stuff' do
    points, lines_expected = PointsGenerator.new(:number_of_points => 3).generate
    algo = Trajectory::VectorAngle.new
    cons = Trajectory::Consumer.new(algo)

    result = []
    cons.on_line_detected do |json|
      result << json
    end

    points.each do |point|
      cons.point_received(point)
    end


    expect(result.length).to eq(lines_expected.length)

    lines_expected.each_with_index do |item, index|
      expect(result[index]).to eq(item)
    end

  end
end
