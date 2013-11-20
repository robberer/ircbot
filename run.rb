require 'rubygems'
require 'cinch'
require 'sequel'
require 'ircdb'
require "cinch/plugins/identify"
require "cinch/plugins/downforeveryone"
require 'cinch-calculate'

Dir['bsdforen_plugins/factoids/*'].each { |f| require_relative f }

NICKNAME = 'analtux'
PASSWORD = ''
USERNAME = 'analtux'
REALNAME = 'Analtux NG http://bsdforen.de'
IRCNET = 'irc.freenode.org'
CHANNELS = ['#bsdforen.de']
PLUGINS = [GetRandomNumber, GetFactoid, LearnFactoid, ForgetFactoid, Cinch::Plugins::Identify, Cinch::Plugins::Calculate, 
  Cinch::Plugins::DownForEveryone]

class IRCBot
  include Cinch::Plugin
  def initialize
    @bot = Cinch::Bot.new do
        configure do |c|
          c.plugins.plugins = PLUGINS
          c.encoding = 'utf-8'
          c.nick = NICKNAME
          c.plugins.options[Cinch::Plugins::Identify] = {
            :password => PASSWORD,
            :type => :nickserv
          }
          c.plugins.options[Cinch::Plugins::Calculate][:units_path] = '/usr/local/bin/gunits'

          c.user = USERNAME
          c.realname = REALNAME
          c.server = IRCNET
          c.channels = CHANNELS
      end
    end
  end

  def run
    @bot.start
  end
end

ib = IRCBot.new
ib.run
