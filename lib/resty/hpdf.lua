local ffi = require "ffi"
local ffi_cdef = ffi.cdef
local libharu = ffi.load("/usr/local/openresty/nginx/lua/libhpdf.dylib")
-- path to libHaru 2.3.0RC2

ffi_cdef[[
typedef void *HPDF_HANDLE;
typedef HPDF_HANDLE HPDF_Doc;
typedef HPDF_HANDLE HPDF_Page;
typedef HPDF_HANDLE HPDF_Pages;
typedef HPDF_HANDLE HPDF_Stream;
typedef HPDF_HANDLE HPDF_Image;
typedef HPDF_HANDLE HPDF_Font;
typedef HPDF_HANDLE HPDF_Outline;
typedef HPDF_HANDLE HPDF_Encoder;
typedef HPDF_HANDLE HPDF_3DMeasure;
typedef HPDF_HANDLE HPDF_ExData;
typedef HPDF_HANDLE HPDF_Destination;
typedef HPDF_HANDLE HPDF_XObject;
typedef HPDF_HANDLE HPDF_Annotation;
typedef HPDF_HANDLE HPDF_ExtGState;
typedef HPDF_HANDLE HPDF_FontDef;
typedef HPDF_HANDLE HPDF_U3D;
typedef HPDF_HANDLE HPDF_JavaScript;
typedef HPDF_HANDLE HPDF_Error;
typedef HPDF_HANDLE HPDF_MMgr;
typedef HPDF_HANDLE HPDF_Dict;
typedef HPDF_HANDLE HPDF_EmbeddedFile;
typedef HPDF_HANDLE HPDF_OutputIntent;
typedef HPDF_HANDLE HPDF_Xref;
typedef unsigned int HPDF_UINT;

typedef enum _HPDF_TextAlignment {
	HPDF_TALIGN_LEFT = 0,
	HPDF_TALIGN_RIGHT,
	HPDF_TALIGN_CENTER,
	HPDF_TALIGN_JUSTIFY} HPDF_TextAlignment;

typedef enum _HPDF_PageSizes {
	HPDF_PAGE_SIZE_LETTER = 0,
	HPDF_PAGE_SIZE_LEGAL,
	HPDF_PAGE_SIZE_A3,
	HPDF_PAGE_SIZE_A4,
	HPDF_PAGE_SIZE_A5,
	HPDF_PAGE_SIZE_B4,
	HPDF_PAGE_SIZE_B5,
	HPDF_PAGE_SIZE_EXECUTIVE,
	HPDF_PAGE_SIZE_US4x6,
	HPDF_PAGE_SIZE_US4x8,
	HPDF_PAGE_SIZE_US5x7,
	HPDF_PAGE_SIZE_COMM10,
	HPDF_PAGE_SIZE_EOF} HPDF_PageSizes;

typedef enum _HPDF_PageDirection {
	HPDF_PAGE_PORTRAIT = 0,
	HPDF_PAGE_LANDSCAPE} HPDF_PageDirection;

typedef enum _HPDF_PageNumStyle {
    HPDF_PAGE_NUM_STYLE_DECIMAL = 0,
    HPDF_PAGE_NUM_STYLE_UPPER_ROMAN,
    HPDF_PAGE_NUM_STYLE_LOWER_ROMAN,
    HPDF_PAGE_NUM_STYLE_UPPER_LETTERS,
    HPDF_PAGE_NUM_STYLE_LOWER_LETTERS,
    HPDF_PAGE_NUM_STYLE_EOF} HPDF_PageNumStyle;

typedef signed int HPDF_BOOL;
typedef float HPDF_REAL;

const char * HPDF_GetVersion();
typedef void (*HPDF_Error_Handler) (unsigned long error_no, unsigned long detail_no, 
			void  *user_data);
void * HPDF_New(HPDF_Error_Handler user_error_fn, void *user_data);
void * HPDF_AddPage(HPDF_Doc pdf);
float HPDF_Page_GetHeight(HPDF_Page page);
float HPDF_Page_GetWidth(HPDF_Page page);
void * HPDF_GetFont(HPDF_Doc pdf, const char *font_name, const char *encoding_name);
void * HPDF_Page_SetFontAndSize(HPDF_Page page,HPDF_Font font, HPDF_REAL size);
void * HPDF_Page_BeginText(HPDF_Page page);
void * HPDF_Page_TextOut(HPDF_Page page, HPDF_REAL xpos, HPDF_REAL ypos, const char *text);
void * HPDF_Page_EndText(HPDF_Page page);
void * HPDF_Free(HPDF_Doc pdf);
void * HPDF_SetCurrentEncoder(HPDF_Doc pdf, const char *encoding_name);
void * HPDF_UseUTFEncodings(HPDF_Doc pdf);
void * HPDF_UseJPEncodings(HPDF_Doc pdf);
void * HPDF_UseKREncodings(HPDF_Doc pdf);
void * HPDF_UseCNSEncodings(HPDF_Doc pdf);
void * HPDF_UseCNTEncodings(HPDF_Doc pdf);
void * HPDF_GetEncoder(HPDF_Doc pdf, const char *encoding_name);
void * HPDF_SetCurrentEncoder(HPDF_Doc pdf, const char *encoding_name);
void * HPDF_GetCurrentEncoder(HPDF_Doc pdf);
const char* HPDF_LoadTTFontFromFile(HPDF_Doc pdf, const char *file_name, HPDF_BOOL embedding);
const char* HPDF_LoadType1FontFromFile(HPDF_Doc pdf, const char *afm_file_name, const char *data_file_name);
const char* HPDF_LoadTTFontFromFile2(HPDF_Doc pdf, const char *file_name, HPDF_UINT index, HPDF_BOOL embedding);
void * HPDF_Page_TextRect(HPDF_Page page, HPDF_REAL left, HPDF_REAL top, HPDF_REAL right, 
			HPDF_REAL bottom, const char *text, HPDF_TextAlignment align, HPDF_UINT *len);
void * HPDF_Page_SetSize(HPDF_Page page, HPDF_PageSizes size, HPDF_PageDirection direction);
void * HPDF_Page_SetTextLeading(HPDF_Page page, HPDF_REAL value);
void * HPDF_Page_Rectangle(HPDF_Page page, HPDF_REAL x, HPDF_REAL y, HPDF_REAL width, HPDF_REAL height);
void * HPDF_Page_Stroke(HPDF_Page page);
void * HPDF_Page_GSave(HPDF_Page page);
void * HPDF_Page_GRestore(HPDF_Page page);
void * HPDF_Page_SetGrayStroke(HPDF_Page page, HPDF_REAL gray);
void * HPDF_Page_Circle(HPDF_Page page, HPDF_REAL x, HPDF_REAL y, HPDF_REAL ray);
void * HPDF_Page_Concat(HPDF_Page page,HPDF_REAL a, HPDF_REAL b, HPDF_REAL c, HPDF_REAL d, 
				HPDF_REAL x, HPDF_REAL y);
void * HPDF_Page_ShowText(HPDF_Page page,const char *text);
void * HPDF_Page_SetTextMatrix(HPDF_Page page, HPDF_REAL a, HPDF_REAL b, HPDF_REAL c, HPDF_REAL d, HPDF_REAL x, HPDF_REAL y);
void * HPDF_AddPageLabel(HPDF_Doc pdf, HPDF_UINT page_num, HPDF_PageNumStyle style, HPDF_UINT first_page, 
			const char *prefix);
void * HPDF_SaveToFile(HPDF_Doc pdf, const char *file_name);
]]

