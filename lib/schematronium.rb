require 'saxon-xslt'
require 'nokogiri' # Used for output parsing - there doesn't seem to be a clean way to manipulate Saxon::XML documents

class Schematronium
  def iso_file(fname)
    File.open(File.join(File.dirname(File.expand_path(__FILE__)), 'iso-schematron-xslt2', fname))
  end

  def initialize(schematron)

    dsdl = Saxon.XSLT(iso_file('iso_dsdl_include.xsl'))
    abstract = Saxon.XSLT(iso_file('iso_abstract_expand.xsl'))
    sc_compile = Saxon.XSLT(iso_file('iso_svrl_for_xslt2.xsl'))

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




    @sch_script = Saxon.XSLT(sc_compile.transform(abstract.transform(dsdl.transform(schematron))).to_s)
  end

  def check(xml)
    xml = Nokogiri::XML(@sch_script.transform( Saxon.XML(xml)).to_s)
    xml.remove_namespaces!
    xml.xpath("//failed-assert")
  end
end
