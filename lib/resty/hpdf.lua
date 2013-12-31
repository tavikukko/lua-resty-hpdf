local ffi        = require "ffi"
local ffi_cdef   = ffi.cdef
local ffi_string = ffi.string
local libharu = ffi.load("/usr/local/openresty/nginx/lua/libhpdf.dylib")
-- print(libharu)
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

typedef  unsigned int HPDF_UINT;

typedef enum _HPDF_TextAlignment {
    HPDF_TALIGN_LEFT = 0,
    HPDF_TALIGN_RIGHT,
    HPDF_TALIGN_CENTER,
    HPDF_TALIGN_JUSTIFY
} HPDF_TextAlignment;

typedef signed int HPDF_BOOL;

typedef float HPDF_REAL;

const char * HPDF_GetVersion();

typedef void (*HPDF_Error_Handler) (unsigned long error_no, unsigned long detail_no, void  *user_data);

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

void * HPDF_Page_TextRect(HPDF_Page page, HPDF_REAL left, HPDF_REAL top, HPDF_REAL right, HPDF_REAL bottom, const char *text, HPDF_TextAlignment align, HPDF_UINT *len);

void * HPDF_SaveToFile(HPDF_Doc pdf, const char *file_name);

]]

local pdf = libharu.HPDF_New(nil, nil)

libharu.HPDF_UseUTFEncodings(pdf)

libharu.HPDF_SetCurrentEncoder(pdf, "UTF-8")

local page = libharu.HPDF_AddPage(pdf)

local height = libharu.HPDF_Page_GetHeight(page)

local width = libharu.HPDF_Page_GetWidth(page)

local fontname = libharu.HPDF_LoadTTFontFromFile(pdf, "/usr/local/openresty/nginx/lua/DejaVuSans.ttf", 1); 

local font = libharu.HPDF_GetFont(pdf, fontname, "UTF-8")

libharu.HPDF_Page_SetFontAndSize(page, font, 18)

libharu.HPDF_Page_BeginText(page)

libharu.HPDF_Page_TextRect(page,10.0,460.0,530,430, "And also here, with special characters äöå!", 0, nil)

libharu.HPDF_Page_TextOut(page, 60, height - 60, "Writing text here, with special characters äöå!")

libharu.HPDF_Page_EndText(page)

libharu.HPDF_SaveToFile(pdf, "testi.pdf")

libharu.HPDF_Free(pdf)

