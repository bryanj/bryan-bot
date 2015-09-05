require_relative 'base'

module Task
  class HelloTask < BaseTask
    def self.message(m)
      if m.message == "Hello"
        m.reply "Hello, #{m.user.name}!"
      end
    end
  end
end
