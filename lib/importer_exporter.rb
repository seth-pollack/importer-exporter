class ImporterExporter
	def initialize(importer, exporter)
		@importer = importer
		@exporter = exporter
	end
	def export
		@exporter.export @importer.import
	end
end