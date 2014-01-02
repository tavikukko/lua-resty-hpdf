lua-resty-hpdf
==============
LuaJIT FFI-based libHaru (PDF) library for OpenResty.

usage
--------------
    local hpdf = require "hpdf"
    local pdf = hpdf()
    pdf:save()
