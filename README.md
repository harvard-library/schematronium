# Schematronium

Schematronium is a gem providing:

1. A single-object, single-function API for compiling a [schematron](http://www.schematron.com/) script, and running it over an XML file, returning a [Nokogiri](Nokogiri.org) [NodeSet](http://www.rubydoc.info/github/sparklemotion/nokogiri/Nokogiri/XML/NodeSet) of the resulting `failed-assert`s and `successful-report`s.
2. A script ([schematronium](bin/schematronium)) to run a schematron over one or many XML files and return aggregate date in a TBD format. Mostly meant as an example of something you could to with it.

The goals of Schematronium are very similar to [schematron-wrapper](https://github.com/Agilefreaks/schematron-wrapper).  The primary difference is that, where schematron-wrapper runs the saxon jar via backticks per file, Schematronium uses the jRuby-only [saxon-xslt](https://github.com/fidothe/saxon-xslt) library to compile and run the schematron.  This has the upshot of not incurring the penalty of JDK initialization per file, which tends to be a substantial cost savings over even a small number of files.

## Requirements

* jRuby - Schematron is tested with jRuby 9000, but may be suitable for use with earlier jRubies.
* JDK requirement is essentially whatever your chosen jRuby demands.
* [saxon-xslt](https://github.com/fidothe/saxon-xslt)
* [Nokogiri](Nokogiri.org)

## API

API docs are hosted [here](http://www.rubydoc.info/github/harvard-library/schematronium/master).

The API for Schematronium is very, very minimal.

```Ruby
checker = Schematronium.new("schematron_filename.sch")

failed_assert_nodeset = checker.check(filename_or_IO_object_supporting_read)
```

Processing the NodeSet into the report or output you desire is left as an exercise to the consumer.

## Known issues

### Redundant parsing

Right now, the Saxon::XML::Document object returned by saxon-xslt is pretty opaque.  In order to get a reasonable API on the returned results, Schematronium is just rendering the returned doc to a string, then re-parsing with Nokogiri and using its API to pull out the `failed-assert`s and `successful-report`s.

It's possible that someone who knew more about XDMDocument (and Java XML-handling in general) than your humble author might be able to dispense with the use of Nokogiri, and thus reduce dependencies and (probably) memory/execution time.
