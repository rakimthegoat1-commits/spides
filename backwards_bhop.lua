-- Spider-Man Backwards Bhop Script
-- Walk backwards -> Double Jump -> Swing Cluster Cancel -> Uppercut
-- The backflip is crucial for maintaining backwards momentum

settings = {
    { key = "first_jump_hold_ms", label = "First Jump Hold MS", default = 5, min = 1, max = 20 },
    { key = "swing_delay_ms", label = "Swing Delay MS", default = 15, min = 5, max = 50 },
    { key = "swing_hold_ms", label = "Swing Hold MS", default = 25, min = 10, max = 80 },
    { key = "cluster_delay_ms", label = "Cluster Cancel Delay MS", default = 30, min = 10, max = 100 },
    { key = "cluster_hold_ms", label = "Cluster Hold MS", default = 1, min = 1, max = 20 },
    { key = "second_jump_delay_ms", label = "2nd Jump Delay MS", default = 40, min = 20, max = 120 },
    { key = "second_jump_hold_ms", label = "2nd Jump Hold MS", default = 5, min = 1, max = 20 },
    { key = "uppercut_delay_ms", label = "Uppercut Delay MS", default = 50, min = 20, max = 150 },
}

local JUMP = Enum.Key.Space
local SWING = Enum.Key.V
local CLUSTER = Enum.AbilityType.SecondaryAttack
local UPPERCUT = Enum.AbilityType.Ability3

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
    send_key(JUMP, cfg("first_jump_hold_ms", 5))
    wait(cfg("swing_delay_ms", 15))

    -- 2) SWING (Simple swing for backflip momentum - CRITICAL)
    send_key(SWING, cfg("swing_hold_ms", 25))
    wait(cfg("cluster_delay_ms", 30))

    -- 3) CLUSTER CANCEL (Animation cancel the swing to maintain momentum)
    ability_manager:activate_ability(CLUSTER)
    wait(cfg("second_jump_delay_ms", 40))

    -- 4) DOUBLE JUMP (Second jump while backflip is active)
    send_key(JUMP, cfg("second_jump_hold_ms", 5))
    wait(cfg("uppercut_delay_ms", 50))

    -- 5) UPPERCUT (Extended height and distance)
    ability_manager:activate_ability(UPPERCUT)
    
    return true
end