local doc = { pages = {}, encoder = {}, font = {} }
doc.__index = doc
doc.pages.__index = doc.pages
doc.encoder.__index = doc.encoder
doc.font.__index = doc.font

local page = {}
page.__index = page

-- doc --
function doc.new(opts)
    opts = opts or {}
    local self = setmetatable({ pages = {}, encoder = {}, font = {} }, doc)
    setmetatable(self.pages, doc.pages)
    setmetatable(self.encoder, doc.encoder)
	setmetatable(self.font, doc.font)

    self.___ = libharu.HPDF_New(nil, nil)

    self.pages.doc = self
    self.encoder.doc = self
	self.font.doc = self
    return self
end

function doc:save(filename) 
	return libharu.HPDF_SaveToFile(self.___, filename)
end

function doc:free()
	return libharu.HPDF_Free(self.___)
end

-- doc.encoder --
function doc.encoder:set(encoder)
	return libharu.HPDF_SetCurrentEncoder(self.doc.___, encoder)
end

function doc.encoder:get(...)
	local arg={...}
	if #arg == 1 then
		local name = select(1, ...)
		return libharu.HPDF_GetEncoder(self.doc.___, name)
	elseif #arg == 0 then
		return libharu.HPDF_GetCurrentEncoder(self.doc.___)
	end
	return nil
