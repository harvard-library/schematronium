require 'schematronium'
require 'minitest'
require 'minitest/pride'
require 'minitest/autorun'

class SchematroniumTest < MiniTest::Test
  def td(*path_segments)
    File.join(File.expand_path(File.dirname(__FILE__)), 'test_data', *path_segments)
  end

  def test_check_with_file
    stron = Schematronium.new(td('schematron', 'test.sch'))
    results = stron.check(File.open(td('xml', 'test.xml')))
    results.remove_namespaces!
    assert_equal 2, results.xpath("//failed-assert").count, "Expects two failures"
    assert_equal 2, results.xpath("//successful-report").count, "Expects two reports"
  end

  def test_check_with_phase
    stron = Schematronium.new(td('schematron', 'test.sch'), "'testphase'")
    results = stron.check(File.open(td('xml', 'test.xml')))
    results.remove_namespaces!
    assert_equal 1, results.xpath("//failed-assert").count, "Expects one failure"
  end
end
