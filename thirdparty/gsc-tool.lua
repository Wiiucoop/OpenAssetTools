gsctool = {}

function gsctool:include(includes)
	if includes:handle(self:name()) then
		includedirs {
			path.join(ThirdPartyFolder(), "gsc-tool/include")
		}
	end
end

function gsctool:link(links)
	links:add("xsk-utils")
	links:add("xsk-arc")
	links:add("xsk-gsc")
end

function gsctool:use()

end

function gsctool:name()
	return "gsc-tool"
end

function gsctool:project()
	local folder = ThirdPartyFolder()

	project "xsk-utils"
		targetdir(TargetDirectoryLib)
		location "%{wks.location}/thirdparty/gsc-tool/xsk-utils"
		kind "StaticLib"
		language "C++"

		files {
			path.join(folder, "gsc-tool/src/utils/**.h"),
			path.join(folder, "gsc-tool/src/utils/**.hpp"),
			path.join(folder, "gsc-tool/src/utils/**.cpp")
		}

		includedirs {
			path.join(folder, "gsc-tool/include")
		}

		defines { "ZLIB_CONST" }
		includedirs {
			path.join(ThirdPartyFolder(), "zlib")
		}

		filter { "toolset:msc*" }
			buildoptions { "/bigobj", "/Zc:__cplusplus", "/std:c++20" }
		filter {}

		warnings "off"

	project "xsk-arc"
		targetdir(TargetDirectoryLib)
		location "%{wks.location}/thirdparty/gsc-tool/xsk-arc"
		kind "StaticLib"
		language "C++"

		files {
			path.join(folder, "gsc-tool/src/arc/**.h"),
			path.join(folder, "gsc-tool/src/arc/**.hpp"),
			path.join(folder, "gsc-tool/src/arc/**.cpp")
		}

		includedirs {
			path.join(folder, "gsc-tool/include")
		}

		filter { "toolset:msc*" }
			buildoptions { "/bigobj", "/Zc:__cplusplus", "/std:c++20" }
		filter {}

		warnings "off"

	project "xsk-gsc"
		targetdir(TargetDirectoryLib)
		location "%{wks.location}/thirdparty/gsc-tool/xsk-gsc"
		kind "StaticLib"
		language "C++"

		files {
			path.join(folder, "gsc-tool/src/gsc/**.h"),
			path.join(folder, "gsc-tool/src/gsc/**.hpp"),
			path.join(folder, "gsc-tool/src/gsc/**.cpp")
		}

		includedirs {
			path.join(folder, "gsc-tool/include")
		}

		filter { "toolset:msc*" }
			buildoptions { "/bigobj", "/Zc:__cplusplus", "/std:c++20" }
		filter {}

		warnings "off"
end
