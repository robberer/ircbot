#!/usr/bin/env jruby

class GetFactoid
  include Cinch::Plugin
  match /info.*/

  def execute(m)
    dbi = FactoidDB.instance
    factoids = dbi.db[:factoids]

    case
    when m.message == '!info'
      r = factoids.order{rand{}}.first
      m.reply "#{r[:factoid_key]}: #{r[:factoid_value]} [#{r[:factoid_author]} " +
        "#{r[:factoid_timestamp].strftime('%Y-%m-%d')}]"
      
    when m.message =~ /!info .*/
      key = m.message.gsub(/^!info/, '').strip
      r = factoids.where('factoid_key = ?', key).select
      
      unless r.empty?
        str = "#{key}:"
        r.each do |s|
          str << " #{s[:factoid_value]} [#{s[:factoid_author]} " +
            "#{s[:factoid_timestamp].strftime('%Y-%m-%d')}] ||"
        end
        m.reply str.gsub(/\|\|$/, '')
      else
        m.reply "Huh? No idea."
      end
    end
  end
end