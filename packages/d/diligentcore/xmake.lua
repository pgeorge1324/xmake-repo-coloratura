package("diligentcore")
    set_homepage("https://github.com/DiligentGraphics/DiligentCore")
    set_description("A modern cross-platform low-level graphics API")

    set_urls("https://github.com/DiligentGraphics/DiligentCore/releases/download/$(version)/DiligentCore_$(version).zip")

    add_versions("v2.5.4", "c27638b2c0582fa44b26e36c2212b7ac5fb4bcac93a94b91e9e68ad23c5df04e")

    add_deps("cmake")
    add_deps("python")

    on_load("windows", function(package)
        package:add("defines", "PLATFORM_WIN32=1")
    end)

    on_install(function (package)
        local configs = {}
        table.insert(configs, "-DDILIGENT_NO_FORMAT_VALIDATION=ON")
        table.insert(configs, "-DCMAKE_BUILD_TYPE=" .. (package:debug() and "Debug" or "Release"))

        import("package.tools.cmake").install(package, configs)

        package:add("linkdirs", package:installdir(path.join("lib")))
--         package:add("links", "DiligentCore")
        os.cp(package:installdir(path.join("lib", package:debug() and "Debug" or "Release", "*.lib")), package:installdir("lib"))
    end)
package_end()
