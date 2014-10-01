require "redis"


redis = Redis.new
#data = File.read('/Users/pascal/Desktop/payload.png') * 100

t1 = Time.now
count = 1000
count.times do
  redis.publish('test', "hallo")
end

t2 = Time.now
puts "published #{count} messages in #{(t2 - t1) / 1000.0}"
