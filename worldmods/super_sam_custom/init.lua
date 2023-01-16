-- restart if last player leaves
-- TODO: account for "inbound"/pre-auth players
minetest.register_on_leaveplayer(function()
    if #minetest.get_connected_players() == 1 then
        minetest.request_shutdown("map reset", true)
    end
end)

-- emerge spawn area
minetest.register_on_mods_loaded(function()
    minetest.after(0, function()
        -- first level
        minetest.emerge_area({
            x = -50,
            y = -50,
            z = -50
        },{
            x = 50,
            y = 50,
            z = 50
        })

        -- lounge
        minetest.emerge_area({
            x = 2050,
            y = 0,
            z = 0
        },{
            x = 1950,
            y = 0,
            z = 0
        })
    end)
end)

-- periodically set a fixed time of day
local function set_time()
    minetest.set_timeofday(0.5)
    minetest.after(2, set_time)
end

minetest.after(0, set_time)