require 'spec_helper'

describe StockItemCSVImporter do 

	it 'should use included headers' do
		file = "first name,last name\nSeth,Pollack"
		importer = StockItemCSVImporter.new(file, {header_converters: [:symbol]})
		expect(importer.import.first).to eq({first_name: 'Seth', last_name: 'Pollack'})
	end

	it 'should accept custom headers' do
		file = "Seth,Pollack"
		importer = StockItemCSVImporter.new(file, {headers: [:first_name, :last_name]})
		expect(importer.import.first).to eq({first_name: 'Seth', last_name: 'Pollack'})
	end

	it 'should return array' do
		file = "first name,last name,skill_1_name,skill_1_rating\nSeth,Pollack,Ruby,5/5"
		importer = StockItemCSVImporter.new(file, {header_converters: [:symbol]})
		expect(importer.import.first).to eq({first_name: 'Seth', last_name: 'Pollack', skills:[{name: 'Ruby', rating:'5/5'}]})
	end

	it 'should return array using custom header converters' do
		file = "first name,last name,skill[1].name,skill[1].rating\nSeth,Pollack,Ruby,5/5"
		importer = StockItemCSVImporter.new(file, {header_converters: [lambda{|field| match = field.match(/(\w+)\[(\d+)\].(\w+)/); match ? "#{match[1]}_#{match[2]}_#{match[3]}" : field }, :symbol]})
		expect(importer.import.first).to eq({first_name: 'Seth', last_name: 'Pollack', skills:[{name: 'Ruby', rating:'5/5'}]})
	end

	it 'should return array with two elements' do
		file = "first name,last name,skill_1_name,skill_1_rating,skill_2_name,skill_2_rating\nSeth,Pollack,Ruby,5/5,Node,5/5"
		importer = StockItemCSVImporter.new(file, {header_converters: [:symbol]})
		expect(importer.import.first).to eq({first_name: 'Seth', last_name: 'Pollack', skills: [{name: 'Ruby', rating:'5/5'}, {name:'Node', rating:'5/5'}]})
	end

	it 'should return two arrays' do
		file = "first name,last name,skill_1_name,skill_1_rating,favorite_book_1_name,favorite_book_1_author\nSeth,Pollack,Ruby,5/5,Eloquent Ruby,Russ Olsen"
		importer = StockItemCSVImporter.new(file, {header_converters: [:symbol]})
		expect(importer.import.first).to eq({first_name: 'Seth', last_name: 'Pollack', skills:[{name: 'Ruby', rating:'5/5'}], :favorite_books => [{:name=>'Eloquent Ruby', :author=>'Russ Olsen'}]})
	end

	it 'should work with other delimiters' do
		file = "first name.last name\nSeth.Pollack"
		importer = StockItemCSVImporter.new(file, {col_sep: '.', header_converters: [:symbol]})
		expect(importer.import.first).to eq({first_name: 'Seth', last_name: 'Pollack'})

		file = "first name;last name\nSeth;Pollack"
		importer = StockItemCSVImporter.new(file, {col_sep: ';', header_converters: [:symbol]})
		expect(importer.import.first).to eq({first_name: 'Seth', last_name: 'Pollack'})

		file = "first name-last name\nSeth-Pollack"
		importer = StockItemCSVImporter.new(file, {col_sep: '-', header_converters: [:symbol]})
		expect(importer.import.first).to eq({first_name: 'Seth', last_name: 'Pollack'})
	end
	
end