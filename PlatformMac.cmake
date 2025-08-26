find_library(COREGRAPHICS_LIBRARY CoreGraphics)
find_library(FOUNDATION_LIBRARY Foundation)
find_library(IOKIT_LIBRARY IOKit)
find_library(IOSURFACE_LIBRARY IOSurface)
find_library(METAL_LIBRARY Metal)
find_library(QUARTZ_LIBRARY Quartz)
find_package(ZLIB REQUIRED)

list(APPEND ANGLE_SOURCES
    ${metal_backend_sources}

    ${angle_translator_lib_metal_sources}
    ${angle_translator_lib_msl_sources}
    ${angle_translator_glsl_apple_sources}

    ${libangle_gpu_info_util_sources}
    ${libangle_mac_sources}
)

if(IOS)
    list(APPEND ANGLE_SOURCES ${libangle_gpu_info_util_ios_sources})
else()
    list(APPEND ANGLE_SOURCES ${libangle_gpu_info_util_mac_sources})
endif()

list(APPEND ANGLE_DEFINITIONS
    ANGLE_ENABLE_METAL
)

list(APPEND ANGLEGLESv2_LIBRARIES
    ${COREGRAPHICS_LIBRARY}
    ${FOUNDATION_LIBRARY}
    ${IOKIT_LIBRARY}
    ${IOSURFACE_LIBRARY}
    ${METAL_LIBRARY}
)

if (NOT IOS)
    find_library(QUARTZ_LIBRARY Quartz)
    list(APPEND ANGLEGLESv2_LIBRARIES
        ${QUARTZ_LIBRARY}
    )
endif()