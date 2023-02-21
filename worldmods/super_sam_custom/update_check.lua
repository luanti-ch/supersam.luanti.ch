
local function get_version()
    local f = assert(io.open(minetest.get_worldpath() .. "/git_info/refs/heads/main", "r"))
    local version = f:read("*all")
    f:close()
    return version
end

-- generic chat message
local function chat_msg(msg)
    minetest.chat_send_all(msg)
end

-- beerchat message
if minetest.get_modpath("beerchat") then
    chat_msg = function(msg)
        beerchat.on_channel_message("main", "SYSTEM", msg)
    end
end

local start_version = get_version()
local updated_since

local function check()
    local current_version = get_version()
    if not updated_since and current_version ~= start_version then
        -- mark update pending
        updated_since = os.time()
        chat_msg("Update from '" .. start_version .. "' to '" .. current_version .. "' scheduled")
    end

    if updated_since and (os.time() - updated_since) > 30 and #minetest.get_connected_players() == 0 then
        -- version changed a while ago and no players online, restart
        chat_msg("Restarting to apply updates")
        minetest.request_shutdown("map update", true)
    end

    minetest.after(10, check)
end
check()