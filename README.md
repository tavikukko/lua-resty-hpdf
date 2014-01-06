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
    local text = "The quick brown fox jumps over the lazy dog."
    
    local pdf = hpdf.new()
    pdf.encoder:use('utf')
    pdf.font:labels(0, "LOWER_ROMAN", 1, "")

	local fontname = pdf.font:load("/usr/local/openresty/nginx/lua/DejaVuSans.ttf", true)
	local font = pdf.font:get(fontname, "UTF-8")
    local page = pdf.pages:add()
    page:set_size("A5", "PORTRAIT")
	page:text_leading(20)

	-- LEFT
	page:rectangle(left, bottom, right - left, top - bottom)
	page:stroke()
	page:set_font_and_size(font, 8)
	page:begin_text()
	page:text_out(left, top + 3, "demo align LEFT")
	page:set_font_and_size(font, 10)
	page:text_rect(left, top, right, bottom, text, "LEFT", nil)
	page:end_text()

	-- RIGTH
	left = 220;
	right = 395;
	
	page:rectangle(left, bottom, right - left, top - bottom)
	page:stroke()
	page:set_font_and_size(font, 8)
	page:begin_text()
	page:text_out(left, top + 3, "demo align LEFT")
	page:set_font_and_size(font, 10)
	page:text_rect(left, top, right, bottom, text, "RIGHT", nil)
	page:end_text()

	-- CENTER 
	left = 25;
	top = 475;
	right = 200;
	bottom = top - 40;

	page:rectangle(left, bottom, right - left, top - bottom)
	page:stroke()
	page:set_font_and_size(font, 8)
	page:begin_text()
	page:text_out(left, top + 3, "demo align CENTER")
	page:set_font_and_size(font, 10)
	page:text_rect(left, top, right, bottom, text, "CENTER", nil)
	page:end_text()

	-- JUSTIFY
	left = 220
	right = 395

	page:rectangle(left, bottom, right - left, top - bottom)
	page:stroke()
	page:set_font_and_size(font, 8)
	page:begin_text()
	page:text_out(left, top + 3, "demo align JUSTIFY")
	page:set_font_and_size(font, 10)
	page:text_rect(left, top, right, bottom, text, "JUSTIFY", nil)
	page:end_text()

  	-- Skewed coordinate system
    local angle1 = 5
    local angle2 = 10
    local rad1 = angle1 / 180 * 3.141592
    local rad2 = angle2 / 180 * 3.141592

    left = 0
    top = 40
    right = 175
    bottom = 0

	page:gsave()
    page:concat(1, math.tan(rad1), math.tan(rad2), 1, 25, 350)
    page:rectangle(left, bottom, right - left, top - bottom)
	page:stroke()
	page:set_font_and_size(font, 8)
	page:begin_text()
	page:text_out(left, top + 3, "Skewed coordinate system")
	page:set_font_and_size(font, 10)
	page:text_rect(left, top, right, bottom, text, "LEFT", nil)
	page:end_text()
	page:grestore()


    -- Rotated coordinate system
    page:gsave()

    angle1 = 5
    rad1 = angle1 / 180 * 3.141592
    left = 0
    top = 40
    right = 175
    bottom = 0

    page:concat(math.cos(rad1), math.sin(rad1), -math.sin(rad1), math.cos(rad1), 220, 350)
    page:rectangle(left, bottom, right - left, top - bottom)
	page:stroke()
	page:set_font_and_size(font, 8)
	page:begin_text()
    page:text_out(left, top + 3, "Rotated coordinate system")
	page:set_font_and_size(font, 10)
	page:text_rect(left, top, right, bottom, text, "LEFT", nil)
	page:end_text()
	page:grestore()


    pdf:save('document.pdf')
    pdf:free()
