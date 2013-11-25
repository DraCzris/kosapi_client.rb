module KOSapiClient
  module Entity
    module DataMappings

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods

        def map_data(name, type=String)
          attr_accessor name
          @@data_mappings ||= {}
          @@data_mappings[self] ||= {}
          @@data_mappings[self][name] = type
        end

        def parse(content)
          instance = new()
          @@data_mappings[self].each do |name, type|
            value = convert_type(content[name], type)
            instance.send("#{name}=".to_sym, value)
            #instance.instance_variable_set(name, value)
          end
          instance
        end

        def convert_type(value, type)
          return value.to_i if type == Integer
          return value if type == String
          return Time.parse(value) if type == Time
          return Link.parse(value) if type == Link
          raise "Unknown type #{type} to convert to"
        end
      end
    end
  end
end