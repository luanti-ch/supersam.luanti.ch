-- beerchat message
local function chat_msg(msg)
    beerchat.on_channel_message("main", "SYSTEM", msg)
end

super_sam.on_event("level_finished", function(player, highscore_name, score, rank)
    chat_msg("➢ Player '" .. player:get_player_name() ..
        "' finished level '" .. highscore_name ..
        "' with " .. score ..
        " points and rank " .. (rank and rank or "<none>")
    )
end)