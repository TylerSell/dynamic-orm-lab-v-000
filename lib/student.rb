require_relative "../config/environment.rb"
require 'active_support/inflector'
require 'interactive_record.rb'

class Student < InteractiveRecord
  ATTRIBUTES = {
    :id => "INTEGER PRIMARY KEY",
    
  }
end
