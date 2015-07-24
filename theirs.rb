raise "You can only use #{__FILE__} with JRuby." unless RUBY_PLATFORM == "java"
require "java"
require "uri"

module XSLT
  TRANSFORMER_FACTORY = "javax.xml.transform.TransformerFactory"

  import "javax.xml.transform.TransformerFactory"
  import "javax.xml.transform.Transformer"
  import "javax.xml.transform.stream.StreamSource"
  import "javax.xml.transform.stream.StreamResult"
  import "java.lang.System"

  class Saxon
    TRANSFORMER_FACTORY_IMPL = "net.sf.saxon.TransformerFactoryImpl"
    FEATURE_URI = URI::HTTP.build(:host => "saxon.sf.net", :path => "/feature/")

    attr_accessor :xslt
    attr_accessor :input
    attr_accessor :output
    attr_accessor :factory

    def initialize(xslt, input, output)
      System.setProperty(TRANSFORMER_FACTORY, TRANSFORMER_FACTORY_IMPL)
      @factory = TransformerFactory.newInstance
      @xslt    = xslt
      @input   = input
      @output  = output
    end

    def set_attribute(attribute, value)
      FEATURE_URI.path << attribute.to_s
      @factory.setAttribute(FEATURE_URI.to_s, value)
      self
    end

    def transformer
      @transformer ||= @factory.newTransformer(StreamSource.new(@xslt))
    end

    def transform
      transformer.transform(StreamSource.new(@input), StreamResult.new(@output))
    end
  end
end

saxon = XSLT::Saxon.new(*ARGV)
saxon.set_attribute(:linenumbering, true)
saxon.transform
