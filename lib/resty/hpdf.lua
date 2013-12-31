local ffi        = require "ffi"
local ffi_cdef   = ffi.cdef
local ffi_string = ffi.string
local libharu = ffi.load("/usr/local/openresty/nginx/lua/libhpdf.dylib")
-- print(libharu)
ffi_cdef[[
typedef void 			*HPDF_HANDLE;

typedef HPDF_HANDLE 	HPDF_Doc;
typedef HPDF_HANDLE 	HPDF_Page;
typedef HPDF_HANDLE 	HPDF_Pages;
typedef HPDF_HANDLE 	HPDF_Stream;
typedef HPDF_HANDLE 	HPDF_Image;
typedef HPDF_HANDLE 	HPDF_Font;
typedef HPDF_HANDLE 	HPDF_Outline;
typedef HPDF_HANDLE 	HPDF_Encoder;
typedef HPDF_HANDLE 	HPDF_3DMeasure;
typedef HPDF_HANDLE 	HPDF_ExData;
typedef HPDF_HANDLE 	HPDF_Destination;
typedef HPDF_HANDLE 	HPDF_XObject;
typedef HPDF_HANDLE 	HPDF_Annotation;
typedef HPDF_HANDLE 	HPDF_ExtGState;
typedef HPDF_HANDLE 	HPDF_FontDef;
typedef HPDF_HANDLE 	HPDF_U3D;
typedef HPDF_HANDLE 	HPDF_JavaScript;
typedef HPDF_HANDLE 	HPDF_Error;
typedef HPDF_HANDLE 	HPDF_MMgr;
typedef HPDF_HANDLE 	HPDF_Dict;
typedef HPDF_HANDLE 	HPDF_EmbeddedFile;
typedef HPDF_HANDLE 	HPDF_OutputIntent;
typedef HPDF_HANDLE 	HPDF_Xref;
typedef unsigned int 	HPDF_UINT;
 
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

typedef signed int 	HPDF_BOOL;
typedef float 		HPDF_REAL;

const char * 	HPDF_GetVersion();
typedef void 	(*HPDF_Error_Handler) (unsigned long error_no, 
					unsigned long detail_no, void  *user_data);
void * 			HPDF_New(HPDF_Error_Handler user_error_fn, void *user_data);
void * 			HPDF_AddPage(HPDF_Doc pdf);
float 			HPDF_Page_GetHeight(HPDF_Page page);
float 			HPDF_Page_GetWidth(HPDF_Page page);
void * 			HPDF_GetFont(HPDF_Doc pdf, const char *font_name, const char *encoding_name);
void * 			HPDF_Page_SetFontAndSize(HPDF_Page page,HPDF_Font font, HPDF_REAL size);
void * 			HPDF_Page_BeginText(HPDF_Page page);
void * 			HPDF_Page_TextOut(HPDF_Page page, HPDF_REAL xpos, 
					HPDF_REAL ypos, const char *text);
void * 			HPDF_Page_EndText(HPDF_Page page);
void * 			HPDF_Free(HPDF_Doc pdf);
void * 			HPDF_SetCurrentEncoder(HPDF_Doc pdf, const char *encoding_name);
void * 			HPDF_UseUTFEncodings(HPDF_Doc pdf);
void * 			HPDF_SetCurrentEncoder(HPDF_Doc pdf, const char *encoding_name);
char * 			HPDF_LoadTTFontFromFile(HPDF_Doc pdf, const char *file_name, 
					HPDF_BOOL embedding);
void * 			HPDF_Page_TextRect(HPDF_Page page, HPDF_REAL left, HPDF_REAL top, HPDF_REAL right, 
					HPDF_REAL bottom, const char *text, HPDF_TextAlignment align, HPDF_UINT *len);
void * 			HPDF_Page_SetSize(HPDF_Page page, HPDF_PageSizes size, HPDF_PageDirection direction);
void * 			HPDF_Page_SetTextLeading(HPDF_Page page, HPDF_REAL value);
void * 			HPDF_Page_Rectangle(HPDF_Page page, HPDF_REAL x, HPDF_REAL y, HPDF_REAL width, 
					HPDF_REAL height);
void * 			HPDF_Page_Stroke(HPDF_Page page);
void * 			HPDF_Page_GSave(HPDF_Page page);
void * 			HPDF_SaveToFile(HPDF_Doc pdf, const char *file_name);
]]

