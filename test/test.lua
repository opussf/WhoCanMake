#!/usr/bin/env lua

require "wowTest"
test.outFileName = "testOut.xml"
test.coberturaFileName = "../coverage.xml"
test.coverageReportPercent = true

ParseTOC( "../src/WhoCanMake.toc" )

-- addon setup
function test.before()
end
function test.after()
end

test.run()
