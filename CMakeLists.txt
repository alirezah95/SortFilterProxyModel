cmake_minimum_required(VERSION 3.14)
project(qqmlsortfilterproxymodel)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

find_package(QT NAMES Qt6 Qt5)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS
    Core
    Qml
    )

set(CMAKE_AUTOMOC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON) # This is to find generated *.moc and *.h files in build dir

add_library(SortFilterProxyModel OBJECT
    qqmlsortfilterproxymodel.cpp
    qvariantlessthan.cpp
    filters/filter.cpp
    filters/filtercontainer.cpp
    filters/rolefilter.cpp
    filters/valuefilter.cpp
    filters/indexfilter.cpp
    filters/regexpfilter.cpp
    filters/rangefilter.cpp
    filters/expressionfilter.cpp
    filters/filtercontainerfilter.cpp
    filters/anyoffilter.cpp
    filters/alloffilter.cpp
    filters/filtersqmltypes.cpp
    sorters/sorter.cpp
    sorters/sortercontainer.cpp
    sorters/rolesorter.cpp
    sorters/stringsorter.cpp
    sorters/expressionsorter.cpp
    sorters/sortersqmltypes.cpp
    proxyroles/proxyrole.cpp
    proxyroles/proxyrolecontainer.cpp
    proxyroles/joinrole.cpp
    proxyroles/switchrole.cpp
    proxyroles/expressionrole.cpp
    proxyroles/proxyrolesqmltypes.cpp   
    proxyroles/singlerole.cpp   
    proxyroles/regexprole.cpp
    sorters/filtersorter.cpp
    proxyroles/filterrole.cpp
    )

if (MSVC AND QT_VERSION_MAJOR GREATER_EQUAL 6)
    target_compile_options(SortFilterProxyModel PRIVATE
        "/Zc:__cplusplus"
        "/permissive-"
    )
endif()

target_include_directories(SortFilterProxyModel PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}
    $<TARGET_PROPERTY:Qt${QT_VERSION_MAJOR}::Core,INTERFACE_INCLUDE_DIRECTORIES>
    $<TARGET_PROPERTY:Qt${QT_VERSION_MAJOR}::Qml,INTERFACE_INCLUDE_DIRECTORIES>
    )