-- consts
local left = 25;
local top = 545;
local right = 200;
local bottom = top - 40;
local SAMP_TXT = "The quick brown fox jumps over the lazy dog.."

-- create pdf
local pdf = libharu.HPDF_New(nil, nil)
libharu.HPDF_UseUTFEncodings(pdf)
libharu.HPDF_SetCurrentEncoder(pdf, "UTF-8")

-- create page
local page = libharu.HPDF_AddPage(pdf)
local fontname = libharu.HPDF_LoadTTFontFromFile(pdf, 
						"/usr/local/openresty/nginx/lua/DejaVuSans.ttf", 1); 
local font = libharu.HPDF_GetFont(pdf, fontname, "UTF-8")
libharu.HPDF_Page_SetSize(page, 4, 0)

-- create content
libharu.HPDF_Page_SetTextLeading(page, 20)

-- HPDF_TALIGN_LEFT
libharu.HPDF_Page_Rectangle(page, left, bottom, right - left, top - bottom)
libharu.HPDF_Page_Stroke(page)
libharu.HPDF_Page_SetFontAndSize(page, font, 8)
libharu.HPDF_Page_BeginText(page)
libharu.HPDF_Page_TextOut(page, left, top + 3, "HPDF_TALIGN_LEFT")
libharu.HPDF_Page_SetFontAndSize(page, font, 10)
libharu.HPDF_Page_TextRect(page, left, top, right, bottom, SAMP_TXT, 0, nil)
libharu.HPDF_Page_EndText(page)

-- HPDF_TALIGN_RIGTH
left = 220;
right = 395;

libharu.HPDF_Page_Rectangle (page, left, bottom, right - left, top - bottom)
libharu.HPDF_Page_Stroke(page)
libharu.HPDF_Page_BeginText(page)
libharu.HPDF_Page_SetFontAndSize(page, font, 8);
libharu.HPDF_Page_TextOut(page, left, top + 3, "HPDF_TALIGN_RIGTH")
libharu.HPDF_Page_SetFontAndSize(page, font, 10);
libharu.HPDF_Page_TextRect (page, left, top, right, bottom, SAMP_TXT, 1, nil);
libharu.HPDF_Page_EndText (page);

-- HPDF_TALIGN_CENTER 
left = 25;
top = 475;
right = 200;
bottom = top - 40;

libharu.HPDF_Page_Rectangle(page, left, bottom, right - left, top - bottom)
libharu.HPDF_Page_Stroke(page)
libharu.HPDF_Page_BeginText(page)
libharu.HPDF_Page_SetFontAndSize(page, font, 8)
libharu.HPDF_Page_TextOut(page, left, top + 3, "HPDF_TALIGN_CENTER")
libharu.HPDF_Page_SetFontAndSize(page, font, 10)
libharu.HPDF_Page_TextRect(page, left, top, right, bottom, SAMP_TXT, 2, nil)
libharu.HPDF_Page_EndText(page)

--HPDF_TALIGN_JUSTIFY
left = 220
right = 395

libharu.HPDF_Page_Rectangle(page, left, bottom, right - left, top - bottom)
libharu.HPDF_Page_Stroke(page)
libharu.HPDF_Page_BeginText(page)
libharu.HPDF_Page_SetFontAndSize(page, font, 8)
libharu.HPDF_Page_TextOut(page, left, top + 3, "HPDF_TALIGN_JUSTIFY")
libharu.HPDF_Page_SetFontAndSize(page, font, 10)
libharu.HPDF_Page_TextRect(page, left, top, right, bottom, SAMP_TXT, 3, nil)
libharu.HPDF_Page_EndText(page)

-- save and close
libharu.HPDF_SaveToFile(pdf, "testi.pdf")
libharu.HPDF_Free(pdf)

