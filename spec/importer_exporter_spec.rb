require 'spec_helper'

describe ImporterExporter do
	
	it 'should return the correct json format' do 
		file = "first name,last name,skill_1_name,skill_1_rating\nSeth,Pollack,Ruby,5/5"
		importer = StockItemCSVImporter.new(file, {header_converters: [:symbol]})
		exporter = JSONExporter.new
		importer_exporter = ImporterExporter.new(importer, exporter)
		expect(importer_exporter.export).to eq([{first_name: 'Seth', last_name: 'Pollack', skills:[{name: 'Ruby', rating:'5/5'}]}].to_json)
	end

	it 'should return the correct json format using custom header converter' do 
		file = "first name,last name,skill[1].name,skill[1].rating\nSeth,Pollack,Ruby,5/5"
		header_array_converter = lambda do |field| 
			match = field.match(/(\w+)\[(\d+)\].(\w+)/)
			match ? "#{match[1]}_#{match[2]}_#{match[3]}" : field
		end
		importer = StockItemCSVImporter.new(file, {header_converters: [header_array_converter, :symbol]})
		exporter = JSONExporter.new
		importer_exporter = ImporterExporter.new(importer, exporter)
		expect(importer_exporter.export).to eq([{first_name: 'Seth', last_name: 'Pollack', skills:[{name: 'Ruby', rating:'5/5'}]}].to_json)
	end

end