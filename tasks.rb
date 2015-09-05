Dir["tasks/*"].each {|file|
  require_relative file
}

$task_list = Task.constants.map {|c| Task.const_get(c)}.select{|c| c.is_a? Class}
