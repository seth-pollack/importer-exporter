require 'json'

class JSONExporter
	def export(array)
		array.to_json
	end
end