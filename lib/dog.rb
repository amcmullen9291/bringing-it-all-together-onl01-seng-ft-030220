class Dog 

attr_accessor :name, :breed, :id

def initialize(attributes)
    #id: nil, name:, breed:
    attributes.each {|key, value| self.send(("#{key}="), value)}
    self.id ||= nil
  end
  
  def self.create_table
    sql = <<-SQL
    CREATE TABLE dogs (
    id INTEGER PRIMARY KEY,
    name TEXT,
    breed TEXT
    )
    SQL
    DB[:conn].execute(sql)
  end
  
  def self.drop_table
    sql = <<-SQL
    DROP TABLE dogs
    SQL
    DB[:conn].execute(sql)
  end 
  
  def save
    if self.id
      self.update
    else
      sql = <<-SQL
      INSERT INTO dogs (name, breed)
      VALUES (?,?)
      SQL
      
      DB[:conn].execute(sql, self.name, self.breed)
        @id = DB[:conn].execute("select last_insert_rowid()FROM dogs")[0][0]
        self
    end
  end

  def update
  sql = "UPDATE dogs SET name = ?, breed = ? WHERE id = ?"
  DB[:conn].execute(sql, self.name, self.breed, self.id)
  end

def self.create(name)
  dog = Dog.new(name) 
  dog.save
  dog
end

def self. new_from _db 
end 

def self.new_from_db(row)
    attributes= {
      :id => row[0],
      :name => row[1],
      :breed => row[2]
    }
    self.new(attributes)
  end

def self.find_by_id 
  
end

end 