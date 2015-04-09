require 'active_support/inflector'

module HashArrayMapper

  REGEX = /(\w+_\d+)_(\w+)/

  class << self
    
    def get_array_fields(hash)
      hash.select{|k| k.to_s.match(REGEX)}
    end

    def group_by_number_and_type(array_fields)
      array_fields.group_by{|k| k.to_s.match(REGEX)[1]}
    end

    def build_arrays(grouped_array_fields)
      temp = {}
      grouped_array_fields.each do |k, v|
        v.each do |group|
          regex = group[0].to_s.match(REGEX)
          key = regex[1]
          temp[key] ||= {}
          temp[key][regex[2].to_sym] = group[1]
        end
      end
      temp
    end

    def merge_arrays_with_hash(hash, arrays)
      arrays.each do |k, v|
        sym = k.gsub(/_\d+/, '').pluralize.to_sym
        hash[sym] ||= []
        hash[sym] << v unless v.select {|k,v| v}.empty?
      end 
      hash 
    end

    def remove_original_array_fields(hash, array_fields)
      array_fields.each{|r| hash.delete r[0].to_sym}
    end

    def map(hash)
      hash = hash.clone
      array_fields = get_array_fields(hash)
      remove_original_array_fields(hash, array_fields)
      grouped_array_fields = group_by_number_and_type(array_fields)
      arrays = build_arrays(grouped_array_fields)
      merge_arrays_with_hash(hash, arrays)
    end

  end
  
end