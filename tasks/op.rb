module Task
  class OpTask < BaseTask
    def self.join(m)
      m.channel.op m.user if m.channel == "#Bryan"
    end
  end
end
