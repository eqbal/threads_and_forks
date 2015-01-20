require "./lib/mailer"
require "benchmark"
require 'thread'

POOL_SIZE = 10

# Create a Queue data structure for the jobs needs to be done. 
# Queue is thread-safe so if multiple threads
# access it at the same time, it will maintain consistency
jobs = Queue.new

# Push the IDs of mailers to the job queue
10_0000.times{|i| jobs.push i}

# Transform an array of 10 numbers into an array of workers
workers = (POOL_SIZE).times.map do
  Thread.new do
    begin
      while x = jobs.pop(true)
        Mailer.deliver do 
          from    "eki_#{x}@eqbalq.com"
          to      "jill_#{x}@example.com"
          subject "Threading and Forking (#{x})"
          body    "Some content"
        end        
      end
    rescue ThreadError
    end
  end
end

workers.map(&:join)
