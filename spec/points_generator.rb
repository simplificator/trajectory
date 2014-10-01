class PointsGenerator
  attr_accessor :number_of_points, :range, :noise

  def initialize(options = {})
    @number_of_points = options[:number_of_points]
    @noise = 1
    @range = 10
  end


  def generate
    previous = nil
    points = (0..number_of_points).map do
      if previous
        previous = random_point_not_on_line(previous)
      else
        previous = random_point
      end
    end

    points_json = points.each_with_index.map do |item, index|
      build_point(item, index)
    end

    lines_json = points_json.each_cons(2).map do |p1, p2|
      build_line(p1, p2)
    end
    [points_json, lines_json]
  end


  private

  def build_line(p1, p2)
    {
      'type' => 'trajectory/detected', 'sequence' => 0, 'created_at' => Time.now, 'source' => p1['source'], 'data' => {
        'x1' => p1['data']['x'],
        'y1' => p1['data']['y'],
        'x2' => p2['data']['x'],
        'y2' => p2['data']['y'],
        't1' => p1['created_at'],
        't2' => p2['created_at'],
      }

    }

  end

  def build_point(item, index)
    {'type' => 'ball/detected', 'sequence' => index, 'created_at' => Time.now, 'source' => 'generator', 'data' => {
        'x' => item[0],
        'y' => item[1]
        }}
  end


  def random_point
    [rand(range), rand(range)]
  end

  def random_point_not_on_line(previous)
    x_or_y = rand > 0.5 ? 1 : 0
    multiplier = rand > 0.5 ? 1 : -1
    point = []
    point[0] = previous[0]
    point[1] = previous[1]
    point[x_or_y] = point[x_or_y] + multiplier * rand(range)
    point
  end
end


g = PointsGenerator.new(:number_of_points => 10)
p g.generate