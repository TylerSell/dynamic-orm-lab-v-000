require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord
  
  def initialize(hash={})
    hash.each do |key, value|
      self.send("#{key}=, value")
    end
  end
  
  def self.table_name
    self.to_s.downcase.pluralize
  end
  
  def self.column_names
    DB[:conn].results_as_hash = true 
    
    table_col = DB[:conn].execute("PRAGMA table_info(#{self.table_name})")
    col_names = []
    
    table_col.each do |col|
      col_names << col["name"]
    end
    
    col_names.compact
  end
  
  def table_names_for_insert
    self.class.table_name
  end
  
  def col_names_for_insert
    self.class.column_names.delete_if {|column| column == "id"}.join(", ")
  end
  
  def values_for_insert
    values = []
    
    self.class.column_names.each do |column|
      values << "'#{send(column)}'" unless send(column).nil?
    end
    values.join(", ")
  end
  
  def save
    sql = <<-SQL
      INSERT INTO #{table_names_for_insert} (#{col_names_for_insert}) VALUES (#{values_for_insert})
    SQL
    
    DB[:conn].execute(sql)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM #{table_names_for_insert}")[0][0]
  end
  
  def self.find_by_name(name)
    
  end
  
  def self.find_by 
    column_name = attribute.keys[0].to_s
    value_name = attribute.values[0]

    sql = <<-SQL
      SELECT * FROM #{table_name}
      WHERE #{column_name} = ?
    SQL

    DB[:conn].execute(sql, value_name);
  end
end