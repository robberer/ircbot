#!/usr/bin/env jruby

require 'singleton'

HOST = ''
DBNAME = ''
DBUSER = ''
DBPASS = ''

class FactoidDB
  include Singleton
  attr_reader :db

  def initialize
    @db = Sequel.connect("jdbc:mysql://#{HOST}/#{DBNAME}?user=#{DBUSER}&password=#{DBPASS}")
  end
end
