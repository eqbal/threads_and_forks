require "./lib/mailer"
require "benchmark"

puts Benchmark.measure{
  100.times do |i|
    Mailer.deliver do 
      from    "eki_#{i}@eqbalq.com"
      to      "jill_#{i}@example.com"
      subject "Threading and Forking (#{i})"
      body    "Some content"
    end
  end
}
