require './lib/stock_item_csv_importer'
require './lib/json_exporter'
require './lib/importer_exporter'

class App
	class << self
		def load_file
			File.open('./input.csv')
		end
		def get_importer
			StockItemCSVImporter.new(load_file, {header_converters: [:symbol]})
		end
		def get_exporter
			JSONExporter.new
		end
		def export
			File.write './output.json', ImporterExporter.new(get_importer, get_exporter).export
		end
	end
end

App.export