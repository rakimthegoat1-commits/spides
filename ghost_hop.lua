-- Spider-Man Ghost Hop Script
-- Double Jump -> Symbiote Animation Cancel -> Swing -> Cluster Cancel
-- Gains height while maintaining momentum

settings = {
    { key = "jump_hold_ms", label = "Jump Hold MS", default = 10, min = 1, max = 50 },
    { key = "symbiote_delay_ms", label = "Symbiote Delay MS", default = 50, min = 10, max = 150 },
    { key = "symbiote_hold_ms", label = "Symbiote Hold MS", default = 25, min = 5, max = 100 },
    { key = "swing_delay_ms", label = "Swing Delay MS", default = 20, min = 5, max = 100 },
    { key = "swing_hold_ms", label = "Swing Hold MS", default = 40, min = 10, max = 150 },
    { key = "cluster_delay_ms", label = "Cluster Cancel Delay MS", default = 80, min = 20, max = 200 },
    { key = "cluster_hold_ms", label = "Cluster Hold MS", default = 1, min = 1, max = 50 },
    { key = "second_jump_delay_ms", label = "2nd Jump Delay MS", default = 100, min = 50, max = 300 },
}

local JUMP = Enum.Key.Space
local SYMBIOTE = Enum.Key.C
local SWING = Enum.Key.LeftShift
local CLUSTER = Enum.AbilityType.SecondaryAttack

local function cfg(key, default_value)
    if script ~= nil and script.get_setting ~= nil then
        local value = script.get_setting(key)
        if type(value) == "number" then
            return math.floor(value)
        end
    end
    return default_value
end

local function send_key(key, hold_ms)
    input.press_key(key)
    if hold_ms and hold_ms > 0 then
        wait(hold_ms)
    end
    input.release_key(key)
end

function on_activate_combo(ctx)
    local p = ctx.player
    if not p or not p:is_valid() or p.is_dead then
        return false
    end

    -- 1) FIRST JUMP
    send_key(JUMP, cfg("jump_hold_ms", 10))
    wait(cfg("second_jump_delay_ms", 100))

    -- 2) SECOND JUMP (Double Jump)
    send_key(JUMP, cfg("jump_hold_ms", 10))
    wait(cfg("symbiote_delay_ms", 50))

    -- 3) SYMBIOTE (Animation Cancel)
    send_key(SYMBIOTE, cfg("symbiote_hold_ms", 25))
    wait(cfg("swing_delay_ms", 20))

    -- 4) SWING (Momentum carrier)
    send_key(SWING, cfg("swing_hold_ms", 40))
    wait(cfg("cluster_delay_ms", 80))

    -- 5) CLUSTER (Animation Cancel the swing)
    ability_manager:activate_ability(CLUSTER)
    
    return true
end
