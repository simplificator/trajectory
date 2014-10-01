class Trajectory::Consumer
  attr_accessor :algorithm, :callbacks

  def initialize(algorithm)
    @algorithm = algorithm
    @callbacks = []
  end

  # {:data => {:x => Number, y: => Number}, :type => 'ball/detected',
  # :source => 'simplificator/1', :sequence => Number,
  # :created_at => Timestamp, :uuid => String}
  def point_received(json)
    line = @algorithm.point_received(json)
    if line
      line_detected(line)
    end
  end

  def on_line_detected(&block)
    callbacks << block
  end

  private

  def line_detected(json)
    callbacks.each do |callback|
      callback.call(json)
    end
  end
end