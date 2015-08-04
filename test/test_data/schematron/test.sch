<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <pattern>
    <rule context="*:test">
      <report >
      <assert test="*:testable">One or more 'testables' must exist in any 'test' element.</assert>
    </rule>
    <rule context="*:test/*:testable">
      <assert test="@test-attr">Testables must have have the 'test-attr' attribute.</assert>
    </rule>
  </pattern>
</schema>
