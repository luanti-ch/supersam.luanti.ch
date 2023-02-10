
local function get_version()
    local f = assert(io.open(minetest.get_worldpath() .. "/git_info/refs/heads/main", "r"))
    local version = f:read("*all")
    f:close()
    return version
end

local start_version = get_version()

local function check()
    local current_version = get_version()
    if current_version ~= start_version and #minetest.get_connected_players() == 0 then
        -- version changed and no players online, restart
        print("Version changed from " .. start_version .. " to " .. current_version .. " restarting server")
        minetest.request_shutdown("map update", true)
    end

    minetest.after(10, check)
end
check()