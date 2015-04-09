require 'csv'

module CSVImporter
	def parse
		CSV::parse(@file, @config)
	end
	def import
		parse.map(&:to_hash)
	end
end

