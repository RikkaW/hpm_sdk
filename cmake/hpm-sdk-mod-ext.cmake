macro(sdk_inc)
    target_include_directories(hpm_sdk_if INTERFACE ${ARGN})
endmacro()

macro(sdk_src)
    target_sources(hpm_sdk_if INTERFACE ${ARGN})
endmacro()

function(sdk_compile_definitions)
    foreach(def ${ARGN})
        target_compile_definitions(hpm_sdk_if INTERFACE ${def})
    endforeach()
endfunction()

macro(sdk_zcc_ld_options)
    # do nothing
endmacro()

macro(sdk_gcc_startup_src)
endmacro()

macro(sdk_ses_startup_src)
endmacro()

macro(sdk_iar_startup_src)
endmacro()

function(sdk_gcc_src)
    foreach(file ${ARGN})
        if(IS_DIRECTORY ${file})
            message(FATAL_ERROR "directory ${file} can't be added to sdk_lib_src")
        endif()
        if(IS_ABSOLUTE ${file})
            set(path ${file})
        else()
            set(path ${CMAKE_CURRENT_SOURCE_DIR}/${file})
        endif()
        target_sources(hpm_sdk_if PRIVATE ${path})
    endforeach()
endfunction()

macro(sdk_gcc_startup_src)
    sdk_gcc_src(${ARGN})
endmacro()

macro(sdk_ses_src)
endmacro()

macro(sdk_iar_src)
endmacro()

macro(get_toolchain_gcc_spec)
endmacro()

macro(sdk_nds_compile_options)
endmacro()

macro(sdk_zcc_compile_options)
endmacro()

macro(sdk_zcc_ld_options)
endmacro()

function(sdk_src_ifdef feature)
    if((${feature}) AND (NOT ${${feature}} EQUAL 0))
        sdk_src(${ARGN})
    endif()
endfunction()

function(add_subdirectory_ifdef feature)
    if((${feature}) AND (NOT ${${feature}} EQUAL 0))
        foreach(d ${ARGN})
            add_subdirectory(${d})
        endforeach()
    endif()
endfunction()

function(import_soc_modules soc_module_list)
    file(
            STRINGS
            ${soc_module_list}
            MODULE_LIST
            REGEX "^HPMSOC_"
            ENCODING "UTF-8"
    )

    foreach (m ${MODULE_LIST})
        string(REGEX MATCH "[^=]+" MODULE_NAME ${m})
        string(REGEX MATCH "=(.+$)" CONFIG_VALUE ${m})
        set(CONFIG_VALUE ${CMAKE_MATCH_1})

        if("${CONFIG_VALUE}" MATCHES "^\"(.*)\"$")
            set(CONFIG_VALUE ${CMAKE_MATCH_1})
        endif()

        set("${MODULE_NAME}" "${CONFIG_VALUE}" PARENT_SCOPE)
        if(("${CONFIG_VALUE}" STREQUAL "y") OR ("${CONFIG_VALUE}" STREQUAL "Y") OR ("${CONFIG_VALUE}" STREQUAL "1"))
            sdk_compile_definitions("-D${MODULE_NAME}=${CONFIG_VALUE}")
        endif()
    endforeach()
endfunction()
