#!/usr/bin/env jruby

require 'securerandom'

class GetRandomNumber
  include Cinch::Plugin
  match /random\s*\d*/

  def execute(m)
    i = m.message.gsub('random', '').strip
    m.reply(SecureRandom.random_number i) unless i.nil?
    m.reply SecureRandom.random_number if i
  end
end