lua-resty-hpdf
==============
LuaJIT FFI-based libHaru (PDF) library for OpenResty.

usage
--------------
local hpdf = require "hpdf"

local pdf = hpdf.new()

local page = pdf.pages:add() 

pdf:save('document.pdf')

pdf:free()
