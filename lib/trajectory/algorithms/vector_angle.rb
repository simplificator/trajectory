class Trajectory::VectorAngle

  MIN_ANGLE = (Math::PI / 90)

  def initialize
    @previous_points = []
  end

  def point_received(point)
    previous_points << point

    if previous_points.size <= 2
      return nil
    end
    p "points #{previous_points.size}: #{previous_points[-2..-1]}"
    if !do_points_form_line?
      line = generate_line
      p "prev: #{previous_points}"
      previous_points = previous_points[-2..-1]
      puts "after: #{previous_points.size}"
      line
    else
      nil
    end
  end

  private

  def generate_line
    start_point = previous_points.first
    end_point   = previous_points.last

    {
      'type' => 'trajectory/detected',
      'source' => start_point['source'],
      'data' => {
        'x1' => start_point['data']['x'],
        'y1' => start_point['data']['y'],
        'x2' => end_point['data']['x'],
        'y2' => end_point['data']['y'],
        't1' => start_point['created_at'],
        't2' => end_point['created_at']
      }
    }
  end

  def do_points_form_line?
    vectors = []
    previous_points.each_cons(2) do |p1, p2|
      p1x = p1['data']['x']
      p1y = p1['data']['y']
      p2x = p2['data']['x']
      p2y = p2['data']['y']

      vector = Vector.elements([(p2x - p1x), (p2y - p1y)])
      vectors << vector
    end

    angles = vectors.each_cons(2).map do |v1, v2|
      radiant_angle(v1, v2)
    end

    angles.all? do |angle|
      angle < MIN_ANGLE
    end
  end

  def radiant_angle(vector1, vector2)
    angle = Math.atan2(vector2[1], vector2[0]) - Math.atan2(vector1[1], vector1[0])
    angle.abs
  end

  attr_accessor :previous_points

end