end

function doc.encoder:use(name)
	if not name then return nil end
	name = name:lower()
	if name == 'utf' then return libharu.HPDF_UseUTFEncodings(self.doc.___)
	elseif name == 'jp' then return libharu.HPDF_UseJPEncodings(self.doc.___)
	elseif name == 'kr' then return libharu.HPDF_UseKREncodings(self.doc.___)
	elseif name == 'cns' then return libharu.HPDF_UseCNSEncodings(self.doc.___)
	elseif name == 'cnt' then return libharu.HPDF_UseCNTEncodings(self.doc.___)
	end
	return nil
end

-- doc.font --
function doc.font:load(...)
	local arg={...}
	if #arg > 0 then
		local path = select(1, ...)
		if string.ends(path:lower(),'.ttf') then
			local embed = select(2, ...) or true
			return libharu.HPDF_LoadTTFontFromFile(self.doc.___, path, embed)
		elseif string.ends(path:lower(),'.afm') then
			local pfmfilename = select(2, ...)
			return libharu.HPDF_LoadType1FontFromFile(self.doc.___, path, pfmfilename)
		elseif string.ends(path:lower(),'.ttc') then
			local index = select(2, ...) or 1
			local embed = select(3, ...) or true
			return libharu.HPDF_LoadTTFontFromFile2(self.doc.___, path, index, embed)
		end
	end	
	return nil
end

function doc.font:get(name, encoding)
	return libharu.HPDF_GetFont(self.doc.___, name, encoding)
end

function doc.font:labels(num, style, first, prefix)
	return libharu.HPDF_AddPageLabel(self.doc.___, 
			num, "HPDF_PAGE_NUM_STYLE_" .. style:upper(), 
			first, prefix)
end

-- doc.pages 
function doc.pages:add()
    return page.new(self.doc, libharu.HPDF_AddPage(self.doc.___))
end

-- page
function page.new(doc, ___)
    local self = setmetatable({}, page)
    self.___ = ___

    self.doc = doc
    return self
end

function page:set_size(size, direction)
	return libharu.HPDF_Page_SetSize(self.___, "HPDF_PAGE_SIZE_" .. size:upper(), 
					"HPDF_PAGE_" .. direction:upper())
end

function page:text_leading(leading)
	return libharu.HPDF_Page_SetTextLeading(self.___, leading)
end

function page:rectangle(x, y, width, height)
	return libharu.HPDF_Page_Rectangle(self.___, x, y, width, height)
end

function page:stroke()
	return libharu.HPDF_Page_Stroke(self.___)
end

function page:set_font_and_size(font, size)
	return libharu.HPDF_Page_SetFontAndSize(self.___, font, size)
end

function page:begin_text()
	return libharu.HPDF_Page_BeginText(self.___)
end

function page:text_out(x, y, text)
	return libharu.HPDF_Page_TextOut(self.___, x, y, text)
end

function page:text_rect(left, top, right, bottom, text, align, len)
	return libharu.HPDF_Page_TextRect(self.___, left, top, right, 
				bottom, text, "HPDF_TALIGN_" .. align:upper(), len)
end

function page:end_text()
	return libharu.HPDF_Page_EndText(self.___)
end

function page:gsave()
	return libharu.HPDF_Page_GSave(self.___)
end

function page:grestore()
	return libharu.HPDF_Page_GRestore(self.___)
end

function page:concat(a, b, c, d, x, y)
	return libharu.HPDF_Page_Concat(self.___, a, b, c, d, x, y)
end

function page:gray_stroke(gray)
	return libharu.HPDF_Page_SetGrayStroke(self.___, gray)
end

function page:circle(x, y, ray)
	return libharu.HPDF_Page_Circle(self.___, x, y, ray)
end

function page:text_matrix(a,  b,  c,  d,  x,  y)
	return libharu.HPDF_Page_SetTextMatrix(self.___, a,  b,  c,  d,  x,  y)
end

function page:text_show(text)
	return libharu.HPDF_Page_ShowText(self.___, text)
end

-- helpers
function string.ends(String,End)
   return End=='' or string.sub(String,-string.len(End))==End
end

return doc
