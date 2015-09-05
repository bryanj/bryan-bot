module Task
  class BaseTask
    def self.initialize
    end

    def self.message(m)
    end

    def self.join(m)
    end

    def self.parse(m)
      user = m.user.nick
      message = m.message
      if m.user.name == "B"
        user, message = message.match(/^<([^>]+)> (.*)$/)[1..2]
      end
      [user, message]
    end
  end
end
