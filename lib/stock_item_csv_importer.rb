require './lib/hash_array_mapper'
require './lib/csv_importer'

CSV::Converters[:currency] = lambda {|field| field.match(/\$/) ? field.gsub('$', '').to_f : field}

class StockItemCSVImporter
	include CSVImporter
	def initialize(file, config)
		defaults = {col_sep: ',', headers: true, converters: [:all, :currency]}
		@file = file
		@config = defaults.merge(config)
	end	
	def import
		parse.map{|r| HashArrayMapper.map(r.to_hash)}
	end
end