require 'cinch'
require 'yaml'
require_relative 'tasks'

conf = YAML.load_file("conf.yml")
bot = Cinch::Bot.new do
  configure do |c|
    c.server = conf["server"]
    c.port = conf["port"]
    c.ssl.use = conf["use_ssl"]
    c.user = conf["user"]
    c.nick = conf["nick"]
    c.realname = conf["realname"]
    c.channels = conf["channels"]
  end

  on :message do |m|
    $task_list.each {|t| t.message(m)}
  end

  on :join do |m|
    $task_list.each {|t| t.join(m)}
  end

  on :kick do |m|
    if conf["rejoin"] and m.params[1] == m.bot.nick
      m.bot.join m.params[0]
    end
  end
end

$task_list.each{|t| t.initialize}

bot.start
