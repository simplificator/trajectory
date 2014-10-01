class Trajectory::Stupid
  def point_received(point)
    line = if @previous
      {
        'type' => 'trajectory/detected',
        'source' => point['source'],
        'data' => {
          'x1' => @previous['data']['x'],
          'y1' => @previous['data']['y'],
          'x2' => point['data']['x'],
          'y2' => point['data']['y'],
          't1' => @previous['created_at'],
          't2' => point['created_at']
        }
      }
    end
    @previous = point
    line
  end
end