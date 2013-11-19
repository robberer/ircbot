#!/usr/bin/env jruby

class LearnFactoid
  include Cinch::Plugin
  match /learn.*/
  

  def execute(m)
    dbi = FactoidDB.instance
    factoids = dbi.db[:factoids]

    if m.message =~ /!learn .* = .*/
      m.message.gsub!('!learn', '')
      ary = m.message.split(/ = /, 2)
      
      key = ary[0].strip
      value = ary[1].strip

      r = factoids.where('factoid_value = ? AND factoid_value = ?', key, value).select

      if r.empty?
        factoids.insert(:factoid_key => key, :factoid_value => value, :factoid_author => m.user.to_s,
        :factoid_channel => m.channel.to_s, :factoid_timestamp => Time.now)

        m.reply "Okay, learned #{key} = #{value}"
      else
        m.reply "Already know that."
      end

    else
      m.reply 'try: "!learn foo = bar"'
    end
  end
end