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
void * HPDF_SetCurrentEncoder(HPDF_Doc pdf, const char *encoding_name);
const char* HPDF_LoadTTFontFromFile(HPDF_Doc pdf, const char *file_name, HPDF_BOOL embedding);
void * HPDF_Page_TextRect(HPDF_Page page, HPDF_REAL left, HPDF_REAL top, HPDF_REAL right, 
			HPDF_REAL bottom, const char *text, HPDF_TextAlignment align, HPDF_UINT *len);
void * HPDF_Page_SetSize(HPDF_Page page, HPDF_PageSizes size, HPDF_PageDirection direction);
void * HPDF_Page_SetTextLeading(HPDF_Page page, HPDF_REAL value);
void * HPDF_Page_Rectangle(HPDF_Page page, HPDF_REAL x, HPDF_REAL y, HPDF_REAL width, HPDF_REAL height);
void * HPDF_Page_Stroke(HPDF_Page page);
void * HPDF_Page_GSave(HPDF_Page page);
void * HPDF_SaveToFile(HPDF_Doc pdf, const char *file_name);
]]

local doc = { pages = {} }
doc.__index = doc
doc.pages.__index = doc.pages

local page = {}
page.__index = page

-- doc methods
function doc.new(opts)
    opts = opts or {}
    local self = setmetatable({ pages = {} }, doc)
    setmetatable(self.pages, doc.pages)
    self.___ = libharu.HPDF_New(nil, nil)

    self.pages.doc = self
    return self
end

function doc:use_utf_encodings()
	return libharu.HPDF_UseUTFEncodings(self.___)
end

function doc:set_current_encoder(encoder)
	return libharu.HPDF_SetCurrentEncoder(self.___, encoder)
end

function doc:load_ttfont_from_file(path, embed)
	return libharu.HPDF_LoadTTFontFromFile(self.___, path, embed)
end

function doc:get_font(name, encoding)
	return libharu.HPDF_GetFont(self.___, name, encoding)
end

function doc:save(filename) 
	return libharu.HPDF_SaveToFile(self.___, filename)
end

function doc:free()
	return libharu.HPDF_Free(self.___)
end

--doc pages methods
function doc.pages:add()
    return page.new(self.doc, libharu.HPDF_AddPage(self.doc.___))
end

--page methods
function page.new(doc, ___)
    local self = setmetatable({}, page)
    self.___ = ___

    self.doc = doc
    return self
end

function page:set_size(size, direction)
	return libharu.HPDF_Page_SetSize(self.___, size, direction)
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
	return libharu.HPDF_Page_TextRect(self.___, left, top, right, bottom, text, align, len)
end

function page:end_text()
	return libharu.HPDF_Page_EndText(self.___)
end

return doc
