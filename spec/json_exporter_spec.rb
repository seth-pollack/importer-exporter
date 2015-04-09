require 'spec_helper'

describe JSONExporter do
	it 'should convert hash to json' do
		exporter = JSONExporter.new
		expect(exporter.export({first_name: 'Seth', last_name: 'Pollack'})).to eq({first_name: 'Seth', last_name: 'Pollack'}.to_json)
	end
end