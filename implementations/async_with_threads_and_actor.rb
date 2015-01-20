require "./lib/mailer"
require "benchmark"
require "celluloid"

class MailWorker
  include Celluloid

  def send_email(id)
    Mailer.deliver do 
      from    "eki_#{id}@eqbalq.com"
      to      "jill_#{id}@example.com"
      subject "Threading and Forking (#{id})"
      body    "Some content"
    end       
  end
end

mailer_pool = MailWorker.pool(size: 10)

10_000.times do |i|
  mailer_pool.async.send_email(i)
end
