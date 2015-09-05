require_relative 'base'

module Task
  class HelloTask < BaseTask
    def self.message(m)
      user, message = parse(m)
      if message == "Hello"
        m.reply "Hello, #{user}!"
      end
    end
  end
end
