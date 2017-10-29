module Concerns::Findable
#is added as a class method to classes that extend the module
    def find_by_name(name)
#searching the extended class's @@all variable for an instance that matches the provided name
      @@all.find{ |instance| instance.name == name}
    end

    def find_or_create_by_name(name)
      find_by_name(name) || create(name)
    end
end
