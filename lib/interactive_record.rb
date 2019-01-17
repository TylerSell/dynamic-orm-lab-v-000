require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord
  
  def self.table_name
    self.to_s.downcase.pluralize
  end
  
  def self.column_names
    DB[:conn].execute()
  end
  
  def table_names_for_insert
    
  end
  
  def col_names_for_insert
    
  end
  
  def values_for_insert
    
  end
  
  def save
    sql = <<-SQL
      INSERT INTO #{self.table_name} (col_names_for_insert) VALUES (values_for_insert)
    SQL
    
    DB[:conn].execute(sql)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM #{self.table_name}")
  end
  
  def self.find_by_name
    
  end
  
  def self.find_by 
    
  end
end