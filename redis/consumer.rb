require "redis"
require 'json'
redis = Redis.new

trap(:INT) { puts; exit }

count = 0
begin
  redis.subscribe(:test) do |on|
    on.message do |channel, message|
      if count == 0
        puts "start"
      end
      count += 1
      if (count % 1000) == 0
        puts "received batch"
      end
    end

  end
rescue Redis::BaseConnectionError => error
  puts "#{error}, retrying in 1s"
  sleep 1
  retry
end