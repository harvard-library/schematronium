<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <phase id="testphase">
    <active pattern="b" />
  </phase>
<pattern id="a">
    <rule context="*:test">
      <report test="*:testable">
        There should be 'testable' elements within 'test's.
      </report>
    </rule>
    <rule context="*:test/*:testable">
      <assert test="@test-attr">Testables must have have the 'test-attr' attribute.</assert>
    </rule>
</pattern>
<pattern id="b">
    <rule context="*:test[1]">
      <assert test="@test-attr">Testables must have have the 'test-attr' attribute.</assert>
    </rule>
</pattern>
</schema>
