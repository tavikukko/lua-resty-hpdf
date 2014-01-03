lua-resty-hpdf
==============
LuaJIT FFI-based libHaru (PDF) library for OpenResty.

usage
--------------

    local hpdf = require "hpdf"
    local left = 25;
    local top = 545;
    local right = 200;
    local bottom = top - 40;
    local text = "The quick brown fox jumps over the lazy dog. joo jee"
    
    local pdf = hpdf.new()
    pdf:use_utf_encodings()
	
	local fontname = pdf:load_ttfont_from_file("/usr/local/openresty/nginx/lua/DejaVuSans.ttf", 1)
    local font = pdf:get_font(fontname, "UTF-8")
    local page = pdf.pages:add()

    page:set_size(4, 0)
    page:text_leading(20)
    page:set_font_and_size(font, 8)
    page:begin_text()
    page:text_rect(left, top, right, bottom, text)
    page:end_text()
    
    pdf:save('document.pdf')
    pdf:free()
