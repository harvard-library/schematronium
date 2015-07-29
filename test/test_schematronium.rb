require 'schematronium'
require 'minitest'
require 'minitest/pride'
require 'minitest/autorun'

class SchematroniumTest < MiniTest::Test
  def td(*path_segments)
    File.join(File.expand_path(File.dirname(__FILE__)), 'test_data', *path_segments)
  end

  def setup
    @stron = Schematronium.new(td('schematron', 'as_schematron.sch'))
  end

  def test_check_with_file
    @stron.check(File.open(td('xml', 'div01000.xml')))
  end

end
