require_relative "../lib/mailer"
require "sidekiq"

class MailWorker
  include Sidekiq::Worker
  
  def perform(id)
    Mailer.deliver do 
      from    "eki_#{id}@eqbalq.com"
      to      "jill_#{id}@example.com"
      subject "Threading and Forking (#{id})"
      body    "Some content"
    end  
  end
end

