require 'saxon-xslt'
require 'nokogiri' # Used for output parsing - there doesn't seem to be a clean way to manipulate Saxon::XML documents

class Schematronium
  # Helper method returning stages of iso_schematron XSLT transform
  def iso_file(fname)
    Saxon.XSLT(File.open(File.join(File.dirname(File.expand_path(__FILE__)), 'iso-schematron-xslt2', fname)))
  end

  def initialize(schematron)
    stages = %w|iso_dsdl_include.xsl
                iso_abstract_expand.xsl
                iso_svrl_for_xslt2.xsl|.map{|s| iso_file s}

    schematron = case schematron
                 when IO
                   Saxon.XML(schematron.read)
                 when String
                   if File.file? schematron
                     Saxon.XML(File.open(schematron))
                   else
                     Saxon.XML(schematron)
                   end
                 end

    # Run schematron through each stage of the iso_schematron pipeline
    #    then stringify the final result because Saxon.XSLT can't take
    #    an XML doc as input
    @sch_script = Saxon.XSLT(
      stages.reduce(schematron) do |result, stage|
        stage.transform(result)
      end.to_s
    )
  end

  # Run schematron over xml document, returning the resulting XML
  def check(xml)
    xml = Nokogiri::XML(@sch_script.transform( Saxon.XML(xml)).to_s)
  end
end
