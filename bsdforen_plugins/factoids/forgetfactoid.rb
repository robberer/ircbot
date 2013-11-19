#!/usr/bin/env jruby

class ForgetFactoid
  include Cinch::Plugin
  match /forget.*/

  def execute(m)
   if m.message =~ /.* = .*/
    m.message.gsub!('!forget', '')
    ary = m.message.split(/ = /, 2)

    key = ary[0].strip
    value = ary[1].strip

    dbi = FactoidDB.instance
    factoids = dbi.db[:factoids]

    factoids.where('factoid_key = ? AND factoid_value = ?', key, value).delete
    m.reply 'Hmhmmm forgot...'
   end
  end
end