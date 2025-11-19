include(cmake/hpm-sdk-mod-ext.cmake)

add_library(hpm_sdk_if INTERFACE)

set(HPM_SDK_BASE $ENV{HPM_SDK_BASE})

set(HPM_BOARD_DIR ${HPM_SDK_BASE}/boards/${HPM_BOARD})
import_soc_modules(soc/${HPM_SOC_SERIES}/${HPM_SOC}/soc_modules.list)

add_subdirectory(arch)
#add_subdirectory(boards)
add_subdirectory(soc)
add_subdirectory(drivers)
add_subdirectory(utils)
add_subdirectory(components)
add_subdirectory(middleware)
