-- hero routes
 -- End stops the scan.
local END_KEY = 35

-- Shared, global camera aim helper. Real Lua globals (no "local") are
-- visible from every module's env via its _G fallback, so any hero module
-- can call these directly instead of keeping its own private copy.
--
-- camera.look_at(target) followed by re-applying the resulting rotation
-- with pitch negated. This order matters: negating BEFORE look_at has no
-- reliable relationship to the actual target direction.


local HERO_BRUCE_BANNER = 1011
local HERO_DOCTOR_STRANGE = 1018
local HERO_MANTIS = 1020
local HERO_CAPTAIN_AMERICA = 1022
local HERO_CLOAK_DAGGER = 1025
local HERO_BLACK_PANTHER = 1026
local HERO_GROOT = 1027
local HERO_LUNA = 1031
local HERO_SPIDERMAN = 1036
local HERO_MAGNETO = 1037
local HERO_SCARLET_WITCH = 1038
local HERO_THOR = 1039
local HERO_IRON_FIST = 1052
local HERO_BUCKY = 1041
local HERO_PENI = 1042
local HERO_ADAM = 1046
local HERO_JEFF = 1047
local HERO_PSYLOCKE = 1048
local HERO_EMMA = 1053
local HERO_DAREDEVIL = 1055
local HERO_ANGELA = 1056
local HERO_INVISIBLE_WOMAN = 1050
local HERO_DEADPOOL = 1057
local HERO_DEADPOOL_DMG = 10572
local HERO_DEADPOOL_STRAT = 10573
local HERO_WHITEFOX = 1060
local HERO_BLACK_CAT = 1061
local HERO_DEVIL_DINO = 1062
local HERO_CYCLOPS = 1063
local HERO_ROGUE = 1065

settings = {
	{ key = "trigger_key", label = "Trigger Key", default_key = 0x05, default_mode = "hold" },
    { key = "scan_poll_ms", label = "Scan Poll MS", default = 50, min = 25, max = 1000 },
    { key = "route_adam_enabled", label = "Adam Route", default = true },
    { key = "adam_quick_fire_enabled", label = "Adam Quick Fire", default = true },
    { key = "adam_auto_heal_enabled", label = "Adam Auto Heal", default = true },
    { key = "adam_require_two_energy", label = "Adam Require 2 Energy", default = true },
	{ key = "route_black_cat_enabled", label = "Black Cat Route", default = true },
    { key = "black_cat_fov", label = "Black Cat Fov", default = 60, min = 0, max = 360 },
    { key = "black_cat_use_shift", label = "Black Cat Use Shift?", default = true },
    { key = "black_cat_use_aim", label = "Black Cat Use Aim?", default = true },
    { key = "black_cat_flickbot", label = "Black Cat Flickbot?", default = false },
    { key = "black_cat_save_me_enabled", label = "Black Cat Save me?!", default = true },
    { key = "black_cat_save_me_fov", label = "Black Cat Save me Fov", default = 360, min = 0, max = 360 },
    { key = "black_cat_execute_them_enabled", label = "Execute Them!!", default = true },
    { key = "black_cat_execute_them_fov", label = "Execute Them Fov", default = 360, min = 0, max = 360 },
    { key = "black_cat_whip_threshold", label = "Whip Threshhold", default = 150, min = 0, max = 360 },
    { key = "route_bp_enabled", label = "Black Panther Route", default = true },
    { key = "bp_range", label = "Black Panther Range", default = 15, min = 0, max = 30 },
    { key = "bp_low_hp_toggle", label = "BP Low HP Toggle", default = true},
    { key = "bp_low_hp_key", label = "Require Key for Low Hp", default = false },
    { key = "bp_mark_key", label = "Require Key for Marked", default = false },
    { key = "bp_new_ability_enabled", label = "BP New Ability (C) On/Off", default = true },
    { key = "bp_new_aim_method", label = "BP New Aim Method", default = false },
    { key = "Blackpanther_aim_fov", label = "Blackpanther Aim FOV", default = 360, min = 1, max = 360 },
    { key = "Blackpanther_multi_mark_enabled", label = "Blackpanther Multi Mark Sequence", default = true },
    { key = "leftmousebutton_key_addition", label = "LeftMouseButton Key Addition", default = true },
    { key = "route_bucky_enabled", label = "Bucky Route", default = true },
    { key = "route_peni_enabled", label = "Peni Route", default = true },
    { key = "route_cap_enabled", label = "Captain America Route", default = true },
    { key = "route_ultimate_cancels_enabled", label = "Ultimate Cancels Route", default = true },
    { key = "ultimate_cancels_test_enabled", label = "Ultimate Cancels Test", default = false },
    { key = "route_auto_shield_cc_enabled", label = "Auto Shield CC Route", default = true },
    { key = "cap_block_fov", label = "Ultimate Cancel FOV", default = 360, min = 1, max = 360 },
    { key = "cap_combo_aim", label = "Captain America Combo Aim", default = true },
    { key = "cap_combo_fov", label = "Captain America Combo FOV", default = 30, min = 0, max = 180 },
    { key = "cap_humanized_aim", label = "Captain America Humanized Aim", default = true },
    { key = "route_cnd_enabled", label = "Cloak And Dagger Route", default = true },
    { key = "cnd_ignore_shield", label = "Cloak And Dagger Ignore Shield", default = false },
    { key = "route_deadpool_enabled", label = "Deadpool Route", default = true },
    { key = "deadpool_combo_range", label = "Deadpool Combo Range", default = 11, min = 1, max = 60 },
    { key = "deadpool_aim_fov", label = "Deadpool Aim FOV", default = 30, min = 1, max = 360 },
    { key = "deadpool_close_range", label = "Deadpool Jump Range", default = 3, min = 1, max = 20 },
    { key = "deadpool_ignore_shield", label = "Deadpool Ignore Shield", default = false },
    { key = "deadpool_prefer_ability_manager", label = "Deadpool Prefer Ability Manager", default = true },
    { key = "route_dino_enabled", label = "Devil Dino Route", default = true },
    { key = "route_strange_enabled", label = "Doctor Strange Route", default = true },
    { key = "route_angela_enabled", label = "Angela Route", default = true },
    { key = "route_invisible_woman_enabled", label = "Invisible Woman Route", default = true },
    { key = "route_hulk_enabled", label = "Hulk Route", default = true },
    { key = "route_psylocke_enabled", label = "Psylocke Route", default = true },
    { key = "psylocke_low_hp_enabled", label = "Psylocke Low HP", default = true },
    { key = "psylocke_include_shield", label = "Psylocke Include Shield", default = true },
    { key = "psylocke_fov", label = "Psylocke FOV", default = 360, min = 1, max = 360 },
    { key = "psylocke_range", label = "Psylocke Range", default = 10, min = 1, max = 30 },
    { key = "route_iron_fist_enabled", label = "Iron Fist Route", default = true },
    { key = "iron_fist_low_hp_enabled", label = "Iron Fist Low HP", default = true },
    { key = "iron_fist_include_shield", label = "Iron Fist Include Shield", default = true },
    { key = "iron_fist_fov", label = "Iron Fist FOV", default = 360, min = 1, max = 360 },
    { key = "route_jeff_enabled", label = "Jeff Route", default = true },
    { key = "jeff_ignore_shield", label = "Jeff Ignore Shield", default = false },
    { key = "route_luna_enabled", label = "Luna Route", default = true },
    { key = "route_scarlet_enabled", label = "Scarlet Witch Route", default = true },
    { key = "route_magneto_enabled", label = "Magneto Route", default = true },
    { key = "magneto_bubble_allies", label = "Magneto Bubble Allies", default = true },
    { key = "magneto_ally_range", label = "Magneto Ally Range", default = 25, min = 1, max = 60 },
    { key = "magneto_flick_ally", label = "Magneto Flick Ally", default = true },
    { key = "magneto_auto_ult_eat", label = "Magneto Auto Ult Eat", default = true },
    { key = "magneto_ult_eat_range", label = "Magneto Ult Eat Range", default = 35, min = 5, max = 60 },
    { key = "magneto_eat_angela_ult", label = "Magneto Eat Angela Ult", default = true },
    { key = "magneto_eat_groot_ult", label = "Magneto Eat Groot Ult", default = true },
    { key = "magneto_shield_cyclops_ult", label = "Magneto Shield Cyclops Ult", default = true },
    { key = "magneto_shield_strange_ult", label = "Magneto Shield Strange Ult", default = true },
    { key = "magneto_strange_range", label = "Magneto Strange Range", default = 15, min = 5, max = 40 },
    { key = "magneto_shield_wolverine_ult", label = "Magneto Shield Wolverine Ult", default = true },
    { key = "magneto_wolverine_range", label = "Magneto Wolverine Range", default = 15, min = 5, max = 40 },
    { key = "magneto_shield_wolverine_leap", label = "Magneto Shield Wolverine Leap", default = true },
    { key = "magneto_wolverine_leap_range", label = "Magneto Wolverine Leap Range", default = 4, min = 1, max = 30 },
    { key = "magneto_bubble_wolverine_leap_ally", label = "Magneto Bubble Wolverine Leap Ally", default = true },
    { key = "magneto_wolverine_leap_ally_range", label = "Magneto Wolverine Leap Ally Range", default = 25, min = 5, max = 60 },
    { key = "magneto_bubble_ally_ults", label = "Magneto Bubble Ally Ults", default = true },
    { key = "route_mantis_enabled", label = "Mantis Route", default = true },
    { key = "mantis_heal_buff_enabled", label = "Mantis Heal Buff", default = true },
    { key = "mantis_aim_enabled", label = "Mantis Aim", default = true },
    { key = "mantis_reverse_aim_control", label = "Reverse Aim Control", default = true },
    { key = "mantis_gate_fov", label = "Mantis Gate FOV", default = 60, min = 1, max = 360 },
    { key = "mantis_flick_enabled", label = "Mantis Flick", default = false },
    { key = "mantis_flickbot_fov", label = "Mantis Flickbot FOV", default = 90, min = 1, max = 360 },
    { key = "mantis_aim_fov", label = "Mantis Aim FOV", default = 360, min = 1, max = 360 },
    { key = "mantis_team_range", label = "Mantis Team Range", default = 25, min = 1, max = 60 },
    { key = "mantis_include_shield", label = "Mantis Include Shield", default = true },
    { key = "route_spiderman_enabled", label = "Spiderman Route", default = true },
    { key = "spiderman_hydro_low_hp", label = "Spiderman Hydro Low HP", default = false },
    { key = "route_thor_enabled", label = "Thor Route", default = true },
    { key = "thor_fov", label = "Thor FOV", default = 60, min = 1, max = 360 },
    { key = "thor_rmb_fov", label = "Thor RMB FOV", default = 10, min = 1, max = 360 },
    { key = "thor_use_rmb", label = "Thor Use RMB", default = true },
    { key = "thor_use_f", label = "Thor Use F", default = true },
    { key = "route_whitefox_enabled", label = "White Fox Route", default = true },
    { key = "route_cyclops_enabled", label = "Cyclops Route", default = true },
}

local MODULE_DEFS = {}
MODULE_DEFS[#MODULE_DEFS + 1] = {
    name = "AdamAutoHeal KindaSilent",
    kind = "scanner",
    source = [[
local ADAM_HERO_ID = 1046
local ABILITY1 = Enum.AbilityType.Ability1

local ALLY_HP_THRESHOLD = 0.65
local ALLY_RANGE_M = 20
local LOOK_SETTLE_MS = 25
local CAST_SETTLE_MS = 25
local SCAN_MS = script.get_setting("scan_poll_ms") or 100
local END_KEY = 35

local scanner_id = nil
local scan_active = false
local scan_busy = false

settings = {
    {
        key = "require_two_energy",
        label = "Require 2 Ability1 Energy",
        default = true,
    },
}

local function valid_player(player)
    return player and player:is_valid() and not player.is_dead
end

local function is_adam(player)
    return valid_player(player) and player.hero_id == ADAM_HERO_ID
end

local function valid_ally(player, ally)
    return ally
        and ally ~= player
        and ally:is_valid()
        and not ally.is_dead
        and not ally:is_enemy()
        and ally.location
end

local function health_percent(unit)
    if type(unit.health) ~= "number" then return 1 end
    if type(unit.max_health) ~= "number" or unit.max_health <= 0 then return 1 end
    return unit.health / unit.max_health
end

local function find_lowest_ally(player)
    local allies = object_manager.get_players(false)
    if type(allies) ~= "table" then return nil end

    local best = nil
    local best_hp = math.huge

    for _, ally in ipairs(allies) do
        if valid_ally(player, ally) then
            local dist = player.location:get_distance_to(ally.location) * 0.01
            local hp = health_percent(ally)
            if dist <= ALLY_RANGE_M and hp < ALLY_HP_THRESHOLD and hp < best_hp then
                best = ally
                best_hp = hp
            end
        end
    end

    return best
end

local function required_energy()
    if script.get_setting("require_two_energy") == false then
        return 1
    end

    return 2
end

local function ability1_ready(player)
    local ability = player:get_ability(ABILITY1)
    if not ability or not ability:is_valid() then return false end
    if ability.on_cooldown then return false end
    if ability.is_activated then return false end
    if ability.cooldown_remaining and ability.cooldown_remaining > 0 then return false end
    if type(ability.energy_value) ~= "number" then return false end
    if ability.energy_value < required_energy() then return false end

    return ability_manager:can_activate_ability(ABILITY1) == true
end

local function look_at_with_fix(ally)
    local aimed = pcall(function()
        camera.look_at(ally.location)
    end)

    if not aimed then
        return false
    end

    -- Invert pitch AFTER look_at
    local new_rotation = camera.get_rotation()
    if new_rotation and new_rotation.pitch and new_rotation.yaw then
        pcall(function()
            camera.set_rotation(-new_rotation.pitch, new_rotation.yaw)
        end)
    end

    return true
end

local function camera_heal(ally)
    local saved_rotation = camera.get_rotation()
    if not saved_rotation then return false end

    local saved_pitch = saved_rotation.pitch
    local saved_yaw = saved_rotation.yaw

    local aimed = pcall(function()
        camera.look_at(ally.location)
    end)

    if not aimed then
        return false
    end

    -- Invert pitch AFTER look_at
    local new_rotation = camera.get_rotation()
    if new_rotation and new_rotation.pitch and new_rotation.yaw then
        pcall(function()
            camera.set_rotation(-new_rotation.pitch, new_rotation.yaw)
        end)
    end

    wait(LOOK_SETTLE_MS)
    ability_manager:activate_ability(ABILITY1)
    wait(CAST_SETTLE_MS)

    -- Restore original rotation
    camera.set_rotation(saved_pitch, saved_yaw)

    return true
end

local function scan_once()
    if scan_busy then return false end
    scan_busy = true

    local player = object_manager.get_local_player()
    if not is_adam(player) or not ability1_ready(player) then
        scan_busy = false
        return false
    end

    local ally = find_lowest_ally(player)
    if not ally then
        scan_busy = false
        return false
    end

    camera_heal(ally)
    scan_busy = false
    return true
end

local function stop_scanner()
    scan_active = false
    scan_busy = false

    if scanner_id then
        timer.clear(scanner_id)
        scanner_id = nil
    end
end

local function start_scanner()
    if scanner_id then
        scan_active = true
        return true
    end

    scan_active = true
    scanner_id = timer.set_interval(function()
        if input.is_key_down(END_KEY) then
            stop_scanner()
            return
        end

        if scan_active then
            scan_once()
        end
    end, SCAN_MS)

    return true
end

function on_activate_combo(ctx)
    return start_scanner()
end

function on_deactivate_combo(ctx)
    -- Releasing Combo does not stop the scanner. End stops it.
end

]],
}

MODULE_DEFS[#MODULE_DEFS + 1] = {
    name = "Adamquickfire",
    kind = "combo",
    source = [[
-- Combo stop guard
local __route_end_stop_signal = "__route_end_stop_signal"
local __route_raw_wait = wait

local function __route_end_pressed()
    if not script or not script.is_keybind_active then return false end
    return not script.is_keybind_active("trigger_key")
end

local function __route_release_combo_inputs()
    if not input or not input.release_key then return end
    pcall(function() input.release_key(Enum.MouseButton.Left) end)
    pcall(function() input.release_key(Enum.MouseButton.Right) end)
end

local function wait(ms)
    if __route_end_pressed() then
        __route_release_combo_inputs()
        error(__route_end_stop_signal, 0)
    end
    __route_raw_wait(ms)
    if __route_end_pressed() then
        __route_release_combo_inputs()
        error(__route_end_stop_signal, 0)
    end
end

-- Constants
local ADAM_HERO_ID = 1046
local PRIMARY = Enum.AbilityType.PrimaryAttack
local RELOAD = Enum.AbilityType.WeaponReload
local LEFT_MOUSE = Enum.MouseButton.Left
local RIGHT_MOUSE = Enum.MouseButton.Right
local RIGHT_TAP_MS = 1
local RIGHT_INTERVAL_MS = 150

-- Helper functions
local function valid_player(player)
    return player and player:is_valid() and not player.is_dead
end

local function is_adam(player)
    return valid_player(player) and player.hero_id == ADAM_HERO_ID
end

local function is_reloading(player)
    if not valid_player(player) then return false end
    local ability = player:get_ability(RELOAD)
    return ability ~= nil and ability.is_activated == true
end

local function primary_energy(player)
    if not valid_player(player) then return 0 end
    local ability = player:get_ability(PRIMARY)
    if not ability or type(ability.energy_value) ~= "number" then return 0 end
    return ability.energy_value
end

-- Main combo logic
local function __route_original_on_activate_combo(ctx)
    local player = ctx and ctx.player or object_manager.get_local_player()
    if not player then return false end
    if not is_adam(player) or is_reloading(player) then return false end
    if not input or not input.press_key or not input.release_key or not input.send_key then return false end

    -- Outer loop: continue while combo key is held
    while is_adam(player) and not __route_end_pressed() do
        -- Press left mouse down and hold it
        pcall(function() input.press_key(LEFT_MOUSE) end)

        -- Loop: tap right mouse every 150ms until energy depletes or reload starts
        while is_adam(player) and not is_reloading(player) and not __route_end_pressed() do
            pcall(function() input.send_key(RIGHT_MOUSE, RIGHT_TAP_MS) end)
            wait(RIGHT_INTERVAL_MS)
            player = ctx and ctx.player or object_manager.get_local_player()

            -- Check if energy is 0, then break to reload
            if primary_energy(player) <= 0 then
                break
            end
        end

        -- Release left mouse
        pcall(function() input.release_key(LEFT_MOUSE) end)

        -- Wait for reload to complete
        while is_adam(player) and is_reloading(player) and not __route_end_pressed() do
            wait(25)
            player = ctx and ctx.player or object_manager.get_local_player()
        end

        player = ctx and ctx.player or object_manager.get_local_player()
    end

    return true
end

local __route_wrapped_on_activate_combo = __route_original_on_activate_combo
function on_activate_combo(ctx)
    if __route_end_pressed() then
        __route_release_combo_inputs()
        return false
    end

    local ok, result = pcall(__route_wrapped_on_activate_combo, ctx)
    if not ok then
        if result == __route_end_stop_signal or tostring(result) == __route_end_stop_signal then
            __route_release_combo_inputs()
            return false
        end
        error(result)
    end

    return result
end

]],
}

MODULE_DEFS[#MODULE_DEFS + 1] = {
    name = "BlackPanther",
    kind = "scanner",
    source = [[
-- Built from Black_Panther_Autodash.lua, wrapped as a self-driving scanner.
-- on_activate_combo/on_deactivate_combo below are only called ONCE each, by
-- the outer framework, when it enables/disables this scanner for the
-- current hero (ensure_scanners_for_hero / disable_modules_not_for_hero in
-- the Sticky lifecycle). That outer logic already gates this on "hero id
-- currently == Black Panther", so once enabled, start_scanner()'s own timer
-- just keeps calling run_bp_tick() every SCAN_MS on its own.
--
-- Nothing about Black_Panther_Autodash.lua's own timing changed: the aim
-- smoothing loop (SMOOTH_STEPS / SMOOTH_WAIT_MS), the wait(100) dash lock,
-- and the 40-step / wait(8) post-dash re-level are byte-for-byte the same
-- as that file. Only two things were added around them: a `busy` lock so
-- two scanner ticks can never overlap and step on each other's camera/input
-- state, and `scan_active` re-checks right after each wait() so a tick that
-- was already mid-flight when the module gets disabled (hero swap, End
-- key) doesn't keep acting once it resumes.

local BLACK_PANTHER_DEFAULT_ID = 1026
local HERO_ID = BLACK_PANTHER_DEFAULT_ID
local END_KEY = 35
local SCAN_MS = 1

target_preset = {
    aim_fov = 360.0,
    dynamic_fov = true,
    ignore_invisible = true,
    ignore_shield = false,
    ignore_team = true,
    ignore_enemy = false,
    max_distance = 14.9
}

settings = {
    { key = "fov", label = "FOV", default = 360, min = 1, max = 360 },
    { key = "range_m", label = "Range (m)", default = 14.9, min = 1, max = 30 },
    { key = "low_hp_dash_enabled", label = "Low HP Dash", default = true },
    { key = "new_ability_enabled", label = "New Ability (C) On/Off", default = true },
}

local SHIFT_ABILITY_TYPE = Enum.AbilityType.Ability2
local NEW_ABILITY_ID = 102697
local NEW_ABILITY_ID_2 = 102698
local NEW_ABILITY_KEY = Enum.Key and Enum.Key.C or "C"
local NEW_ABILITY_HOLD_MS = 10
local MARK_RANGE_M = 6.0

local CAMERA_HEIGHT = 58
local TARGET_HEIGHT = -65

local PREDICT_SECS = 0.15
local SMOOTH_STEPS = 15
local SMOOTH_FACTOR = 0.6
local SMOOTH_WAIT_MS = 6

local Z_SMOOTH_ALPHA = 0.5
local smoothed_target_z = nil

local scan_active = false
local scanner_id = nil
local busy = false

local function get_hero_id(player)
    if not player then return nil end

    if player.get_hero_id then
        local ok, id = pcall(function()
            return player:get_hero_id()
        end)
        if ok and id then return id end
    end

    return player.hero_id
end

local function is_black_panther(player)
    return player and player:is_valid() and not player.is_dead and get_hero_id(player) == HERO_ID
end

local function fire(key, hold)
    ability_manager:activate_ability(key, hold or 0)
end

local function range_limit()
    return script.get_setting("range_m") or 14.9
end

local function enemy_in_fov(enemy)
    local limit = script.get_setting("fov") or 360
    if limit >= 360 then return true end
    if not enemy or not enemy.get_fov_to_target then return true end

    local ok, fov = pcall(function()
        return enemy:get_fov_to_target()
    end)

    if not ok or fov == nil then return true end
    return math.abs(fov) <= limit
end

local function required_key_is_down(require_setting)
    if script.get_setting(require_setting) ~= true then return true end
    if not script or not script.is_keybind_active then return false end
    return script.is_keybind_active("trigger_key")
end

local function ability2_ready(player)
    local ability = player and player.get_ability and player:get_ability(SHIFT_ABILITY_TYPE)
    if not ability then return false end
    if ability.is_valid and not ability:is_valid() then return false end
    -- on_cooldown may be a field (bool) or a method depending on SDK version
    if type(ability.on_cooldown) == "function" then
        local ok, cd = pcall(function() return ability:on_cooldown() end)
        if ok and cd then return false end
    elseif ability.on_cooldown == true then
        return false
    end
    if ability.cooldown_remaining and ability.cooldown_remaining > 0 then return false end
    if ability_manager and ability_manager.can_activate_ability then
        local ok, ready = pcall(function()
            return ability_manager:can_activate_ability(SHIFT_ABILITY_TYPE)
        end)
        if ok and ready == false then return false end
    elseif ability.can_activate then
        local ok, ready = pcall(function()
            return ability:can_activate()
        end)
        if ok and ready == false then return false end
    end
    return true
end

local function get_ability_by_id(player, id)
    if not player or not player.get_abilities then return nil end

    local ok, list = pcall(function() return player:get_abilities() end)
    if not ok or type(list) ~= "table" then return nil end

    for i = 1, #list do
        local ability = list[i]
        local ok_id, ab_id = pcall(function() return ability:get_id() end)
        if ok_id and ab_id == id then
            return ability
        end
    end

    return nil
end

local function ability_flag(ability, key)
    local value = ability[key]
    if type(value) == "function" then
        local ok, result = pcall(function()
            return value(ability)
        end)

        return ok and result == true
    end

    return value == true
end

local function new_ability_ready(player)
    local ability = get_ability_by_id(player, NEW_ABILITY_ID)
    if not ability then
        ability = get_ability_by_id(player, NEW_ABILITY_ID_2)
    end
    if not ability then return false end
    if ability.is_valid and not ability:is_valid() then return false end
    if ability_flag(ability, "cooldown") then return false end
    if ability.cooldown_remaining and ability.cooldown_remaining > 0 then return false end
    if ability.can_activate ~= nil and not ability_flag(ability, "can_activate") then return false end

    return true
end

local function has_any_marked_enemy()
    local enemies = object_manager.get_players(true)
    if type(enemies) ~= "table" then return false end

    for i = 1, #enemies do
        local enemy = enemies[i]
        if enemy and enemy:is_valid() and not enemy.is_dead and Enum.Buff and Enum.Buff.BlackPantherMark and enemy:has_buff(Enum.Buff.BlackPantherMark) then
            return true
        end
    end

    return false
end

local function enemy_within_range(player, range)
    local enemies = object_manager.get_players(true)
    if type(enemies) ~= "table" then return false end

    for i = 1, #enemies do
        local enemy = enemies[i]
        if enemy and enemy:is_valid() and not enemy.is_dead and enemy:has_line_of_sight() and player.location:get_distance_to_meters(enemy.location) <= range then
            return true
        end
    end

    return false
end

local function use_new_ability()
    if not input or not input.send_key then return false end
    return pcall(function()
        input.send_key(NEW_ABILITY_KEY, NEW_ABILITY_HOLD_MS)
    end) == true
end

local function get_priority_target(player)
    local best = nil
    local best_score = -1

    local enemies = object_manager.get_players(true)
    if not enemies then return nil end

    -- Black Panther's own damage goes up whenever his health drops below
    -- 100, so the low-HP execute threshold on enemies rises from 75 to 90
    -- while that's true, since he can now finish off targets he couldn't
    -- before. Gated behind the same required-key check as low-HP targeting
    -- itself.
    local low_hp_threshold = 75.0
    if required_key_is_down("bp_low_hp_key") and player and player.health and player.health < 100 then
        low_hp_threshold = 90.0
    end

    for i = 1, #enemies do
        local enemy = enemies[i]

        if enemy and enemy:is_valid() and not enemy.is_dead then
            local dist = player.location:get_distance_to_meters(enemy.location)

            if dist <= range_limit() and enemy:has_line_of_sight() and enemy_in_fov(enemy) then
                local is_marked = false
                if Enum.Buff and Enum.Buff.BlackPantherMark then
                    is_marked = enemy:has_buff(Enum.Buff.BlackPantherMark)
                end

                local is_low_hp = (script.get_setting("low_hp_dash_enabled") ~= false)
                    and ((enemy.health or 9999) < low_hp_threshold)
                local score = -1

                if is_marked and required_key_is_down("bp_mark_key") then
                    score = 1000 - dist
                elseif is_low_hp and required_key_is_down("bp_low_hp_key") then
                    score = 500 - dist
                end

                if score > best_score then
                    best_score = score
                    best = enemy
                end
            end
        end
    end

    return best
end

local w_key = Enum.Key.W or 87
local w_sent_by_script = false
local user_was_holding_w = false

-- New Aim Method: Flickbot-based aiming using built-in flickbot
local function aim_camera_at(player, enemy)
    if not player then return false end
    
    -- If no enemy or enemy no longer valid, try low HP target fallback
    if not enemy or not enemy:is_valid() or enemy.is_dead then
        if script.get_setting("new_aim_method") == true then
            enemy = find_low_hp_target(player)
        end
        if not enemy then return false end
    end
    
    if not enemy:is_valid() or enemy.is_dead then return false end

    local dist = player.location:get_distance_to_meters(enemy.location)
    if dist > 20 or dist < 0.5 then return false end

    if enemy.has_line_of_sight and not enemy:has_line_of_sight() then
        return false
    end

    -- Send W 200ms before flick (only once per sequence)
    if not w_sent_by_script then
        if input and input.is_key_down then
            local ok, down = pcall(function()
                return input.is_key_down(w_key)
            end)
            user_was_holding_w = (ok and down == true)
        end

        if not user_was_holding_w and input and input.press_key then
            pcall(function()
                input.press_key(w_key)
            end)
            w_sent_by_script = true
        end
        wait(25)
    end

    if not flickbot or not flickbot.perform then return false end

    -- Fast, smooth, sticky flick config
    local flick_cfg = {
        use_prediction = true,
        cancel_aiming_away = false,
        always_fire = false,
        duration = 300,
        aim_points = { Enum.AimPoint.Head, Enum.AimPoint.Neck },
    }

    local target_cfg = {
        aim_fov = script.get_setting("fov") or 360,
        dynamic_fov = true,
        ignore_invisible = true,
        ignore_shield = false,
        ignore_team = true,
        ignore_enemy = false,
        max_distance = range_limit()
    }

    local ok = pcall(function()
        flickbot.perform(enemy, SHIFT_ABILITY_TYPE, flick_cfg, target_cfg, Enum.AbilityWait.None)
    end)

    -- If multiple marks, hold Shift and chain Primary flickbots on remaining targets
    if ok then
        local marks = get_marked_enemies(player)
        if #marks >= 2 then
            -- Hold Shift through all remaining targets
            if ability_manager and ability_manager.press_input_id then
                pcall(function()
                    ability_manager:press_input_id(SHIFT_ABILITY_TYPE)
                end)
            end

            -- Flick Primary on remaining marks while Shift is held
            for i = 1, #marks do
                if marks[i] ~= enemy then
                    local target = marks[i]
                    if target and target:is_valid() and not target.is_dead 
                        and target:is_visible() and target:has_line_of_sight() then
                        pcall(function()
                            flickbot.perform(target, Enum.AbilityType.PrimaryAttack, flick_cfg, target_cfg, Enum.AbilityWait.None)
                        end)
                        wait(50)
                    end
                end
            end

            -- Release Shift when done
            if ability_manager and ability_manager.release_input_id then
                pcall(function()
                    ability_manager:release_input_id(SHIFT_ABILITY_TYPE)
                end)
            end
        end
    end

    return ok == true
end

-- Release W only when sequence is completely done
local function try_release_w()
    -- Only release if we sent it (not user holding it)
    if not w_sent_by_script then return end

    local marks = get_marked_enemies(object_manager.get_local_player())
    if #marks > 0 then return end

    local player = object_manager.get_local_player()
    local target = get_priority_target(player)
    if target then return end

    -- All conditions met: release W
    if input and input.release_key then
        pcall(function()
            input.release_key(w_key)
        end)
    end
    w_sent_by_script = false
end

local INVERT_PITCH = true

-- Default aiming method: camera.look_at() the enemy directly, then correct
-- the pitch the same way backup_v2_1_.lua's Black Panther module does.
local function camera_look_at_enemy(player, enemy)
    if not camera or not player or not enemy then return false end
    if not camera.look_at then return false end

    local looked = false
    if pcall(function()
        camera.look_at(enemy.location)
    end) then
        looked = true
    elseif enemy.location.x and enemy.location.y and enemy.location.z and pcall(function()
        camera.look_at(enemy.location.x, enemy.location.y, enemy.location.z)
    end) then
        looked = true
    end

    if looked and INVERT_PITCH and camera.get_rotation and camera.set_rotation then
        local ok, rotation = pcall(function()
            return camera.get_rotation()
        end)
        if ok and rotation and rotation.pitch and rotation.yaw then
            pcall(function()
                camera.set_rotation(-rotation.pitch, rotation.yaw)
            end)
        end
    end

    return looked
end

-- New Aim Method setting: false (default) uses camera_look_at_enemy above;
-- true flips over to the aim_camera_at flickbot method instead.
local function aim_at_enemy(player, enemy)
    if script.get_setting("new_aim_method") == true then
        return aim_camera_at(player, enemy)
    end

    return camera_look_at_enemy(player, enemy)
end

-- Same body as Black_Panther_Autodash.lua's on_activate_combo, just renamed
-- (it's now called by scan_once() every tick, not by the framework per
-- button press) plus the two `scan_active` re-checks noted up top. Every
-- wait(), loop count, and threshold below is untouched.
local function get_marked_enemies(player)
    local marked = {}
    local enemies = object_manager.get_players(true)
    if not enemies then return marked end

    for i = 1, #enemies do
        local enemy = enemies[i]
        if enemy and enemy:is_valid() and not enemy.is_dead
            and Enum.Buff and Enum.Buff.BlackPantherMark
            and enemy:has_buff(Enum.Buff.BlackPantherMark)
            and enemy:has_line_of_sight()
            and player.location:get_distance_to_meters(enemy.location) <= range_limit() then
            marked[#marked + 1] = enemy
        end
    end

    return marked
end

-- New Aim Method: dash-chain marked targets first, then eligible low-health
-- targets. Each target is consumed once, while the list is refreshed between
-- dashes so targets that disappear are skipped immediately.
local function valid_new_aim_target(player, enemy)
    if not player or not enemy then return false end
    if not enemy:is_valid() or enemy.is_dead then return false end

    local visible = false
    if enemy.is_visible then
        local ok, value = pcall(function() return enemy:is_visible() end)
        visible = ok and value == true
    end
    if not visible then return false end

    local ok_los, has_los = pcall(function() return enemy:has_line_of_sight() end)
    if not ok_los or has_los ~= true then return false end

    return enemy_in_fov(enemy)
        and player.location:get_distance_to_meters(enemy.location) <= range_limit()
end

local function get_new_aim_chain_targets(player, used)
    local marked, low_hp = {}, {}
    local enemies = object_manager.get_players(true)
    if type(enemies) ~= "table" then return marked end

    local low_hp_enabled = script.get_setting("low_hp_dash_enabled") ~= false
        and required_key_is_down("bp_low_hp_key")
    local marked_enabled = required_key_is_down("bp_mark_key")
    local low_hp_threshold = 75.0
    if low_hp_enabled and player.health and player.health < 100 then
        low_hp_threshold = 90.0
    end

    for i = 1, #enemies do
        local enemy = enemies[i]
        if enemy and not used[enemy] and valid_new_aim_target(player, enemy) then
            local is_marked = Enum.Buff and Enum.Buff.BlackPantherMark
                and enemy:has_buff(Enum.Buff.BlackPantherMark)
            if is_marked and marked_enabled then
                marked[#marked + 1] = enemy
            elseif low_hp_enabled and (enemy.health or math.huge) < low_hp_threshold then
                low_hp[#low_hp + 1] = enemy
            end
        end
    end

    local function nearest_first(a, b)
        return player.location:get_distance_to_meters(a.location)
            < player.location:get_distance_to_meters(b.location)
    end
    table.sort(marked, nearest_first)
    table.sort(low_hp, nearest_first)
    for i = 1, #low_hp do marked[#marked + 1] = low_hp[i] end
    return marked
end

local function run_new_aim_dash_chain(player)
    if not ability2_ready(player) then return false end

    local targets = get_new_aim_chain_targets(player, {})
    if #targets < 2 then return false end
    if not flickbot or not flickbot.perform then return false end

    local user_holds_w = false
    if input and input.is_key_down then
        local ok, down = pcall(function() return input.is_key_down(w_key) end)
        user_holds_w = ok and down == true
    end
    if not user_holds_w and input and input.press_key then
        pcall(function() input.press_key(w_key) end)
        w_sent_by_script = true
    end

    local user_holds_shift = false
    if input and input.is_key_down then
        local ok, down = pcall(function() return input.is_key_down(Enum.Key.LeftShift) end)
        user_holds_shift = ok and down == true
    end
    if not user_holds_shift and input and input.press_key then
        pcall(function() input.press_key(Enum.Key.LeftShift) end)
    end
    wait(25)

    local flick_cfg = {
        use_prediction = true,
        cancel_aiming_away = false,
        always_fire = false,
        duration = 150,
        aim_points = { Enum.AimPoint.Head, Enum.AimPoint.Neck },
    }
    local target_cfg = {
        aim_fov = script.get_setting("fov") or 360,
        dynamic_fov = true,
        ignore_invisible = true,
        ignore_shield = false,
        ignore_team = true,
        ignore_enemy = false,
        max_distance = range_limit(),
    }

    local used = {}
    while scan_active do
        local next_targets = get_new_aim_chain_targets(player, used)
        local target = next_targets[1]
        if not target then break end

        used[target] = true
        -- Recheck at the exact moment of casting; the target may have died,
        -- become invisible, or lost LOS after it was selected.
        if valid_new_aim_target(player, target) then
            pcall(function()
                flickbot.perform(target, SHIFT_ABILITY_TYPE, flick_cfg, target_cfg, Enum.AbilityWait.None)
            end)
        end
    end

    wait(100)
    if not user_holds_shift and input and input.release_key then
        pcall(function() input.release_key(Enum.Key.LeftShift) end)
    end
    if w_sent_by_script and input and input.release_key then
        pcall(function() input.release_key(w_key) end)
        w_sent_by_script = false
    end
    return true
end

-- Multi Mark Sequence: when 2+ enemies are marked, hold Shift down (via
-- press_input_id/release_input_id -- new/unconfirmed SDK methods per the
-- dev's update, wrapped defensively) and chain the camera through each
-- marked enemy in turn, releasing only once no marks remain.
local function run_multi_mark_sequence(player)
    if script.get_setting("new_aim_method") == true then return false end
    if script.get_setting("Blackpanther_multi_mark_enabled") == false then return false end
    if not ability2_ready(player) then return false end

    local marks = get_marked_enemies(player)
    if #marks < 2 then return false end

    wait(50)

    if not scan_active then return false end
    if not ability2_ready(player) then return false end

    local pressed = pcall(function()
        ability_manager:press_input_id(SHIFT_ABILITY_TYPE)
    end)

    for i = 1, #marks do
        if not scan_active then break end

        local enemy = marks[i]
        if enemy and enemy:is_valid() and not enemy.is_dead then
            aim_at_enemy(player, enemy)
        end

        -- Re-check for marks as they clear mid-sequence rather than only
        -- trusting the snapshot taken at the start.
        if #get_marked_enemies(player) == 0 then break end
    end

    pcall(function()
        ability_manager:release_input_id(SHIFT_ABILITY_TYPE)
    end)

    return true
end

local function run_bp_tick(player)
    if script.get_setting("new_aim_method") == true then
        return run_new_aim_dash_chain(player)
    end

    if run_multi_mark_sequence(player) then
        return true
    end

    local target = get_priority_target(player)

    if target and ability2_ready(player) then
        local target_yaw = aim_at_enemy(player, target)

        if target_yaw and scan_active and is_black_panther(object_manager.get_local_player()) then
            input.send_key(Enum.Key.LeftShift, 10)
            wait(100)

            if scan_active then
                local next_target = get_priority_target(player)
                if not next_target then
                    local cur = camera.get_rotation()
                    if cur.pitch < 0 then
                        for i = 1, 40 do
                            local r = camera.get_rotation()
                            if r.pitch >= 5 then break end
                            local dp = 5 - r.pitch
                            camera.set_rotation(r.pitch + dp * 0.12, r.yaw)
                            wait(8)
                        end
                    end
                end
            end
        end

        return true
    end

    if script.get_setting("new_ability_enabled") ~= false and not has_any_marked_enemy() and enemy_within_range(player, MARK_RANGE_M) and new_ability_ready(player) and ability2_ready(player) then
        use_new_ability()
        return true
    end

    smoothed_target_z = nil
    return false
end

local function scan_once()
    if busy then return false end

    local player = object_manager.get_local_player()
    if not is_black_panther(player) then return false end

    busy = true
    local ok, result = pcall(run_bp_tick, player)
    busy = false

    if not ok then
        smoothed_target_z = nil
        return false
    end

    -- Try to release W if sequence is complete
    try_release_w()

    return result == true
end

local function start_scanner()
    if scanner_id then return true end

    scanner_id = timer.set_interval(function()
        if input and input.is_key_down and input.is_key_down(END_KEY) then
            scan_active = false
            return
        end

        if scan_active then
            scan_once()
        end
    end, SCAN_MS)

    return true
end

-- Called once by the outer framework when it enables this scanner for the
-- current hero. Does NOT fire immediately -- it just arms the scanner and
-- waits for start_scanner()'s own timer to fire on its first tick.
function on_activate_combo(ctx)
    start_scanner()
    scan_active = true
    return true
end

-- Called once by the outer framework when it disables this scanner (hero
-- changed away from Black Panther, route disabled, or scan stopped).
function on_deactivate_combo(ctx)
    scan_active = false
    smoothed_target_z = nil
    if scanner_id then
        timer.clear(scanner_id)
        scanner_id = nil
    end
end

]],
}



MODULE_DEFS[#MODULE_DEFS + 1] = {
    name = "IronFist",
    kind = "scanner",
    source = [[
local IRON_FIST_DEFAULT_ID = 1052
local SHIFT = Enum.AbilityType.Ability2
local SHIFT_KEY = Enum.Key and Enum.Key.LeftShift or "Shift"

-- Constants (removed from settings)
local HERO_ID          = IRON_FIST_DEFAULT_ID
local RANGE_M          = 15
local INVERT_PITCH     = true
local LOOK_STEPS       = 8
local LOOK_STEP_MS     = 1
local FLICK_DURATION_MS = 125
local SCAN_MS          = script.get_setting("scan_poll_ms") or 100
local END_KEY          = 35

settings = {
    { key = "dash_low_hp_targets", label = "Dash Low HP Targets", default = true },
    { key = "hp_threshold", label = "Effective HP Threshold", default = 85, min = 1, max = 1000 },
    { key = "include_shield", label = "Include Shield", default = true },
    { key = "fov", label = "FOV", default = 360, min = 1, max = 360 },
    { key = "shift_hold_ms", label = "Shift Hold MS", default = 5, min = 1, max = 250 },
}

local function range_m()
    return s("psylocke_range", 10)
end

local scan_active = false
local scanner_id = nil
local busy = false
local last_cast_time = 0

local function s(key, fallback)
    local value = script.get_setting(key)
    if value == nil then return fallback end
    return value
end

local function range_m()
    return RANGE_M
end

local function now_ms()
    if os and os.clock then
        return os.clock() * 1000
    end
    return 0
end

local function get_hero_id(player)
    if not player then return nil end

    if player.get_hero_id then
        local ok, id = pcall(function()
            return player:get_hero_id()
        end)
        if ok and id then return id end
    end

    return player.hero_id
end

local function valid_player(player)
    return player and player:is_valid() and not player.is_dead and player.location
end

local function valid_enemy(enemy)
    return enemy
        and enemy:is_valid()
        and not enemy.is_dead
        and enemy:is_enemy()
        and enemy:is_visible()
        and enemy.location
end

local function has_line_of_sight(enemy)
    if not enemy or not enemy.has_line_of_sight then
        return false
    end

    local ok, result = pcall(function()
        return enemy:has_line_of_sight()
    end)

    return ok and result == true
end

local function is_iron_fist(player)
    return valid_player(player) and get_hero_id(player) == HERO_ID
end

local function distance_m(player, enemy)
    if not valid_player(player) or not valid_enemy(enemy) then
        return math.huge
    end

    if player.location.get_distance_to_meters then
        return player.location:get_distance_to_meters(enemy.location)
    end

    return player.location:get_distance_to(enemy.location) * 0.01
end

local function enemy_in_fov(enemy)
    local limit = s("fov", 360)
    if limit >= 360 then return true end
    if not enemy or not enemy.get_fov_to_target then return true end

    local ok, fov = pcall(function()
        return enemy:get_fov_to_target()
    end)

    if not ok or fov == nil then return true end
    return math.abs(fov) <= limit
end

local function effective_hp(enemy)
    if not enemy then return math.huge end

    local hp = enemy.health
    if not hp then return math.huge end

    if s("include_shield", true) then
        hp = hp + (enemy.shield or 0)
    end

    return hp
end

local function black_panther_mark_type()
    if Enum and Enum.Buff then
        if Enum.Buff.BlackPantherMark then
            return Enum.Buff.BlackPantherMark
        end

        if Enum.Buff.Type and Enum.Buff.Type.BlackPantherMark then
            return Enum.Buff.Type.BlackPantherMark
        end
    end

    return nil
end

local function has_black_panther_mark(enemy)
    if not enemy or not enemy.has_buff then return false end

    local mark = black_panther_mark_type()
    if not mark then return false end

    local ok, result = pcall(function()
        return enemy:has_buff(mark)
    end)

    return ok and result == true
end

local function get_shift_ability(player)
    if not player then return nil end

    if player.get_ability then
        local ok, ability = pcall(function()
            return player:get_ability(SHIFT)
        end)
        if ok and ability then return ability end
    end

    if player.get_abilities then
        local ok, abilities = pcall(function()
            return player:get_abilities()
        end)

        if ok and type(abilities) == "table" then
            for i = 1, #abilities do
                local ability = abilities[i]
                if ability then
                    local type_ok, ability_type = pcall(function()
                        return ability:get_type()
                    end)

                    local id_ok, ability_id = pcall(function()
                        return ability:get_id()
                    end)

                    if (type_ok and ability_type == SHIFT) or (id_ok and ability_id == 105251) then
                        return ability
                    end
                end
            end
        end
    end

    return nil
end

-- Iron Fist's Ability2 can be nil from get_ability(Ability2), so fall back to get_abilities().
local function shift_ready(player)
    local ability = get_shift_ability(player)
    if not ability then return false end

    if ability.is_valid and not ability:is_valid() then return false end
    if ability.on_cooldown and ability:on_cooldown() then return false end
    if ability.is_activated and ability:is_activated() then return false end
    if ability.cooldown_remaining and ability.cooldown_remaining > 0 then return false end

    return ability.can_activate and ability:can_activate() == true
end

local function find_marked_target(player)
    local enemies = object_manager.get_players(true)
    if type(enemies) ~= "table" then return nil end

    local best = nil
    local best_dist = math.huge

    for i = 1, #enemies do
        local enemy = enemies[i]

        if valid_enemy(enemy) then
            local dist = distance_m(player, enemy)

            if dist <= range_m() and enemy_in_fov(enemy) and has_black_panther_mark(enemy) and enemy:is_visible() and has_line_of_sight(enemy) then
                if dist < best_dist then
                    best = enemy
                    best_dist = dist
                end
            end
        end
    end

    return best
end

local function find_low_hp_target(player)
    if s("dash_low_hp_targets", true) == false then return nil end

    local enemies = object_manager.get_players(true)
    if type(enemies) ~= "table" then return nil end

    local best = nil
    local best_hp = math.huge
    local best_dist = math.huge
    local threshold = s("hp_threshold", 85)

    for i = 1, #enemies do
        local enemy = enemies[i]

        if valid_enemy(enemy) then
            local dist = distance_m(player, enemy)
            local hp = effective_hp(enemy)

            if dist <= range_m() and enemy_in_fov(enemy) and hp <= threshold and enemy:is_visible() and has_line_of_sight(enemy) then
                if hp < best_hp or (hp == best_hp and dist < best_dist) then
                    best = enemy
                    best_hp = hp
                    best_dist = dist
                end
            end
        end
    end

    return best
end

local function find_target(player)
    return find_marked_target(player) or find_low_hp_target(player)
end

local function camera_look_at_enemy(player, enemy)
    if not camera or not valid_player(player) or not valid_enemy(enemy) then return false end
    if not camera.look_at then return false end

    local looked = false
    if pcall(function()
        camera.look_at(enemy.location)
    end) then
        looked = true
    elseif enemy.location.x and enemy.location.y and enemy.location.z and pcall(function()
        camera.look_at(enemy.location.x, enemy.location.y, enemy.location.z)
    end) then
        looked = true
    end

    if looked and INVERT_PITCH and camera.get_rotation and camera.set_rotation then
        local ok, rotation = pcall(function()
            return camera.get_rotation()
        end)
        if ok and rotation and rotation.pitch and rotation.yaw then
            pcall(function()
                camera.set_rotation(-rotation.pitch, rotation.yaw)
            end)
        end
    end

    return looked
end

local function sticky_look(player, enemy)
    for i = 1, LOOK_STEPS do
        if input and input.is_key_down and input.is_key_down(END_KEY) then
            scan_active = false
            return false, false
        end

        if not camera_look_at_enemy(player, enemy) then
            return false, false
        end

        wait(LOOK_STEP_MS)
    end

    return true, false
end

local function cast_shift()
    local did_cast = false

    if ability_manager and ability_manager.activate_ability then
        local ok = pcall(function()
            ability_manager:activate_ability(SHIFT, s("shift_hold_ms", 5))
        end)
        did_cast = ok == true
    end

    if input and input.press_key and input.release_key then
        pcall(function()
            input.press_key(SHIFT_KEY)
            wait(s("shift_hold_ms", 5))
            input.release_key(SHIFT_KEY)
        end)
        did_cast = true
    end

    if not did_cast then return false end
    last_cast_time = now_ms()
    return true
end

-- FIX: 250ms cooldown guard moved before busy lock so it doesn't hold the lock unnecessarily
local function scan_once()
    if busy then return false end
    if now_ms() - last_cast_time < 250 then return false end

    local player = object_manager.get_local_player()
    if not is_iron_fist(player) then return false end
    if not shift_ready(player) then return false end

    local target = find_target(player)
    if not target then return false end

    busy = true

    local ok, result = pcall(function()
        if not has_line_of_sight(target) then return false end
        local looked, already_cast = sticky_look(player, target)
        if not looked then return false end
        if already_cast then return true end
        if not has_line_of_sight(target) then return false end
        if not shift_ready(player) then return false end
        return cast_shift()
    end)

    busy = false

    return ok and result == true
end

local function start_scanner()
    if scanner_id then return true end

    scanner_id = timer.set_interval(function()
        if input and input.is_key_down and input.is_key_down(END_KEY) then
            scan_active = false
            return
        end

        if scan_active then
            scan_once()
        end
    end, SCAN_MS)

    return true
end

function on_activate_combo(ctx)
    start_scanner()
    scan_active = true
    return true
end

function on_deactivate_combo(ctx)
    -- End key stops the toggle. Releasing combo does not stop the scanner.
end

]],
}

MODULE_DEFS[#MODULE_DEFS + 1] = {
    name = "Psylocke",
    kind = "scanner",
    source = [[
local PSYLOCKE_DEFAULT_ID = 1048
local SHIFT = Enum.AbilityType.Ability2
local HERO_HULK = 1011
local HERO_HELA = 1024
local HERO_MAGNETO = 1037
local HERO_NAMOR = 1045
local HERO_THE_THING = 1051
local HERO_IRON_FIST = 1052

-- Constants (removed from settings)
local HERO_ID          = PSYLOCKE_DEFAULT_ID
local INVERT_PITCH     = true
local LOOK_STEPS       = 8
local LOOK_STEP_MS     = 1
local FLICK_DURATION_MS = 125
local SCAN_MS          = script.get_setting("scan_poll_ms") or 100
local END_KEY          = 35

settings = {
    { key = "dash_low_hp_targets", label = "Dash Low HP Targets", default = true },
    { key = "hp_threshold", label = "Effective HP Threshold", default = 45, min = 1, max = 1000 },
    { key = "include_shield", label = "Include Shield", default = true },
    { key = "fov", label = "FOV", default = 360, min = 1, max = 360 },
    { key = "shift_hold_ms", label = "Shift Hold MS", default = 5, min = 1, max = 250 },
}

local scan_active = false
local scanner_id = nil
local busy = false
local last_cast_time = 0

local function s(key, fallback)
    local value = script.get_setting(key)
    if value == nil then return fallback end
    return value
end

local function now_ms()
    if os and os.clock then
        return os.clock() * 1000
    end
    return 0
end

local function get_hero_id(player)
    if not player then return nil end

    if player.get_hero_id then
        local ok, id = pcall(function()
            return player:get_hero_id()
        end)
        if ok and id then return id end
    end

    return player.hero_id
end

local function valid_player(player)
    return player and player:is_valid() and not player.is_dead and player.location
end

local function valid_enemy(enemy)
    return enemy
        and enemy:is_valid()
        and not enemy.is_dead
        and enemy:is_enemy()
        and enemy:is_visible()
        and enemy.location
end

local function has_line_of_sight(enemy)
    if not enemy or not enemy.has_line_of_sight then
        return false
    end

    local ok, result = pcall(function()
        return enemy:has_line_of_sight()
    end)

    return ok and result == true
end

local function is_psylocke(player)
    return valid_player(player) and get_hero_id(player) == HERO_ID
end

local function distance_m(player, enemy)
    if not valid_player(player) or not valid_enemy(enemy) then
        return math.huge
    end

    if player.location.get_distance_to_meters then
        return player.location:get_distance_to_meters(enemy.location)
    end

    return player.location:get_distance_to(enemy.location) * 0.01
end

local function range_limit()
    return range_m()
end

local function enemy_in_fov(enemy)
    local limit = s("fov", 360)
    if limit >= 360 then return true end
    if not enemy or not enemy.get_fov_to_target then return true end

    local ok, fov = pcall(function()
        return enemy:get_fov_to_target()
    end)

    if not ok or fov == nil then return true end
    return math.abs(fov) <= limit
end

local function effective_hp(enemy)
    if not enemy then return math.huge end

    local hp = enemy.health
    if not hp then return math.huge end

    if s("include_shield", true) then
        hp = hp + (enemy.shield or 0)
    end

    return hp
end

local function black_panther_mark_type()
    if Enum and Enum.Buff then
        if Enum.Buff.BlackPantherMark then
            return Enum.Buff.BlackPantherMark
        end

        if Enum.Buff.Type and Enum.Buff.Type.BlackPantherMark then
            return Enum.Buff.Type.BlackPantherMark
        end
    end

    return nil
end

local function has_black_panther_mark(enemy)
    if not enemy or not enemy.has_buff then return false end

    local mark = black_panther_mark_type()
    if not mark then return false end

    local ok, result = pcall(function()
        return enemy:has_buff(mark)
    end)

    return ok and result == true
end

local function buff_type(name)
    if not Enum or not Enum.Buff then return nil end
    if Enum.Buff[name] then return Enum.Buff[name] end
    if Enum.Buff.Type and Enum.Buff.Type[name] then return Enum.Buff.Type[name] end
    return nil
end

local function has_buff(enemy, name)
    if not enemy or not enemy.has_buff then return false end

    local buff = buff_type(name)
    if not buff then return false end

    local ok, result = pcall(function()
        return enemy:has_buff(buff)
    end)

    return ok and result == true
end

local function ability_type(ability)
    if not ability or not ability.get_type then return nil end
    local ok, result = pcall(function()
        return ability:get_type()
    end)
    if ok then return result end
    return nil
end

local function ability_is_active(ability)
    if not ability then return false end

    if ability.is_activated ~= nil then
        if type(ability.is_activated) == "function" then
            local ok, active = pcall(function()
                return ability:is_activated()
            end)
            return ok and active == true
        end

        return ability.is_activated == true
    end

    return false
end

local function get_ability_safe(enemy, ability_enum)
    if not enemy then return nil end

    if enemy.get_ability then
        local ok, ability = pcall(function()
            return enemy:get_ability(ability_enum)
        end)

        if ok and ability then return ability end
    end

    if enemy.get_abilities then
        local ok, abilities = pcall(function()
            return enemy:get_abilities()
        end)

        if ok and type(abilities) == "table" then
            for _, ability in next, abilities do
                if ability_type(ability) == ability_enum then
                    return ability
                end
            end
        end
    end

    return nil
end

local function ability_active(enemy, ability_enum)
    return ability_is_active(get_ability_safe(enemy, ability_enum))
end

local function should_ignore_target(enemy)
    if not valid_enemy(enemy) then return true end

    local hero_id = get_hero_id(enemy)

    if has_buff(enemy, "Bubbled") then return true end
    if hero_id == HERO_HULK and has_buff(enemy, "HulkTransforming") then return true end
    if hero_id == HERO_NAMOR and ability_active(enemy, Enum.AbilityType.Ability2) then return true end
    if hero_id == HERO_IRON_FIST and ability_active(enemy, Enum.AbilityType.SecondaryAttack) then return true end
    if hero_id == HERO_HELA and ability_active(enemy, Enum.AbilityType.Ultimate) then return true end
    if hero_id == HERO_THE_THING and ability_active(enemy, Enum.AbilityType.Ability2) then return true end

    return false
end

-- FIX: call on_cooldown and is_activated as methods, not field existence checks
local function shift_ready(player)
    local ability = player and player.get_ability and player:get_ability(SHIFT)
    if not ability then return false end

    if ability.is_valid and not ability:is_valid() then return false end
    if ability.on_cooldown and ability:on_cooldown() then return false end
    if ability.is_activated and ability:is_activated() then return false end
    if ability.cooldown_remaining and ability.cooldown_remaining > 0 then return false end

    if ability_manager and ability_manager.can_activate_ability then
        return ability_manager:can_activate_ability(SHIFT) == true
    end

    return ability.can_activate and ability:can_activate() == true
end

local function find_marked_target(player)
    local enemies = object_manager.get_players(true)
    if type(enemies) ~= "table" then return nil end

    local best = nil
    local best_dist = math.huge

    for i = 1, #enemies do
        local enemy = enemies[i]

        if valid_enemy(enemy) and not should_ignore_target(enemy) then
            local dist = distance_m(player, enemy)

            if dist <= range_limit() and enemy_in_fov(enemy) and has_black_panther_mark(enemy) and enemy:is_visible() and has_line_of_sight(enemy) then
                if dist < best_dist then
                    best = enemy
                    best_dist = dist
                end
            end
        end
    end

    return best
end

local function find_low_hp_target(player)
    if s("dash_low_hp_targets", true) == false then return nil end

    local enemies = object_manager.get_players(true)
    if type(enemies) ~= "table" then return nil end

    local best = nil
    local best_hp = math.huge
    local best_dist = math.huge
    local threshold = s("hp_threshold", 45)

    for i = 1, #enemies do
        local enemy = enemies[i]

        if valid_enemy(enemy) and not should_ignore_target(enemy) then
            local dist = distance_m(player, enemy)
            local hp = effective_hp(enemy)

            if dist <= range_limit() and enemy_in_fov(enemy) and hp <= threshold and enemy:is_visible() and has_line_of_sight(enemy) then
                if hp < best_hp or (hp == best_hp and dist < best_dist) then
                    best = enemy
                    best_hp = hp
                    best_dist = dist
                end
            end
        end
    end

    return best
end

local function find_target(player)
    return find_low_hp_target(player)
end

local function camera_look_at_enemy(player, enemy)
    if not camera or not valid_player(player) or not valid_enemy(enemy) then return false end
    if not camera.look_at then return false end

    local looked = false
    if pcall(function()
        camera.look_at(enemy.location)
    end) then
        looked = true
    elseif enemy.location.x and enemy.location.y and enemy.location.z and pcall(function()
        camera.look_at(enemy.location.x, enemy.location.y, enemy.location.z)
    end) then
        looked = true
    end

    if looked and INVERT_PITCH and camera.get_rotation and camera.set_rotation then
        local ok, rotation = pcall(function()
            return camera.get_rotation()
        end)
        if ok and rotation and rotation.pitch and rotation.yaw then
            pcall(function()
                camera.set_rotation(-rotation.pitch, rotation.yaw)
            end)
        end
    end

    return looked
end

local function sticky_look(player, enemy)
    for i = 1, LOOK_STEPS do
        if input and input.is_key_down and input.is_key_down(END_KEY) then
            scan_active = false
            return false, false
        end

        if not camera_look_at_enemy(player, enemy) then
            return false, false
        end

        wait(LOOK_STEP_MS)
    end

    return true, false
end

local function cast_shift()
    if not ability_manager or not ability_manager.activate_ability then return false end

    ability_manager:activate_ability(SHIFT, s("shift_hold_ms", 5))
    last_cast_time = now_ms()
    return true
end

-- FIX: 250ms cooldown guard moved before busy lock so it doesn't hold the lock unnecessarily
local function scan_once()
    if busy then return false end
    if now_ms() - last_cast_time < 250 then return false end

    local player = object_manager.get_local_player()
    if not is_psylocke(player) then return false end
    if not shift_ready(player) then return false end

    local target = find_target(player)
    if not target then return false end

    busy = true

    local ok, result = pcall(function()
        if not has_line_of_sight(target) then return false end
        local looked, already_cast = sticky_look(player, target)
        if not looked then return false end
        if already_cast then return true end
        if not has_line_of_sight(target) then return false end
        if not shift_ready(player) then return false end
        return cast_shift()
    end)

    busy = false

    return ok and result == true
end

local function start_scanner()
    if scanner_id then return true end

    scanner_id = timer.set_interval(function()
        if input and input.is_key_down and input.is_key_down(END_KEY) then
            scan_active = false
            return
        end

        if scan_active then
            scan_once()
        end
    end, SCAN_MS)

    return true
end

function on_activate_combo(ctx)
    start_scanner()
    scan_active = true
    return true
end

function on_deactivate_combo(ctx)
    -- End key stops the toggle. Releasing combo does not stop the scanner.
end

]],
}


MODULE_DEFS[#MODULE_DEFS + 1] = {
    name = "Captain America Dynamic",
    kind = "combo",
    source = [[
-- cap route test. keeps the old aggressive timing, but wraps the sketchy sdk calls
-- so a dead target or missing manager does not blow the whole file up.

local melee_attack = Enum.AbilityType.MeleeAttack
local primary_attack = Enum.AbilityType.PrimaryAttack
local secondary_attack = Enum.AbilityType.SecondaryAttack
local shield_bash = Enum.AbilityType.Ability1

local route_single_target      = "single_target"
local route_melee_pair         = "melee_pair"
local route_primary_throw      = "primary_throw"
local route_ability1_finisher  = "ability1_finisher"

settings = {
    {key = "aiming", label = "aiming on/off", default = true},
    {key = "aim_fov", label = "fov", default = 30, min = 0, max = 180},
    {key = "humanized_aim", label = "Humanized Aim", default = true},
    {key = "humanize_ms", label = "Humanize Time MS", default = 150, min = 0, max = 500},
}

local aim_fov_default = 30
local enemy_range = 4.7
local far_enemy_range = 15
local melee_only_close_enemy_count = 1
local ability1_safe_enemy_count = 1

-- e finisher only.
local ability1_finisher_effective_hp = 70
local ability1_finisher_range = 15

-- base delays from the older version.
local combo1_to_melee_delay_ms = 400
local combo1_to_primary_delay_ms = 425
local melee_pair_to_melee_pair_delay_ms = 450
local melee_pair_to_primary_delay_ms = 430
local primary_to_primary_recheck_delay_ms = 10
local primary_to_melee_delay_ms = 475
local melee_pair_to_combo1_delay_ms = 425

local combo1_to_combo1_delay_ms = combo1_to_melee_delay_ms
local primary_to_combo1_delay_ms = primary_to_melee_delay_ms
local combo1_to_finisher_delay_ms = combo1_to_primary_delay_ms
local melee_pair_to_finisher_delay_ms = melee_pair_to_primary_delay_ms
local primary_to_finisher_delay_ms = primary_to_melee_delay_ms
local finisher_to_melee_delay_ms = primary_to_melee_delay_ms
local finisher_to_primary_delay_ms = combo1_to_primary_delay_ms
local finisher_to_combo1_delay_ms = primary_to_combo1_delay_ms
local finisher_to_finisher_delay_ms = primary_to_primary_recheck_delay_ms

local melee1_to_melee2_delay_ms = 450
local melee2_to_primary_delay_ms = 500
local primary_to_ability1_delay_ms = 100
local ability1_to_secondary_delay_ms = 100

-- aggressive on purpose. if it starts dropping inputs, these are the first knobs.
local route_switch_early_factor = 0.01
local step_delay_factor = 0.01

local target_check_interval_ms = 10
local route_switch_check_interval_ms = 10

local melee_target_window_ms = 350
local far_target_window_ms = 250
local ability_ready_window_ms = 175
local finisher_ready_window_ms = 125

local route_switch_max_wait_ms = 900

-- nil means use the target location. try "body" or "head" here if it aims low.
local aim_bone_name = nil

local enable_failed_cast_retry = false
local failed_cast_retry_delay_ms = 25
local failed_cast_retry_max = 1

-- timer callbacks can fire after the original target is gone.
local min_timer_delay_ms = 5

local active_combo_id = 0

local function start_new_combo()
    active_combo_id = active_combo_id + 1
    return active_combo_id
end

local function combo_is_current(combo_id)
    return combo_id == active_combo_id
end

local function stop_combo(combo_id)
    if combo_is_current(combo_id) then
        active_combo_id = active_combo_id + 1
    end
end

local function schedule(combo_id, delay_ms, callback)
    if not combo_is_current(combo_id) then
        return nil
    end

    if delay_ms == nil or delay_ms <= 0 then
        local ok = pcall(callback)
        if not ok then
            stop_combo(combo_id)
        end
        return nil
    end

    if timer == nil or timer.set_timeout == nil then
        stop_combo(combo_id)
        return nil
    end

    if delay_ms < min_timer_delay_ms then
        delay_ms = min_timer_delay_ms
    end

    local ok, handle = pcall(function()
        return timer.set_timeout(function()
            if not combo_is_current(combo_id) then
                return
            end

            local callback_ok = pcall(callback)
            if not callback_ok then
                stop_combo(combo_id)
            end
        end, delay_ms)
    end)

    if not ok then
        stop_combo(combo_id)
        return nil
    end

    return handle
end

local function safe_call(fn, fallback)
    local ok, result = pcall(fn)

    if not ok then
        return fallback
    end

    return result
end

local function safe_field(obj, field, fallback)
    if obj == nil then
        return fallback
    end

    return safe_call(function()
        return obj[field]
    end, fallback)
end

local function setting_value(key, fallback)
    if script == nil or script.get_setting == nil then
        return fallback
    end

    local value = safe_call(function()
        return script.get_setting(key)
    end, fallback)

    if value == nil then
        return fallback
    end

    return value
end

local function aiming_enabled()
    return setting_value("aiming", true) == true
end

local function current_aim_fov()
    local value = tonumber(setting_value("aim_fov", aim_fov_default)) or aim_fov_default

    if value < 0 then
        return 0
    end

    if value > 180 then
        return 180
    end

    return value
end

local function safe_is_valid(obj)
    if obj == nil or obj.is_valid == nil then
        return false
    end

    return safe_call(function()
        return obj:is_valid()
    end, false) == true
end

local function safe_is_enemy(obj)
    if obj == nil or obj.is_enemy == nil then
        return false
    end

    return safe_call(function()
        return obj:is_enemy()
    end, false) == true
end

local function safe_is_dead(obj)
    return safe_field(obj, "is_dead", true) == true
end

local function safe_location(obj)
    return safe_field(obj, "location", nil)
end

local function get_enemies()
    if object_manager == nil or object_manager.get_players == nil then
        return nil
    end

    local enemies = safe_call(function()
        return object_manager.get_players(true)
    end, nil)

    if type(enemies) ~= "table" then
        return nil
    end

    return enemies
end

local function get_local_player()
    if object_manager == nil or object_manager.get_local_player == nil then
        return nil
    end

    return safe_call(function()
        return object_manager.get_local_player()
    end, nil)
end

local function safe_get_fov_to_target(target)
    if target == nil or target.get_fov_to_target == nil then
        return nil
    end

    return safe_call(function()
        return target:get_fov_to_target()
    end, nil)
end

local function safe_get_distance(player, target)
    local player_location = safe_location(player)
    local target_location = safe_location(target)

    if player_location == nil or target_location == nil then
        return nil
    end

    if player_location.get_distance_to == nil then
        return nil
    end

    return safe_call(function()
        return player_location:get_distance_to(target_location) * 0.01
    end, nil)
end

local function safe_activate_ability(ability, hold_ms)
    if ability == melee_attack then
        if input == nil or input.send_key == nil then
            return false
        end

        return safe_call(function()
            input.send_key(Enum.Key.V, hold_ms or 5)
            return true
        end, false)
    end

    if ability_manager == nil or ability_manager.activate_ability == nil then
        return false
    end

    return safe_call(function()
        if hold_ms ~= nil then
            return ability_manager:activate_ability(ability, hold_ms)
        end

        return ability_manager:activate_ability(ability)
    end, false)
end

local function safe_ability_ready(ability)
    if ability_manager == nil or ability_manager.can_activate_ability == nil then
        return false
    end

    return safe_call(function()
        return ability_manager:can_activate_ability(ability)
    end, false) == true
end

local correct_vertical_pitch

local function shortest_yaw_delta(from_yaw, to_yaw)
    local delta = to_yaw - from_yaw

    while delta > 180 do delta = delta - 360 end
    while delta < -180 do delta = delta + 360 end

    return delta
end

local function safe_look_at(pos)
    if camera == nil or camera.look_at == nil or pos == nil then
        return
    end

    local start_rotation = nil

    if camera.get_rotation ~= nil then
        start_rotation = safe_call(function()
            return camera.get_rotation()
        end, nil)
    end

    safe_call(function()
        camera.look_at(pos)
    end, nil)

    -- Invert pitch AFTER look_at
    if camera.get_rotation ~= nil and camera.set_rotation ~= nil then
        local rotation = safe_call(function()
            return camera.get_rotation()
        end, nil)
        if rotation and rotation.pitch and rotation.yaw then
            safe_call(function()
                camera.set_rotation(-rotation.pitch, rotation.yaw)
            end, nil)
        end
    end

    if setting_value("humanized_aim", true) ~= true
        or start_rotation == nil
        or camera.get_rotation == nil
        or camera.set_rotation == nil then
        return
    end

    local target_rotation = safe_call(function()
        return camera.get_rotation()
    end, nil)

    if target_rotation == nil
        or start_rotation.pitch == nil
        or start_rotation.yaw == nil
        or target_rotation.pitch == nil
        or target_rotation.yaw == nil then
        return
    end

    local duration_ms = tonumber(setting_value("humanize_ms", 80)) or 80
    if duration_ms <= 0 then return end

    local step_ms = 8
    local steps = math.max(1, math.floor(duration_ms / step_ms))
    local pitch_delta = target_rotation.pitch - start_rotation.pitch
    local yaw_delta = shortest_yaw_delta(start_rotation.yaw, target_rotation.yaw)

    safe_call(function()
        camera.set_rotation(start_rotation.pitch, start_rotation.yaw)
    end, nil)

    for index = 1, steps do
        local t = index / steps
        local eased = t * t * (3 - (2 * t))
        local pitch = start_rotation.pitch + (pitch_delta * eased)
        local yaw = start_rotation.yaw + (yaw_delta * eased)

        safe_call(function()
            camera.set_rotation(pitch, yaw)
        end, nil)

        if index < steps then
            wait(step_ms)
        end
    end
end

-- correct_vertical_pitch removed - pitch inversion is now handled in safe_look_at after look_at

local function safe_bone_position(target, bone_name)
    if target == nil or target.get_bone_position == nil or bone_name == nil then
        return nil
    end

    return safe_call(function()
        return target:get_bone_position(bone_name)
    end, nil)
end

local function safe_pos_not_zero(pos)
    if pos == nil then
        return false
    end

    if pos.is_zero == nil then
        return true
    end

    return safe_call(function()
        return not pos:is_zero()
    end, false) == true
end

local function target_alive(target)
    return safe_is_valid(target) and not safe_is_dead(target)
end

local function player_alive(player)
    return safe_is_valid(player) and not safe_is_dead(player) and safe_location(player) ~= nil
end

local function enemy_alive(enemy)
    return safe_is_valid(enemy) and not safe_is_dead(enemy) and safe_is_enemy(enemy) and safe_location(enemy) ~= nil
end

local function get_distance(player, target)
    return safe_get_distance(player, target) or 999999
end

local function valid_player(player)
    return player_alive(player)
end

local function valid_enemy_basic(enemy)
    return enemy_alive(enemy)
end

local function ability_ready(ability)
    return safe_ability_ready(ability)
end

local function target_in_fov_and_range(player, target, max_range)
    if not valid_player(player) then
        return false
    end

    if not valid_enemy_basic(target) then
        return false
    end

    local fov = safe_get_fov_to_target(target)
    if fov == nil or fov > current_aim_fov() then
        return false
    end

    local distance = safe_get_distance(player, target)
    if distance == nil or distance > max_range then
        return false
    end

    return true
end

local function count_enemies_in_fov_and_range(player, range)
    if not valid_player(player) then
        return 0
    end

    local enemies = get_enemies()

    if enemies == nil then
        return 0
    end

    local count = 0

    for _, enemy in ipairs(enemies) do
        if target_in_fov_and_range(player, enemy, range) then
            count = count + 1
        end
    end

    return count
end

local function count_enemies_in_range_only(player, range)
    if not valid_player(player) then
        return 0
    end

    local enemies = get_enemies()

    if enemies == nil then
        return 0
    end

    local count = 0

    for _, enemy in ipairs(enemies) do
        local distance = safe_get_distance(player, enemy)
        if valid_enemy_basic(enemy)
            and distance ~= nil
            and distance <= range then
            count = count + 1
        end
    end

    return count
end

local function should_force_melee_for_crowd(player)
    return count_enemies_in_fov_and_range(player, enemy_range) > melee_only_close_enemy_count
end

local function has_single_enemy_in_ability1_bounce_range(player)
    return count_enemies_in_range_only(player, far_enemy_range) == ability1_safe_enemy_count
end

local function get_effective_hp(target)
    local health = safe_field(target, "health", nil)

    if health == nil then
        return nil
    end

    return health + (safe_field(target, "shield", 0) or 0)
end

local function scaled_step_delay(ms)
    if ms == nil or ms <= 0 then
        return 0
    end

    local scaled = math.floor(ms * step_delay_factor)

    if scaled < 1 then
        return 1
    end

    return scaled
end

local function scaled_route_delay(ms)
    if ms == nil or ms <= 0 then
        return 0
    end

    local scaled = math.floor(ms * route_switch_early_factor)

    if scaled < 1 then
        return 1
    end

    return scaled
end

local function find_ability1_finisher_target(player, fallback_target)
    if not valid_player(player) then
        return nil
    end

    if not ability_ready(shield_bash) then
        return nil
    end

    local best_target = nil
    local best_hp = nil

    local function consider_target(target)
        if not target_in_fov_and_range(player, target, ability1_finisher_range) then
            return
        end

        local effective_hp = get_effective_hp(target)

        if effective_hp == nil or effective_hp > ability1_finisher_effective_hp then
            return
        end

        if best_target == nil or effective_hp < best_hp then
            best_target = target
            best_hp = effective_hp
        end
    end

    local enemies = get_enemies()

    if enemies ~= nil then
        for _, enemy in ipairs(enemies) do
            consider_target(enemy)
        end
    end

    consider_target(fallback_target)

    return best_target
end

local function find_enemy_in_range(player, fallback_target, max_range)
    if not valid_player(player) then
        return nil
    end

    local best_enemy = nil
    local best_distance = nil

    local enemies = get_enemies()

    if enemies ~= nil then
        for _, enemy in ipairs(enemies) do
            if target_in_fov_and_range(player, enemy, max_range) then
                local distance = safe_get_distance(player, enemy)

                if distance ~= nil and (best_enemy == nil or distance < best_distance) then
                    best_enemy = enemy
                    best_distance = distance
                end
            end
        end
    end

    if best_enemy ~= nil then
        return best_enemy
    end

    if target_in_fov_and_range(player, fallback_target, max_range) then
        return fallback_target
    end

    return nil
end

local function has_enemy_in_combo_range(player, fallback_target)
    return find_enemy_in_range(player, fallback_target, far_enemy_range) ~= nil
end

local function find_far_enemy(player, fallback_target)
    local target = find_enemy_in_range(player, fallback_target, far_enemy_range)

    if target == nil then
        return nil
    end

    if get_distance(player, target) <= enemy_range then
        return nil
    end

    return target
end

local function has_far_enemy(player, fallback_target)
    return find_far_enemy(player, fallback_target) ~= nil
end

local function get_aim_position(target)
    if not target_alive(target) then
        return nil
    end

    local pos = safe_bone_position(target, aim_bone_name)

    if safe_pos_not_zero(pos) then
        return pos
    end

    return safe_location(target)
end

local function aim_at_target(target)
    if not aiming_enabled() then
        return
    end

    local aim_pos = get_aim_position(target)

    if aim_pos == nil then
        return
    end

    safe_look_at(aim_pos)
end

local function activate_ability_now(combo_id, ability, hold_ms, target)
    local ok = safe_activate_ability(ability, hold_ms)

    if enable_failed_cast_retry and ok == false and failed_cast_retry_max > 0 then
        for i = 1, failed_cast_retry_max do
            schedule(combo_id, failed_cast_retry_delay_ms * i, function()
                if target_alive(target) then
                    aim_at_target(target)
                end

                safe_activate_ability(ability, hold_ms)
            end)
        end
    end

    return ok ~= false
end

local function wait_for_target_then_cast(combo_id, player, fallback_target, ability, range, opts, on_success, on_fail)
    opts = opts or {}

    local start_delay_ms = scaled_step_delay(opts.start_delay_ms or 0)
    local max_wait_ms = opts.max_wait_ms or 0
    local check_interval_ms = opts.check_interval_ms or target_check_interval_ms
    local require_ready = opts.require_ready == true
    local hold_ms = opts.hold_ms
    local target_finder = opts.target_finder
    local condition = opts.condition

    schedule(combo_id, start_delay_ms, function()
        local elapsed_ms = 0

        local function try_step()
            if not combo_is_current(combo_id) then
                return
            end

            player = get_local_player()
            fallback_target = nil

            if not valid_player(player) then
                if on_fail ~= nil then
                    on_fail()
                end

                return
            end

            local condition_ok = true

            if condition ~= nil and not condition(player, fallback_target) then
                condition_ok = false
            end

            local target = nil

            if condition_ok then
                if target_finder ~= nil then
                    target = target_finder(player, fallback_target)
                else
                    target = find_enemy_in_range(player, fallback_target, range)
                end
            end

            local ready_ok = true

            if require_ready and not ability_ready(ability) then
                ready_ok = false
            end

            if condition_ok and target ~= nil and ready_ok then
                aim_at_target(target)
                activate_ability_now(combo_id, ability, hold_ms, target)

                if on_success ~= nil then
                    on_success(target)
                end

                return
            end

            if elapsed_ms >= max_wait_ms then
                if on_fail ~= nil then
                    on_fail()
                end

                return
            end

            elapsed_ms = elapsed_ms + check_interval_ms

            schedule(combo_id, check_interval_ms, try_step)
        end

        try_step()
    end)
end

local function choose_next_route(player, fallback_target)
    if find_ability1_finisher_target(player, fallback_target) ~= nil then
        return route_ability1_finisher
    end

    if should_force_melee_for_crowd(player) then
        return route_melee_pair
    end

    if has_far_enemy(player, fallback_target) then
        return route_primary_throw
    end

    if has_single_enemy_in_ability1_bounce_range(player)
        and ability_ready(shield_bash)
        and ability_ready(secondary_attack) then
        return route_single_target
    end

    return route_melee_pair
end

local function get_switch_delay(previous_route, next_route)
    if previous_route == nil then
        return 0
    end

    if previous_route == route_single_target and next_route == route_melee_pair then
        return combo1_to_melee_delay_ms
    end

    if previous_route == route_single_target and next_route == route_primary_throw then
        return combo1_to_primary_delay_ms
    end

    if previous_route == route_single_target and next_route == route_single_target then
        return combo1_to_combo1_delay_ms
    end

    if previous_route == route_single_target and next_route == route_ability1_finisher then
        return combo1_to_finisher_delay_ms
    end

    if previous_route == route_melee_pair and next_route == route_melee_pair then
        return melee_pair_to_melee_pair_delay_ms
    end

    if previous_route == route_melee_pair and next_route == route_primary_throw then
        return melee_pair_to_primary_delay_ms
    end

    if previous_route == route_melee_pair and next_route == route_single_target then
        return melee_pair_to_combo1_delay_ms
    end

    if previous_route == route_melee_pair and next_route == route_ability1_finisher then
        return melee_pair_to_finisher_delay_ms
    end

    if previous_route == route_primary_throw and next_route == route_primary_throw then
        return primary_to_primary_recheck_delay_ms
    end

    if previous_route == route_primary_throw and next_route == route_melee_pair then
        return primary_to_melee_delay_ms
    end

    if previous_route == route_primary_throw and next_route == route_single_target then
        return primary_to_combo1_delay_ms
    end

    if previous_route == route_primary_throw and next_route == route_ability1_finisher then
        return primary_to_finisher_delay_ms
    end

    if previous_route == route_ability1_finisher and next_route == route_melee_pair then
        return finisher_to_melee_delay_ms
    end

    if previous_route == route_ability1_finisher and next_route == route_primary_throw then
        return finisher_to_primary_delay_ms
    end

    if previous_route == route_ability1_finisher and next_route == route_single_target then
        return finisher_to_combo1_delay_ms
    end

    if previous_route == route_ability1_finisher and next_route == route_ability1_finisher then
        return finisher_to_finisher_delay_ms
    end

    return 0
end

local run_primary_throw_combo
local run_route
local run_next_route

local function fallback_to_primary_throw_or_fail(combo_id, player, fallback_target, done)
    if has_far_enemy(player, fallback_target) then
        run_primary_throw_combo(combo_id, player, fallback_target, done)
        return
    end

    done(false, nil)
end

local function run_ability1_finisher_combo(combo_id, player, fallback_target, done)
    wait_for_target_then_cast(
        combo_id,
        player,
        fallback_target,
        shield_bash,
        ability1_finisher_range,
        {
            start_delay_ms = 0,
            max_wait_ms = finisher_ready_window_ms,
            check_interval_ms = target_check_interval_ms,
            require_ready = true,
            target_finder = find_ability1_finisher_target,
        },
        function()
            done(true, route_ability1_finisher)
        end,
        function()
            -- if the finisher disappeared during the small check window,
            -- continue the route loop instead of killing the whole combo.
            if has_enemy_in_combo_range(player, fallback_target) then
                done(true, route_ability1_finisher)
                return
            end

            done(false, nil)
        end
    )
end

local function run_melee_pair_combo(combo_id, player, fallback_target, done)
    -- start close, then decide whether to stay in melee or throw.
    wait_for_target_then_cast(
        combo_id,
        player,
        fallback_target,
        melee_attack,
        enemy_range,
        {
            start_delay_ms = 0,
            max_wait_ms = melee_target_window_ms,
            check_interval_ms = target_check_interval_ms,
            require_ready = false,
        },
        function()
            wait_for_target_then_cast(
                combo_id,
                player,
                fallback_target,
                melee_attack,
                enemy_range,
                {
                    start_delay_ms = melee1_to_melee2_delay_ms,
                    max_wait_ms = melee_target_window_ms,
                    check_interval_ms = target_check_interval_ms,
                    require_ready = false,
                },
                function()
                    done(true, route_melee_pair)
                end,
                function()
                    fallback_to_primary_throw_or_fail(combo_id, player, fallback_target, done)
                end
            )
        end,
        function()
            fallback_to_primary_throw_or_fail(combo_id, player, fallback_target, done)
        end
    )
end

run_primary_throw_combo = function(combo_id, player, fallback_target, done)
    wait_for_target_then_cast(
        combo_id,
        player,
        fallback_target,
        primary_attack,
        far_enemy_range,
        {
            start_delay_ms = 0,
            max_wait_ms = ability_ready_window_ms,
            check_interval_ms = target_check_interval_ms,
            require_ready = true,
            target_finder = find_far_enemy,
        },
        function()
            done(true, route_primary_throw)
        end,
        function()
            -- do not kill the loop just because primary is briefly unavailable.
            if has_far_enemy(player, fallback_target) then
                done(true, route_primary_throw)
                return
            end

            done(false, nil)
        end
    )
end

local function run_single_target_combo(combo_id, player, fallback_target, done)
    -- full single-target route.
    wait_for_target_then_cast(
        combo_id,
        player,
        fallback_target,
        melee_attack,
        enemy_range,
        {
            start_delay_ms = 0,
            max_wait_ms = melee_target_window_ms,
            check_interval_ms = target_check_interval_ms,
            require_ready = false,
        },
        function()
            wait_for_target_then_cast(
                combo_id,
                player,
                fallback_target,
                melee_attack,
                enemy_range,
                {
                    start_delay_ms = melee1_to_melee2_delay_ms,
                    max_wait_ms = melee_target_window_ms,
                    check_interval_ms = target_check_interval_ms,
                    require_ready = false,
                },
                function()
                    wait_for_target_then_cast(
                        combo_id,
                        player,
                        fallback_target,
                        primary_attack,
                        far_enemy_range,
                        {
                            start_delay_ms = melee2_to_primary_delay_ms,
                            max_wait_ms = far_target_window_ms,
                            check_interval_ms = target_check_interval_ms,
                            require_ready = false,
                        },
                        function()
                            wait_for_target_then_cast(
                                combo_id,
                                player,
                                fallback_target,
                                shield_bash,
                                far_enemy_range,
                                {
                                    start_delay_ms = primary_to_ability1_delay_ms,
                                    max_wait_ms = ability_ready_window_ms,
                                    check_interval_ms = target_check_interval_ms,
                                    require_ready = true,
                                    condition = function(p)
                                        return has_single_enemy_in_ability1_bounce_range(p)
                                    end,
                                },
                                function()
                                    wait_for_target_then_cast(
                                        combo_id,
                                        player,
                                        fallback_target,
                                        secondary_attack,
                                        far_enemy_range,
                                        {
                                            start_delay_ms = ability1_to_secondary_delay_ms,
                                            max_wait_ms = ability_ready_window_ms,
                                            check_interval_ms = target_check_interval_ms,
                                            require_ready = true,
                                        },
                                        function()
                                            wait_for_target_then_cast(
                                                combo_id,
                                                player,
                                                fallback_target,
                                                melee_attack,
                                                enemy_range,
                                                {
                                                    start_delay_ms = melee1_to_melee2_delay_ms,
                                                    max_wait_ms = melee_target_window_ms,
                                                    check_interval_ms = target_check_interval_ms,
                                                    require_ready = false,
                                                },
                                                function()
                                                    wait_for_target_then_cast(
                                                        combo_id,
                                                        player,
                                                        fallback_target,
                                                        melee_attack,
                                                        enemy_range,
                                                        {
                                                            start_delay_ms = melee1_to_melee2_delay_ms,
                                                            max_wait_ms = melee_target_window_ms,
                                                            check_interval_ms = target_check_interval_ms,
                                                            require_ready = false,
                                                        },
                                                        function()
                                                            done(true, route_single_target)
                                                        end,
                                                        function()
                                                            fallback_to_primary_throw_or_fail(combo_id, player, fallback_target, done)
                                                        end
                                                    )
                                                end,
                                                function()
                                                    fallback_to_primary_throw_or_fail(combo_id, player, fallback_target, done)
                                                end
                                            )
                                        end,
                                        function()
                                            done(false, nil)
                                        end
                                    )
                                end,
                                function()
                                    done(false, nil)
                                end
                            )
                        end,
                        function()
                            done(false, nil)
                        end
                    )
                end,
                function()
                    fallback_to_primary_throw_or_fail(combo_id, player, fallback_target, done)
                end
            )
        end,
        function()
            fallback_to_primary_throw_or_fail(combo_id, player, fallback_target, done)
        end
    )
end

run_route = function(route, combo_id, player, fallback_target, done)
    if route == route_ability1_finisher then
        run_ability1_finisher_combo(combo_id, player, fallback_target, done)
        return
    end

    if route == route_single_target then
        run_single_target_combo(combo_id, player, fallback_target, done)
        return
    end

    if route == route_primary_throw then
        run_primary_throw_combo(combo_id, player, fallback_target, done)
        return
    end

    run_melee_pair_combo(combo_id, player, fallback_target, done)
end

run_next_route = function(combo_id, player, fallback_target, previous_route)
    if not combo_is_current(combo_id) then
        return
    end

    player = get_local_player()
    fallback_target = nil

    if not valid_player(player) then
        stop_combo(combo_id)
        return
    end

    if not has_enemy_in_combo_range(player, fallback_target) then
        stop_combo(combo_id)
        return
    end

    local elapsed_ms = 0

    local function poll_route_switch()
        if not combo_is_current(combo_id) then
            return
        end

        player = get_local_player()
        fallback_target = nil

        if not valid_player(player) then
            stop_combo(combo_id)
            return
        end

        if not has_enemy_in_combo_range(player, fallback_target) then
            stop_combo(combo_id)
            return
        end

        local next_route = choose_next_route(player, fallback_target)
        local base_delay_ms = get_switch_delay(previous_route, next_route)
        local required_delay_ms = scaled_route_delay(base_delay_ms)

        if elapsed_ms >= required_delay_ms or elapsed_ms >= route_switch_max_wait_ms then
            run_route(next_route, combo_id, player, fallback_target, function(completed, completed_route)
                if not combo_is_current(combo_id) then
                    return
                end

                if not completed then
                    stop_combo(combo_id)
                    return
                end

                run_next_route(combo_id, player, fallback_target, completed_route or next_route)
            end)

            return
        end

        elapsed_ms = elapsed_ms + route_switch_check_interval_ms

        schedule(combo_id, route_switch_check_interval_ms, poll_route_switch)
    end

    poll_route_switch()
end

function on_activate_combo(ctx)
    local combo_id = start_new_combo()
    local player = get_local_player()
    local fallback_target = nil

    if not valid_player(player) then
        stop_combo(combo_id)
        return false
    end

    if not has_enemy_in_combo_range(player, fallback_target) then
        stop_combo(combo_id)
        return false
    end

    run_next_route(combo_id, player, fallback_target, nil)

    return true
end

function on_deactivate_combo(ctx)
    active_combo_id = active_combo_id + 1
end

]],
}

MODULE_DEFS[#MODULE_DEFS + 1] = {
    name = "Cyclops Melee",
    kind = "combo",
    source = [[
local PRIMARY   = Enum.AbilityType.PrimaryAttack
local SECONDARY = Enum.AbilityType.SecondaryAttack
local ABILITY1  = Enum.AbilityType.Ability1
local MELEE     = Enum.AbilityType.MeleeAttack

local DELAY_MS              = 200
local DELAY_2_MS            = 400
local DELAY_2_ABILITY1_MS   = 10
local DELAY_3_MS            = 475
local CLOSE_RANGE_M         = 3
local CLOSE_WEAVE_DELAY_MS  = DELAY_MS
local RANGE_POLL_MS         = 5

local combo_running = false

local function valid_enemy(enemy)
    return enemy
        and enemy:is_valid()
        and not enemy.is_dead
        and enemy:is_enemy()
end

local function enemy_within_close_range(player)
    if not player or not player.location then return false end

    local enemies = object_manager.get_players(true)
    if type(enemies) ~= "table" then return false end

    for _, enemy in ipairs(enemies) do
        if valid_enemy(enemy) and enemy.location then
            local distance = player.location:get_distance_to_meters(enemy.location)
            if distance <= CLOSE_RANGE_M then
                return true
            end
        end
    end

    return false
end

local function primary_ready()
    return ability_manager:can_activate_ability(PRIMARY)
end

local function ability1_ready()
    return ability_manager:can_activate_ability(ABILITY1)
end

local function run_close_range_with_ability1(player)
    if not primary_ready() then
        return true
    end

    ability_manager:activate_ability(PRIMARY)
    wait(CLOSE_WEAVE_DELAY_MS)

    if ability1_ready() and enemy_within_close_range(player) then
        ability_manager:activate_ability(ABILITY1)
        wait(CLOSE_WEAVE_DELAY_MS)

        if primary_ready() and enemy_within_close_range(player) then
            ability_manager:activate_ability(PRIMARY)
            wait(CLOSE_WEAVE_DELAY_MS)

            if primary_ready() and enemy_within_close_range(player) then
                ability_manager:activate_ability(MELEE)
            end
        end
    end

    return true
end

local function run_close_range_without_ability1(player)
    if not primary_ready() then
        return true
    end

    ability_manager:activate_ability(PRIMARY)
    wait(CLOSE_WEAVE_DELAY_MS)

    if primary_ready() and enemy_within_close_range(player) then
        ability_manager:activate_ability(MELEE)
        wait(CLOSE_WEAVE_DELAY_MS)

        if primary_ready() and enemy_within_close_range(player) then
            ability_manager:activate_ability(PRIMARY)
        end
    end

    return true
end

local function interrupt_if_close(player)
    if not enemy_within_close_range(player) then return false end

    if ability1_ready() then
        return run_close_range_with_ability1(player)
    end

    return run_close_range_without_ability1(player)
end

local function continue_weave_if_close_after_primary(player, elapsed_ms, duration_ms)
    if not enemy_within_close_range(player) then return false end

    local remaining_ms = duration_ms - elapsed_ms

    if remaining_ms > 0 then
        wait(remaining_ms)
    end

    if ability1_ready() and enemy_within_close_range(player) then
        ability_manager:activate_ability(ABILITY1)
        wait(CLOSE_WEAVE_DELAY_MS)

        if primary_ready() and enemy_within_close_range(player) then
            ability_manager:activate_ability(PRIMARY)
            wait(CLOSE_WEAVE_DELAY_MS)

            if primary_ready() and enemy_within_close_range(player) then
                ability_manager:activate_ability(MELEE)
            end
        end
    elseif primary_ready() and enemy_within_close_range(player) then
        ability_manager:activate_ability(MELEE)
        wait(CLOSE_WEAVE_DELAY_MS)

        if primary_ready() and enemy_within_close_range(player) then
            ability_manager:activate_ability(PRIMARY)
        end
    end

    return true
end

local function interruptible_wait(player, duration_ms, on_close)
    local elapsed = 0
    local close_handler = on_close or interrupt_if_close

    while elapsed < duration_ms do
        if close_handler(player, elapsed, duration_ms) then
            return true
        end

        local step = math.min(RANGE_POLL_MS, duration_ms - elapsed)
        wait(step)
        elapsed = elapsed + step
    end

    return close_handler(player, elapsed, duration_ms)
end

function on_activate_combo(ctx)
    if combo_running then
        return true
    end

    combo_running = true

    local function finish(result)
        combo_running = false
        return result
    end

    local player = ctx and ctx.player or object_manager.get_local_player()
    local use_ability1 = ability_manager:can_activate_ability(ABILITY1)

    if interrupt_if_close(player) then
        return finish(true)
    end

    if not primary_ready() then
        return finish(false)
    end

    ability_manager:activate_ability(PRIMARY)

    if interruptible_wait(player, DELAY_MS, continue_weave_if_close_after_primary) then
        return finish(true)
    end

    ability_manager:activate_ability(SECONDARY)

    if use_ability1 then
        if interruptible_wait(player, DELAY_2_ABILITY1_MS) then return finish(true) end
        ability_manager:activate_ability(ABILITY1)
        if interruptible_wait(player, DELAY_3_MS) then return finish(true) end
    else
        if interruptible_wait(player, DELAY_2_MS) then return finish(true) end
    end

    ability_manager:activate_ability(PRIMARY)

    return finish(true)
end

]],
}

MODULE_DEFS[#MODULE_DEFS + 1] = {
    name = "Cnd Auto Bubble",
    kind = "scanner",
    source = [[
-- end stop guard
local __route_end_stop_signal = "__route_end_stop_signal"
local __route_raw_wait = wait
local function __route_end_pressed()
    return input and input.is_key_down and input.is_key_down(35) == true
end
local function __route_release_combo_inputs()
    if not input or not input.release_key then return end
    pcall(function() input.release_key(Enum.MouseButton.Left) end)
    pcall(function() input.release_key(Enum.MouseButton.Right) end)
    pcall(function() input.release_key(Enum.Key.Space) end)
    pcall(function() input.release_key(Enum.Key.W) end)
    pcall(function() input.release_key(Enum.Key.A) end)
    pcall(function() input.release_key(Enum.Key.S) end)
    pcall(function() input.release_key(Enum.Key.D) end)
end
local function wait(ms)
    if __route_end_pressed() then
        __route_release_combo_inputs()
        error(__route_end_stop_signal, 0)
    end
    __route_raw_wait(ms)
    if __route_end_pressed() then
        __route_release_combo_inputs()
        error(__route_end_stop_signal, 0)
    end
end

local END_KEY = 35

settings = {
    { key = "hp_thresh", label = "HP Threshold", default = 125, min = 1, max = 275 },
    { key = "ignore_shield", label = "Ignore Shield", default = false },
    { key = "scan_ms", label = "Scan MS", default = 50, min = 10, max = 500 },
}

local scan_active = false
local scanner_id = nil
local scan_busy = false
local triggered = false

local function num(key, fallback)
    local value = script.get_setting(key)
    if type(value) ~= "number" then return fallback end
    return math.floor(value)
end

local function scan_once(ctx)
    if scan_busy then return false end
    scan_busy = true

    ctx = ctx or {}
    local p = ctx.player or object_manager.get_local_player()
    if not p or not p:is_valid() or p.is_dead then triggered = false scan_busy = false return false end

    local hp = (p.health or 0) + (script.get_setting("ignore_shield") and 0 or (p.shield or 0))
    if hp >= num("hp_thresh", 125) then triggered = false scan_busy = false return false end

    local sec = p:get_ability(Enum.AbilityType.SecondaryAttack)
    if not sec or sec.on_cooldown or (sec.cooldown_remaining and sec.cooldown_remaining > 0) then triggered = false scan_busy = false return false end
    if triggered then scan_busy = false return false end

    triggered = true

    local rot = camera.get_rotation()
    camera.set_rotation(-90, rot.yaw)
    wait(100)
    ability_manager:activate_ability(Enum.AbilityType.SecondaryAttack)
    wait(160)
    camera.set_rotation(rot.pitch, rot.yaw)

    scan_busy = false
    return true
end

local function start_scanner()
    if scanner_id then return true end

    scanner_id = timer.set_interval(function()
        if input.is_key_down(END_KEY) then
            scan_active = false
            return
        end

        if scan_active then
            scan_once(nil)
        end
    end, num("scan_ms", 50))

    return true
end

local function __route_original_on_activate_combo(ctx)
    start_scanner()
    scan_active = true
    scan_once(ctx)
    return true
end

function on_deactivate_combo(ctx)
    -- End key stops the scanner.
end

start_scanner()


local __route_wrapped_on_activate_combo = __route_original_on_activate_combo
function on_activate_combo(ctx)
    if __route_end_pressed() then
        __route_release_combo_inputs()
        return false
    end

    local ok, result = pcall(__route_wrapped_on_activate_combo, ctx)
    if not ok then
        if result == __route_end_stop_signal or tostring(result) == __route_end_stop_signal then
            __route_release_combo_inputs()
            return false
        end
        error(result)
    end

    return result
end

]],
}

MODULE_DEFS[#MODULE_DEFS + 1] = {
    name = "Dino Melee",
    kind = "scanner",
    source = [[
-- end stop guard
local __route_end_stop_signal = "__route_end_stop_signal"
local __route_raw_wait = wait
local function __route_end_pressed()
    return input and input.is_key_down and input.is_key_down(35) == true
end
local function __route_release_combo_inputs()
    if not input or not input.release_key then return end
    pcall(function() input.release_key(Enum.MouseButton.Left) end)
    pcall(function() input.release_key(Enum.MouseButton.Right) end)
    pcall(function() input.release_key(Enum.Key.Space) end)
    pcall(function() input.release_key(Enum.Key.W) end)
    pcall(function() input.release_key(Enum.Key.A) end)
    pcall(function() input.release_key(Enum.Key.S) end)
    pcall(function() input.release_key(Enum.Key.D) end)
end
local function wait(ms)
    if __route_end_pressed() then
        __route_release_combo_inputs()
        error(__route_end_stop_signal, 0)
    end
    __route_raw_wait(ms)
    if __route_end_pressed() then
        __route_release_combo_inputs()
        error(__route_end_stop_signal, 0)
    end
end

local END_KEY = 35
local KEY_V = Enum.Key.V

settings = {
    { key="range_m", label="Trigger Range (m)", default=5, min=1, max=20 },
    { key="v_hold", label="V Hold MS", default=5, min=1, max=300 },
    { key="scan_ms", label="Scan MS", default=50, min=10, max=500 },
}

local scan_active = false
local scanner_id = nil

local function ms(key, fallback)
    local value = script.get_setting(key)
    if type(value) ~= "number" then return fallback end
    return math.floor(value)
end

local function valid_player(p)
    return p and p:is_valid() and not p.is_dead
end

local function valid_enemy(t)
    return t and t:is_valid() and not t.is_dead and t:is_enemy()
end

local function distance_m(a, b)
    if not a or not b or not a.location or not b.location then return math.huge end
    return a.location:get_distance_to(b.location) * 0.01
end

local function find_enemy_in_range(p)
    local enemies = object_manager.get_players(true)
    if not enemies then return nil end

    local best = nil
    local best_dist = math.huge
    local range = ms("range_m", 5)

    for i = 1, #enemies do
        local enemy = enemies[i]
        local d = distance_m(p, enemy)

        if valid_enemy(enemy) and d <= range and d < best_dist then
            best = enemy
            best_dist = d
        end
    end

    return best
end

local function scan_once(ctx)
    ctx = ctx or {}
    local p = ctx.player or object_manager.get_local_player()
    local t = ctx.target or find_enemy_in_range(p)

    if not valid_player(p) then return false end
    if not valid_enemy(t) then return false end
    if distance_m(p, t) > ms("range_m", 5) then return false end

    input.send_key(KEY_V, ms("v_hold", 5))
    return true
end

local function start_scanner()
    if scanner_id then return true end

    scanner_id = timer.set_interval(function()
        if input.is_key_down(END_KEY) then
            scan_active = false
            return
        end

        if scan_active then
            scan_once(nil)
        end
    end, ms("scan_ms", 50))

    return true
end

local function __route_original_on_activate_combo(ctx)
    start_scanner()
    scan_active = true
    scan_once(ctx)
    return true
end

function on_deactivate_combo(ctx)
    -- End key stops the scanner.
end

start_scanner()


local __route_wrapped_on_activate_combo = __route_original_on_activate_combo
function on_activate_combo(ctx)
    if __route_end_pressed() then
        __route_release_combo_inputs()
        return false
    end

    local ok, result = pcall(__route_wrapped_on_activate_combo, ctx)
    if not ok then
        if result == __route_end_stop_signal or tostring(result) == __route_end_stop_signal then
            __route_release_combo_inputs()
            return false
        end
        error(result)
    end

    return result
end

]],
}

MODULE_DEFS[#MODULE_DEFS + 1] = {
    name = "DpsPool",
    kind = "combo",
    source = [[
-- end stop guard
local __route_end_stop_signal = "__route_end_stop_signal"
local __route_raw_wait = wait
local function __route_end_pressed()
    return input and input.is_key_down and input.is_key_down(35) == true
end
local function __route_release_combo_inputs()
    if not input or not input.release_key then return end
    pcall(function() input.release_key(Enum.MouseButton.Left) end)
    pcall(function() input.release_key(Enum.MouseButton.Right) end)
    pcall(function() input.release_key(Enum.Key.Space) end)
    pcall(function() input.release_key(Enum.Key.W) end)
    pcall(function() input.release_key(Enum.Key.A) end)
    pcall(function() input.release_key(Enum.Key.S) end)
    pcall(function() input.release_key(Enum.Key.D) end)
end
local function wait(ms)
    if __route_end_pressed() then
        __route_release_combo_inputs()
        error(__route_end_stop_signal, 0)
    end
    __route_raw_wait(ms)
    if __route_end_pressed() then
        __route_release_combo_inputs()
        error(__route_end_stop_signal, 0)
    end
end

settings = {
    { key="combo_range", label="Combo Range (m)", default=30, min=1, max=100 },
    { key="aim_fov", label="Aim FOV", default=30, min=1, max=360 },
    { key="flick_dur", label="Flick Duration (ms)", default=125, min=1, max=5000 },
    { key="input_aim_ms", label="Input Aim MS", default=80, min=1, max=1000 },
    { key="aim_min_ms", label="Aim Min MS", default=80, min=1, max=5000 },
    { key="aim_max_ms", label="Aim Max MS", default=350, min=1, max=5000 },
    { key="post_aim_wait", label="Post Aim Wait MS", default=10, min=0, max=500 },
    { key="tap_hold_ms", label="Input Hold MS", default=5, min=1, max=1000 },
    { key="prefer_ability_manager", label="Prefer Ability Manager", default=true },
    { key="ignore_shield", label="Ignore Shield", default=false },
    { key="cancel_aiming_away", label="Cancel Aiming Away", default=false },
    { key="combo_range", label="Combo Range (m)", default=11, min=1, max=60 },
    { key="close_range", label="Jump At Range (m)", default=3, min=1, max=20 },
}

-- SDK-format combo script
-- Uses Elsa-style flickbot aim-to-target helper + new input functions.

local PRIMARY   = Enum.AbilityType.PrimaryAttack
local SECONDARY = Enum.AbilityType.SecondaryAttack
local ABILITY1  = Enum.AbilityType.Ability1
local ABILITY2  = Enum.AbilityType.Ability2
local ABILITY3  = Enum.AbilityType.Ability3
local MELEE     = Enum.AbilityType.Melee
local JUMP      = Enum.AbilityType.Jump

local KEY_PRIMARY   = Enum.MouseButton.Left
local KEY_SECONDARY = Enum.MouseButton.Right
local KEY_E         = Enum.Key.E
local KEY_SHIFT     = Enum.Key.LeftShift
local KEY_F         = Enum.Key.F
local KEY_V         = Enum.Key.V
local KEY_C         = Enum.Key.C
local KEY_SPACE     = Enum.Key.Space

local function ms(key, fallback)
    local value = script.get_setting(key)
    if type(value) ~= "number" then return fallback end
    return math.floor(value)
end

local function bool(key, fallback)
    local value = script.get_setting(key)
    if value == nil then return fallback end
    return value == true
end

local function dist(player, target)
    if not player or not target or not player.location or not target.location then return math.huge end
    return player.location:get_distance_to(target.location) * 0.01
end

local function valid_player(player)
    return player and player:is_valid() and not player.is_dead
end

local function valid_enemy(target)
    return target and target:is_valid() and not target.is_dead and target:is_enemy()
end

local function in_range(player, target, range)
    return dist(player, target) <= range
end

local function hp_pct(unit, include_shield)
    if not unit then return 100 end
    local hp = unit.health or 0
    if include_shield then hp = hp + (unit.shield or 0) end
    local max_hp = unit.max_health or 0
    if max_hp <= 0 then return 100 end
    return (hp / max_hp) * 100
end

local flick_cfg = {
    use_prediction = false,
    cancel_aiming_away = false,
    always_fire = false,
    duration = 125,
    aim_points = { Enum.AimPoint.Head }
}

local target_cfg = {
    aim_fov = 30.0,
    dynamic_fov = true,
    ignore_invisible = true,
    ignore_shield = false,
    ignore_team = true,
    ignore_enemy = false,
    max_distance = 30
}

local function get_aim_duration(player, target, min_duration, max_duration)
    if not player or not target then return min_duration end
    local angle_diff = math.abs(target:get_fov_to_target())
    local distance = player.location:get_distance_to(target.location)
    local angle_factor = math.sqrt(math.max(0, math.min(angle_diff / 90, 1)))
    local dist_factor = math.max(0, math.min(distance / 3000, 1))
    local t = (angle_factor * 0.7) + (dist_factor * 0.3)
    local duration = min_duration + (max_duration - min_duration) * t
    duration = duration + math.random(-20, 40)
    return math.max(min_duration, math.min(duration, max_duration))
end

local function set_aim_points(ability)
    flick_cfg.aim_points = { Enum.AimPoint.Head }
end

local function flick_cast(target, ability, aim_time, wait_mode, always_fire)
    if not target or target.is_dead then return false end

    if flickbot and flickbot.perform then
        -- Same flickbot aim BlackPanther's multi-mark sequence uses (fast/sticky/strong)
        -- instead of a plain camera.look_at.
        local multi_flick_cfg = {
            use_prediction = false,
            cancel_aiming_away = false,
            always_fire = always_fire == true,
            duration = 300, -- Stickier duration
            aim_points = { Enum.AimPoint.Head, Enum.AimPoint.Neck },
        }

        local multi_target_cfg = {
            aim_fov = 360,
            dynamic_fov = true,
            ignore_invisible = true,
            ignore_shield = false,
            ignore_team = true,
            ignore_enemy = false,
            max_distance = ms("combo_range", 30)
        }

        flickbot.perform(target, ability, multi_flick_cfg, multi_target_cfg, wait_mode or Enum.AbilityWait.None)
        return true
    end

    return false
end

local function tap_input(key, hold_ms)
    input.send_key(key, hold_ms or ms("tap_hold_ms", 5))
end

local function aim_then_input(target, ability, key, hold_ms, wait_mode)
    flick_cast(target, ability, ms("input_aim_ms", 80), wait_mode or Enum.AbilityWait.None, false)
    wait(ms("post_aim_wait", 10))
    tap_input(key, hold_ms or ms("tap_hold_ms", 5))
end

local function activate_or_input(player, target, ability, key, hold_ms)
    if bool("prefer_ability_manager", true) then
        flick_cast(target, ability, get_aim_duration(player, target, ms("aim_min_ms", 80), ms("aim_max_ms", 350)), Enum.AbilityWait.None, false)
        ability_manager:activate_ability(ability, hold_ms or ms("tap_hold_ms", 5))
    else
        aim_then_input(target, ability, key, hold_ms or ms("tap_hold_ms", 5))
    end
    return true
end

local DEADPOOL_HERO_ID = 1057

local GUN_RMB_RANGE = 50
local AB1_RANGE     = 5
local SHIFT_RANGE   = 10
local WAIT_GUN_MS   = 200

local function alive(p)
    return p and p.is_valid and p:is_valid() and not p.is_dead and p.location
end

local function get_hero_id(p)
    if not p then return nil end
    if p.get_hero_id then
        local ok, id = pcall(function() return p:get_hero_id() end)
        if ok and id then return id end
    end
    return p.hero_id
end

local function is_deadpool(p)
    return get_hero_id(p) == DEADPOOL_HERO_ID
end

local function dist_m(a, b)
    if not alive(a) or not alive(b) then return math.huge end

    if a.location.get_distance_to_meters then
        local ok, d = pcall(function() return a.location:get_distance_to_meters(b.location) end)
        if ok and type(d) == "number" then return d end
    end

    if a.location.get_distance_to then
        local ok, d = pcall(function() return a.location:get_distance_to(b.location) * 0.01 end)
        if ok and type(d) == "number" then return d end
    end

    return math.huge
end

local function fov_to(e)
    if e and e.get_fov_to_target then
        local ok, f = pcall(function() return math.abs(e:get_fov_to_target()) end)
        if ok and type(f) == "number" then return f end
    end
    return 9999
end

local function enemy_ok(e)
    return alive(e) and (not e.is_enemy or e:is_enemy())
end

local function nearest_enemy_by_fov(p, range)
    local list = object_manager and object_manager.get_players and object_manager.get_players(true)
    if type(list) ~= "table" then return nil end

    local best = nil
    local best_fov = math.huge
    local best_dist = math.huge

    for _, e in next, list do
        if enemy_ok(e) then
            local d = dist_m(p, e)
            if d <= range then
                local f = fov_to(e)
                if f < best_fov or (f == best_fov and d < best_dist) then
                    best = e
                    best_fov = f
                    best_dist = d
                end
            end
        end
    end

    return best
end

local function can_activate(a)
    if ability_manager and ability_manager.can_activate_ability then
        local ok, ready = pcall(function() return ability_manager:can_activate_ability(a) end)
        if ok then return ready == true end
    end

    local p = object_manager and object_manager.get_local_player and object_manager.get_local_player()
    local ab = p and p.get_ability and p:get_ability(a)
    if not ab then return false end
    if ab.on_cooldown then return false end
    if ab.cooldown_remaining and ab.cooldown_remaining > 0 then return false end
    if ab.is_activated then return false end
    if ab.can_activate then
        local ok, ready = pcall(function() return ab:can_activate() end)
        if ok then return ready == true end
    end
    return true
end

local function is_guns_out()
    return can_activate(PRIMARY)
       and can_activate(SECONDARY)
end

local function is_swords_out()
    return not can_activate(PRIMARY)
       and not can_activate(SECONDARY)
end

local function try_ab1_close(p)
    local e = nearest_enemy_by_fov(p, AB1_RANGE)
    if e and can_activate(ABILITY1) then
        activate_or_input(p, e, ABILITY1, KEY_E, ms("tap_hold_ms", 5))
        return true
    end
    return false
end

local function guns_combo(p)
    if not can_activate(SECONDARY) then return false end

    local e = nearest_enemy_by_fov(p, GUN_RMB_RANGE)
    if not e then return false end

    activate_or_input(p, e, SECONDARY, KEY_SECONDARY, ms("tap_hold_ms", 5))
    wait(WAIT_GUN_MS)

    try_ab1_close(p)
    wait(WAIT_GUN_MS)

    local shift_target = nearest_enemy_by_fov(p, SHIFT_RANGE)
    if shift_target and can_activate(ABILITY2) then
        activate_or_input(p, shift_target, ABILITY2, KEY_SHIFT, ms("tap_hold_ms", 5))
    end

    return true
end

local function __route_original_on_activate_combo(ctx)
    local p,t=ctx.player,ctx.target
    if not alive(p) or not is_deadpool(p) then return false end

    if is_swords_out() then
        if not valid_player(p) or not valid_enemy(t) then return false end
        if not in_range(p,t,ms("combo_range",11)) then return false end
        activate_or_input(p,t,SECONDARY,KEY_SECONDARY,2); wait(5)
        if can_activate(ABILITY1) then
            activate_or_input(p,t,ABILITY1,KEY_E,ms("tap_hold_ms",5))
        end
        if not in_range(p,t,ms("close_range",3)) then return true end
        input.send_key(KEY_SPACE,5); wait(5); input.send_key(KEY_SPACE,5)
        return true
    end

    if is_guns_out() then
        return guns_combo(p)
    end

    return false
end


local __route_wrapped_on_activate_combo = __route_original_on_activate_combo
function on_activate_combo(ctx)
    if __route_end_pressed() then
        __route_release_combo_inputs()
        return false
    end

    local ok, result = pcall(__route_wrapped_on_activate_combo, ctx)
    if not ok then
        if result == __route_end_stop_signal or tostring(result) == __route_end_stop_signal then
            __route_release_combo_inputs()
            return false
        end
        error(result)
    end

    return result
end

]],
}

MODULE_DEFS[#MODULE_DEFS + 1] = {
    name = "Ultimate Cancels",
    kind = "scanner",
    source = [[
settings = {
    {
        key = "fov",
        label = "FOV",
        tooltip = "Maximum angle from your crosshair where enemy ultimates can be detected.",
        default = 360,
        min = 1,
        max = 360
    },

    {
        key = "wait_ms",
        label = "Cast Delay",
        tooltip = "Delay before the interrupt action fires.",
        default = 250,
        min = 0,
        max = 1000
    },

    {
        key = "mantis_raise",
        label = "Mantis Raise Aim",
        tooltip = "Moves the mouse upward before casting Mantis sleep.",
        default = 12,
        min = 0,
        max = 60
    },

    {
        key = "ultimate_cancel_route",
        label = "Ultimate Cancel Route",
        tooltip = "Uses stun/cancel abilities against enemy ultimates.",
        default = true
    },

    {
        key = "cc_shield_block_route",
        label = "CC Shield Block Route",
        tooltip = "Uses shield/block abilities against selected enemy CC abilities.",
        default = true
    },

    { key = "peni_enabled", label = "Peni On/Off", default = true },
    { key = "luna_enabled", label = "Luna On/Off", default = true },
    { key = "fox_enabled", label = "Fox On/Off", default = true },
    { key = "spidey_enabled", label = "Spidey On/Off", default = true },
    { key = "hulk_enabled", label = "Hulk On/Off", default = true },
    { key = "emma_enabled", label = "Emma On/Off", default = true },
    { key = "rogue_enabled", label = "Rogue On/Off", default = true },
    { key = "winter_enabled", label = "Winter On/Off", default = true },
    { key = "mantis_enabled", label = "Mantis On/Off", default = true },
    { key = "invisible_woman_enabled", label = "Invisible Woman On/Off", default = true },
}

local ROUTE_KIND = "ultimate"
local A = Enum.AbilityType
local CAPTAIN_AMERICA_ID = 1022

local SCAN_MS = script.get_setting("scan_poll_ms") or 100
local END_KEY = 35
local TRIGGER_COOLDOWN_MS = 1500
local TARGET_LOCK_MS = 700
local CAP_BLOCK_RANGE = 35
local BLOCK_RELEASE_BUFFER_MS = 200

local wanted_ults = {
    [103851] = "Scarlet Witch",
    [101871] = "Doctor Strange",
    [104271] = "Peni Parker",
    [103651] = "Spider-Man",
    [1036510] = "Spider-Man",
    [1036800] = "Spider-Man",
    [102671] = "Black Panther",
    [105561] = "Daredevil",
    [106561] = "Rogue",
    [104341] = "Star-Lord",
    [101761] = "Human Torch",
    [103461] = "Iron Man",
    [102181] = "Hawkeye",
}

local heroes = {
    [1042] = { n = "Peni",   kind = "flick",  a = A.SecondaryAttack, r = 60, setting = "peni_enabled" },
    [1031] = { n = "Luna",   kind = "flick",  a = A.SecondaryAttack, r = 60, setting = "luna_enabled" },
    [1060] = { n = "Fox",    kind = "flick",  a = A.SecondaryAttack, r = 60, setting = "fox_enabled" },
    [1036] = { n = "Spidey", kind = "flick",  a = A.Ability1, r = 30, setting = "spidey_enabled" },
    [1038] = { n = "Scarlet", kind = "flick", a = A.Ability1, r = 30 },
    [1011] = { n = "Hulk",   kind = "flick",  a = A.Ability1, r = 18, setting = "hulk_enabled" },
    [1053] = { n = "Emma",   kind = "emma", r = 6, setting = "emma_enabled" },
    [1065] = { n = "Rogue",  kind = "rogue", r = 8, setting = "rogue_enabled" },
    [1041] = { n = "Winter", kind = "winter", r = 22, setting = "winter_enabled" },
    [1020] = { n = "Mantis", kind = "mantis", r = 18, setting = "mantis_enabled" },
    [1050] = { n = "Invisible Woman", kind = "invisible_push", a = A.Ability1, r = 15, setting = "invisible_woman_enabled" },
}

local names = {
    ["luna"] = heroes[1031], ["luna snow"] = heroes[1031],
    ["peni"] = heroes[1042], ["peni parker"] = heroes[1042],
    ["white fox"] = heroes[1060], ["spider-man"] = heroes[1036],
    ["spiderman"] = heroes[1036], ["spider man"] = heroes[1036],
    ["scarlet witch"] = heroes[1038], ["scarlet"] = heroes[1038],
    ["hulk"] = heroes[1011],
    ["emma"] = heroes[1053], ["emma frost"] = heroes[1053],
    ["rogue"] = heroes[1065], ["winter soldier"] = heroes[1041],
    ["mantis"] = heroes[1020],
    ["invisible woman"] = heroes[1050], ["invisible"] = heroes[1050],
}

local active = false
local busy = false
local timer_id = nil
local last_hit = 0
local cap_blocking = false
local cap_block_target = nil
local cap_block_action = nil
local cap_block_ability = nil
local cap_block_ability_id = nil
local cap_block_release_at = 0
local locked_target = nil
local locked_name = nil
local locked_id = nil
local locked_until = 0

local keys = {
    [A.Ability1] = Enum.Key and Enum.Key.E or "E",
    [A.Ability2] = Enum.Key and Enum.Key.LeftShift or "Shift",
    [A.Ability3] = Enum.Key and Enum.Key.F or "F",
    [A.SecondaryAttack] = Enum.MouseButton and Enum.MouseButton.Right or "RButton",
    [A.PrimaryAttack] = Enum.MouseButton and Enum.MouseButton.Left or "LButton",
}

local function ms()
    return math.floor(os.clock() * 1000)
end

local function cfg(k, d)
    if script and script.get_setting then
        local v = script.get_setting(k)
        if type(v) == "number" or type(v) == "boolean" then return v end
    end
    return d
end

local function ultimate_cancel_enabled()
    if ROUTE_KIND == "cc" then return false end
    -- Ultimate Cancels Test replaces this path entirely when it's on.
    if script.get_setting("ultimate_cancels_test_enabled") == true then return false end
    local value = cfg("ultimate_cancel_route", nil)
    if value ~= nil then return value == true end
    return true
end

local function cc_shield_block_enabled()
    if ROUTE_KIND == "ultimate" then return false end
    local value = cfg("cc_shield_block_route", nil)
    if value ~= nil then return value == true end
    value = cfg("cap_shield_block", nil)
    if value ~= nil then return value == true end
    return cfg("cap_secondary_block", true) == true
end

local function sleep(ms_value)
    if wait then pcall(function() wait(ms_value) end) end
end

local function alive(p)
    return p and p.is_valid and p:is_valid() and not p.is_dead and p.location
end

local function hero_id(p)
    if not p then return nil end
    if p.get_hero_id then
        local ok, id = pcall(function() return p:get_hero_id() end)
        if ok and id then return id end
    end
    return p.hero_id
end

local function hero_name(p)
    return tostring((p and (p.hero_name or p.name)) or "unknown")
end

local function my_action(p)
    local id = hero_id(p)
    local act = heroes[id] or names[string.lower(hero_name(p))]
    if act and act.setting and cfg(act.setting, true) ~= true then return nil, id end
    return act, id
end

local function dist(a, b)
    if not alive(a) or not alive(b) then return math.huge end
    if a.location.get_distance_to_meters then
        return a.location:get_distance_to_meters(b.location)
    end
    return a.location:get_distance_to(b.location) * 0.01
end

local function has_line_of_sight(unit)
    if not alive(unit) then return false end

    if unit.is_visible then
        local ok, visible = pcall(function()
            return unit:is_visible()
        end)

        if ok and visible == true then return true end
    end

    if unit.has_line_of_sight then
        local ok, los = pcall(function()
            return unit:has_line_of_sight()
        end)

        if ok and los == true then return true end
    end

    return false
end

local function ability_id(ab)
    if not ab or not ab.get_id then return nil end
    local ok, id = pcall(function() return ab:get_id() end)
    if ok then return id end
end

local function ability_type(ab)
    if not ab or not ab.get_type then return nil end
    local ok, t = pcall(function() return ab:get_type() end)
    if ok then return t end
end

local function ability_enum_to_type(ability_enum)
    if ability_enum == A.SecondaryAttack then return 12 end
    if ability_enum == A.Ability1 then return 16 end
    if ability_enum == A.Ability2 then return 17 end
    if ability_enum == A.Ability3 then return 21 end
    if ability_enum == A.PrimaryAttack then return 11 end
    if ability_enum == A.MeleeAttack then return 15 end
    return nil
end

local function get_ability_safe(unit, ability_enum)
    if not unit then return nil end

    if unit.get_ability then
        local ok, ability = pcall(function()
            return unit:get_ability(ability_enum)
        end)

        if ok and ability then return ability end
    end

    if not unit.get_abilities then return nil end

    local wanted_type = ability_enum_to_type(ability_enum)
    if not wanted_type then return nil end

    local ok, abilities = pcall(function()
        return unit:get_abilities()
    end)

    if not ok or type(abilities) ~= "table" then return nil end

    for _, ability in next, abilities do
        if ability_type(ability) == wanted_type then
            return ability
        end
    end

    return nil
end

local function ability_is_active(ab)
    if not ab then return false end

    if ab.is_activated ~= nil then
        if type(ab.is_activated) == "function" then
            local ok, active = pcall(function()
                return ab:is_activated()
            end)

            return ok and active == true
        end

        return ab.is_activated == true
    end

    return false
end

local function ability_on_cooldown(ab)
    if not ab then return false end

    if ab.on_cooldown ~= nil then
        if type(ab.on_cooldown) == "function" then
            local ok, cooldown = pcall(function()
                return ab:on_cooldown()
            end)

            if ok and cooldown == true then return true end
        elseif ab.on_cooldown == true then
            return true
        end
    end

    if ab.cooldown_remaining and ab.cooldown_remaining > 0 then return true end
    return false
end

local function ability_can_activate(ab)
    if not ab or not ab.can_activate then return nil end

    local ok, can_activate = pcall(function()
        return ab:can_activate()
    end)

    if ok then return can_activate == true end
    return nil
end

local function ability_by_id(unit, wanted_id)
    if not unit or not unit.get_abilities or not wanted_id then return nil end
    local ok, list = pcall(function() return unit:get_abilities() end)
    if not ok or type(list) ~= "table" then return nil end

    for _, ab in next, list do
        if ability_id(ab) == wanted_id then return ab end
    end

    return nil
end

local function enemy_ability_state(enemy, ability_enum)
    local ab = get_ability_safe(enemy, ability_enum)
    if ab then
        return ability_is_active(ab), ability_on_cooldown(ab), ab
    end

    if not enemy or not enemy.get_abilities then return false, false, nil end

    local wanted_type = ability_enum_to_type(ability_enum)

    if not wanted_type then return false, false, nil end

    local ok, list = pcall(function() return enemy:get_abilities() end)
    if not ok or type(list) ~= "table" then return false, false, nil end

    for _, active_ab in next, list do
        if active_ab and ability_type(active_ab) == wanted_type then
            return ability_is_active(active_ab), ability_on_cooldown(active_ab), active_ab
        end
    end

    return false, false, nil
end

local function ulting(e)
    if not e or not e.get_abilities then return false end
    local ok, list = pcall(function() return e:get_abilities() end)
    if not ok or type(list) ~= "table" then return false end
    for _, ab in next, list do
        if ab and ability_is_active(ab) then
            local id = ability_id(ab)
            if id and wanted_ults[id] then return true, wanted_ults[id], id end
        end
    end
end

-- Hulk's Radioactive Lockdown should be allowed to answer any active enemy
-- ultimate. The shared wanted_ults table is intentionally selective for
-- other heroes, but that restriction was preventing Hulk from reacting to
-- ultimates whose numeric ID is not listed there.
local function any_enemy_ultimate_active(e)
    local ab = get_ability_safe(e, A.Ultimate)
    if not ability_is_active(ab) then return false end
    return true, hero_name(e) .. " Ultimate", ability_id(ab)
end

local function lock_target(e, name, ult_id)
    locked_target = e
    locked_name = name
    locked_id = ult_id
    locked_until = ms() + TARGET_LOCK_MS
end

local function clear_lock()
    locked_target = nil
    locked_name = nil
    locked_id = nil
    locked_until = 0
end

local function ready(p, a)
    local ab = get_ability_safe(p, a)
    if not ab then return false end

    if ab.on_cooldown ~= nil then
        if type(ab.on_cooldown) == "function" then
            local ok, cooldown = pcall(function()
                return ab:on_cooldown()
            end)

            if ok and cooldown == true then return false end
        elseif ab.on_cooldown == true then
            return false
        end
    end

    if ab.cooldown_remaining and ab.cooldown_remaining > 0 then return false end

    if ab.is_activated ~= nil then
        if type(ab.is_activated) == "function" then
            local ok, active = pcall(function()
                return ab:is_activated()
            end)

            if ok and active == true then return false end
        elseif ab.is_activated == true then
            return false
        end
    end

    local can_activate = ability_can_activate(ab)
    if can_activate ~= nil then
        return can_activate == true
    end

    if ability_manager and ability_manager.can_activate_ability then
        return ability_manager:can_activate_ability(a) == true
    end
    return true
end

local function tap_key(k, hold_ms)
    if not k or not input then return false end
    if input.send_key and pcall(function() input.send_key(k, hold_ms or 25) end) then return true end
    if input.press_key and input.release_key then
        local down_ok = pcall(function() input.press_key(k) end)
        sleep(hold_ms or 25)
        local up_ok = pcall(function() input.release_key(k) end)
        return down_ok and up_ok
    end
    return false
end

local function key_down(k)
    if not k or not input or not input.press_key then return false end
    return pcall(function() input.press_key(k) end)
end

local function key_up(k)
    if not k or not input or not input.release_key then return false end
    return pcall(function() input.release_key(k) end)
end

local function cast(a)
    return tap_key(keys[a], 50)
end

local function rmb_down()
    if input and input.press_key then
        for _, k in next, { Enum.MouseButton and Enum.MouseButton.Right, "RButton", "RMB", "MouseRight" } do
            if pcall(function() input.press_key(k) end) then return true end
        end
    end
    return false
end

local function rmb_up()
    if input and input.release_key then
        for _, k in next, { Enum.MouseButton and Enum.MouseButton.Right, "RButton", "RMB", "MouseRight" } do
            if pcall(function() input.release_key(k) end) then return true end
        end
    end
    return false
end

local function correct_vertical_pitch()
    if not camera or not camera.get_rotation or not camera.set_rotation then return end

    local ok, rotation = pcall(function()
        return camera.get_rotation()
    end)

    if ok and rotation and rotation.pitch and rotation.yaw then
        pcall(function()
            camera.set_rotation(-rotation.pitch, rotation.yaw)
        end)
    end
end

local function camera_look_at_enemy(enemy)
    if not camera or not enemy then return false end
    if not camera.look_at then return false end

    local looked = false
    if enemy.location and pcall(function()
        camera.look_at(enemy.location)
    end) then
        looked = true
    elseif enemy.location and enemy.location.x and enemy.location.y and enemy.location.z and pcall(function()
        camera.look_at(enemy.location.x, enemy.location.y, enemy.location.z)
    end) then
        looked = true
    end

    if looked and camera.get_rotation and camera.set_rotation then
        local ok, rotation = pcall(function()
            return camera.get_rotation()
        end)
        if ok and rotation and rotation.pitch and rotation.yaw then
            pcall(function()
                camera.set_rotation(-rotation.pitch, rotation.yaw)
            end)
        end
    end

    return looked
end

local function is_cap(player)
    return hero_id(player) == CAPTAIN_AMERICA_ID
end

local function local_ability_active(player, ability_enum)
    local ab = get_ability_safe(player, ability_enum)
    return ability_is_active(ab)
end

local function name_is(unit, wanted)
    local name = string.lower(hero_name(unit))

    for _, v in next, wanted do
        if name == v then return true end
    end

    return false
end

local function get_block_action(player)
    local id = hero_id(player)

    if is_cap(player) then
        return { n = "Captain America", a = A.SecondaryAttack, key = keys[A.SecondaryAttack] }
    end

    if id == 1056 or name_is(player, { "angela" }) then
        return { n = "Angela", a = A.SecondaryAttack, key = keys[A.SecondaryAttack] }
    end

    if name_is(player, { "doctor strange", "strange" }) then
        return { n = "Doctor Strange", a = A.SecondaryAttack, key = keys[A.SecondaryAttack] }
    end

    if id == 1053 or name_is(player, { "emma", "emma frost" }) then
        if local_ability_active(player, A.Ability2) then return nil end
        return { n = "Emma", a = A.SecondaryAttack, key = keys[A.SecondaryAttack] }
    end

    if name_is(player, { "magneto" }) then
        return { n = "Magneto", a = A.Ability2, key = keys[A.Ability2] }
    end

    return nil
end

local function hold_block_action(action)
    if not action then return false end
    if action.a == A.SecondaryAttack then return rmb_down() end
    return key_down(action.key)
end

local function release_block_action(action)
    if not action then return false end
    if action.a == A.SecondaryAttack then return rmb_up() end
    return key_up(action.key)
end

local function enemy_ability_active(enemy, ability_enum)
    local active = enemy_ability_state(enemy, ability_enum)
    return active == true
end

local function cc_threat_active(enemy)
    local id = hero_id(enemy)

    if id == 1031 or id == 1060 or id == 1042 then
        local active = enemy_ability_state(enemy, A.SecondaryAttack)
        if active then return true, "Secondary", A.SecondaryAttack, nil end
    end

    if id == 1020 or id == 1011 then
        local active = enemy_ability_state(enemy, A.Ability1)
        if active then return true, "Ability1", A.Ability1, nil end
    end

    return false, nil, nil, nil
end

local function blocked_ability_on_cooldown(enemy, ability_enum, ult_id)
    if not alive(enemy) then return true end

    if ability_enum then
        local active, cooldown = enemy_ability_state(enemy, ability_enum)
        if cooldown then return true end
        if not active then return true end
        return false
    end

    if ult_id then
        local ab = ability_by_id(enemy, ult_id)
        if ability_on_cooldown(ab) then return true end
        if ab and ability_is_active(ab) then return false end
        return true
    end

    return true
end

local function find_cap_shield_threat(player)
    local list = object_manager and object_manager.get_players and object_manager.get_players(true)
    if type(list) ~= "table" then return nil, nil, nil end

    local best = nil
    local best_d = math.huge
    local best_reason = nil
    local max_range = CAP_BLOCK_RANGE

    for _, enemy in next, list do
        local active_threat, reason, ability_enum, ult_id = cc_threat_active(enemy)

        if alive(enemy) and active_threat and has_line_of_sight(enemy) then
            local d = dist(player, enemy)
            if d <= max_range and d < best_d then
                best = enemy
                best_d = d
                best_reason = { text = reason, ability = ability_enum, ult = ult_id }
            end
        end
    end

    return best, best_d, best_reason
end

local function release_cap_block(reason)
    if cap_blocking then
        release_block_action(cap_block_action)
    end

    cap_blocking = false
    cap_block_target = nil
    cap_block_action = nil
    cap_block_ability = nil
    cap_block_ability_id = nil
    cap_block_release_at = 0
end

local function scan_cc_shield_block(player)
    if cc_shield_block_enabled() ~= true then
        release_cap_block("setting disabled")
        return false
    end

    local action = get_block_action(player)

    if not action then
        release_cap_block("no blocker hero")
        return false
    end

    if cap_blocking then
        if input and input.is_key_down and input.is_key_down(END_KEY) then
            release_cap_block("end")
            return false
        end

        if action.n == "Emma" and local_ability_active(player, A.Ability2) then
            release_cap_block("emma ability2 active")
            return false
        end

        if not has_line_of_sight(cap_block_target) then
            release_cap_block("lost line of sight")
            return false
        end

        if blocked_ability_on_cooldown(cap_block_target, cap_block_ability, cap_block_ability_id) then
            if cap_block_release_at == 0 then
                cap_block_release_at = ms() + BLOCK_RELEASE_BUFFER_MS
            end

            if ms() >= cap_block_release_at then
                release_cap_block("blocked ability cooldown")
                return false
            end

            camera_look_at_enemy(cap_block_target)
            return true
        end

        cap_block_release_at = 0
        camera_look_at_enemy(cap_block_target)
        return true
    end

    local threat, d, reason = find_cap_shield_threat(player)
    if not threat then return false end

    cap_blocking = true
    cap_block_target = threat
    cap_block_action = action
    cap_block_ability = reason and reason.ability or nil
    cap_block_ability_id = reason and reason.ult or nil
    cap_block_release_at = 0
    hold_block_action(action)
    camera_look_at_enemy(threat)

    return true
end

local function raise_aim()
    local px = cfg("mantis_raise", 12)
    if px <= 0 then return end
    if input and input.move_mouse and pcall(function() input.move_mouse(0, -px) end) then return end
    if input and input.mouse_move then pcall(function() input.mouse_move(0, -px) end) end
end

local function invisible_push_range(ult_name, ult_id)
    local name = tostring(ult_name or ""):lower()

    if name:find("doctor strange", 1, true) or name:find("strange", 1, true) then return 10 end
    if name:find("spider", 1, true) or name:find("rogue", 1, true) then return 8 end
    if name:find("daredevil", 1, true) or name:find("scarlet", 1, true) then return 15 end

    if ult_id == 101871 then return 10 end
    if ult_id == 103651 or ult_id == 1036510 or ult_id == 1036800 or ult_id == 106561 then return 8 end
    if ult_id == 105561 or ult_id == 103851 then return 15 end

    return nil
end

local function find_target(p, act)
    if alive(locked_target) and has_line_of_sight(locked_target) and ms() < locked_until then
        return locked_target, dist(p, locked_target), locked_name, locked_id
    end

    local list = object_manager and object_manager.get_players and object_manager.get_players(true)
    if type(list) ~= "table" then return nil, nil, nil, nil end
    local best, best_d, best_name, best_id = nil, math.huge, nil, nil
    local max_range = act.r
    local max_fov = cfg("fov", 180)
    for _, e in next, list do
        if alive(e) and has_line_of_sight(e) then
            local ok, name, ult_id = ulting(e)
            if not ok and act.n == "Hulk" then
                ok, name, ult_id = any_enemy_ultimate_active(e)
            end
            if ok then
                local d = dist(p, e)
                local f = e.get_fov_to_target and math.abs(e:get_fov_to_target()) or 9999
                if act.kind == "invisible_push" then
                    max_range = invisible_push_range(name, ult_id) or -1
                else
                    max_range = act.r
                end
                if d <= max_range and f <= max_fov and d < best_d then
                    best, best_d, best_name, best_id = e, d, name, ult_id
                end
            end
        end
    end
    return best, best_d, best_name, best_id
end

local function can_run(p, act)
    if act.kind == "invisible_push" then return ready(p, A.Ability1) end
    if act.kind == "emma" then return ready(p, A.Ability2) and ready(p, A.Ability1) end
    if act.kind == "rogue" then return ready(p, A.Ability3) end
    if act.kind == "mantis" then return ready(p, A.Ability2) end
    if act.kind == "winter" then return ready(p, A.SecondaryAttack) end
    if act.n == "Luna" then
        local secondary = get_ability_safe(p, A.SecondaryAttack)
        return secondary ~= nil and not ability_on_cooldown(secondary)
    end
    return ready(p, act.a)
end

local function stage_aim(e, act)
    if not alive(e) or not has_line_of_sight(e) then return false end
    return camera_look_at_enemy(e)
end

local function stage_wait(act)
    if act.kind == "invisible_push" then return end
    if act.n == "Luna" then return end
    sleep(cfg("wait_ms", 250))
end

local function stage_cast(act)
    if act.kind == "emma" then
        cast(A.Ability2)
        sleep(300)
        cast(A.Ability1)
    elseif act.kind == "invisible_push" then
        cast(A.Ability1)
        cast(A.PrimaryAttack)
    elseif act.kind == "rogue" then
        cast(A.Ability3)
    elseif act.kind == "winter" then
        cast(A.SecondaryAttack)
    elseif act.kind == "mantis" then
        raise_aim()
        cast(A.Ability2)
    else
        cast(act.a)
    end
end

local function interrupt(p, act, e, d, ult_name)
    if not has_line_of_sight(e) then return end
    if act.kind == "winter" then
        rmb_down()
        if not stage_aim(e, act) then
            rmb_up()
            return
        end
        stage_wait(act)
		sleep(700)
        rmb_up()
        last_hit = ms()
        return
    end

    if not stage_aim(e, act) then return end
    stage_wait(act)
    stage_cast(act)
    last_hit = ms()
end

local function scan()
    if busy then return end
    busy = true
    local p = object_manager and object_manager.get_local_player and object_manager.get_local_player()
    if not alive(p) then
        release_cap_block("no player")
        busy = false
        return
    end

    if scan_cc_shield_block(p) then busy = false return end
    if ultimate_cancel_enabled() ~= true then busy = false return end
    local act = my_action(p)
    if not act then busy = false return end
    local e, d, name, ult_id = find_target(p, act)
    if not e then busy = false return end
    if ms() - last_hit < TRIGGER_COOLDOWN_MS then busy = false return end
    if not can_run(p, act) then busy = false return end
    lock_target(e, name, ult_id)
    local ok, err = pcall(function() interrupt(p, act, e, d, name) end)
    if not ok then return false end
    clear_lock()
    busy = false
end

local function start()
    if timer_id then return end
    timer_id = timer.set_interval(function()
        if input and input.is_key_down and input.is_key_down(END_KEY) then
            active = false
            release_cap_block("end")
            return
        end

        if active then scan() end
    end, SCAN_MS)
end

function on_activate_combo(ctx)
    start()
    active = true
    scan()
    return true
end

function on_deactivate_combo(ctx)
    release_cap_block("combo deactivate")
end

start()

]],
}

local ultimate_cancels_source = MODULE_DEFS[#MODULE_DEFS].source
MODULE_DEFS[#MODULE_DEFS + 1] = {
    name = "Auto Shield CC",
    kind = "scanner",
    source = ultimate_cancels_source:gsub('local ROUTE_KIND = "ultimate"', 'local ROUTE_KIND = "cc"', 1),
}
MODULE_DEFS[#MODULE_DEFS + 1] = {
    name = "Ultimate Cancels Test",
    kind = "scanner",
    source = [[
-- Simplified alternative to "Ultimate Cancels": instead of per-enemy-hero
-- ability-state detection, this checks the enemy's own Ultimate ability
-- for has_montage directly. has_montage is a NEW/unconfirmed SDK
-- field (per the dev's update, not in the sdk.lua we have) -- wrapped
-- defensively so a bad signature never errors the tick, it just treats the
-- ultimate as not-interruptable.
--
-- Covers heroes with a single, simple cancel ability (CANCEL_ABILITY) plus
-- Emma and Mantis, which need multi-step reactions (REACTION). Rogue and
-- Winter/Bucky still use multi-step reactions in the original Ultimate
-- Cancels module and aren't included here.

local END_KEY = 35
local SCAN_MS = script.get_setting("scan_poll_ms") or 100
local RANGE_M = 25

-- Degrees to pitch the camera up after aiming, for Mantis's sleep dart arc.
-- Sign follows camera_look_at_enemy's post-invert convention (see its
-- comment above) -- unconfirmed against the real SDK, flip if it aims down
-- instead of up.
local MANTIS_RAISE_DEGREES = 10

local CANCEL_ABILITY = {
    [1042] = Enum.AbilityType.SecondaryAttack, -- Peni
    [1031] = Enum.AbilityType.SecondaryAttack, -- Luna
    [1060] = Enum.AbilityType.SecondaryAttack, -- White Fox
    [1036] = Enum.AbilityType.Ability1,        -- Spider-Man
    [1038] = Enum.AbilityType.Ability1,        -- Scarlet Witch
    [1011] = Enum.AbilityType.Ability1,        -- Hulk
    [1050] = Enum.AbilityType.Ability1,        -- Invisible Woman
}

local REACTION = {
    [1020] = "mantis", -- Mantis: Ability2, camera pitched up 10 first
    [1053] = "emma",   -- Emma: Ability2 -> wait 200ms -> look_at again -> Ability1
}

local scan_active = false
local scanner_id = nil

local function get_hero_id(player)
    if not player then return nil end
    if player.get_hero_id then
        local ok, id = pcall(function() return player:get_hero_id() end)
        if ok and id then return id end
    end
    return player.hero_id
end

local function ultimate_has_montage(enemy)
    if not enemy or not enemy.get_ability then return false end

    local ok, ability = pcall(function()
        return enemy:get_ability(Enum.AbilityType.Ultimate)
    end)
    if not ok or not ability then return false end
    if ability.has_montage == nil then return false end

    local ok2, result = pcall(function()
        if type(ability.has_montage) == "function" then
            return ability:has_montage()
        end
        return ability.has_montage
    end)

    return ok2 and result == true
end

local function rotate_camera_up(degrees)
    if not camera or not camera.get_rotation or not camera.set_rotation then return false end

    local ok, rotation = pcall(function() return camera.get_rotation() end)
    if not ok or not rotation or not rotation.pitch or not rotation.yaw then return false end

    local applied = pcall(function()
        camera.set_rotation(rotation.pitch - degrees, rotation.yaw)
    end)

    return applied == true
end

local function run_reaction(kind, enemy)
    if kind == "mantis" then
        camera_look_at_enemy(enemy)
        rotate_camera_up(MANTIS_RAISE_DEGREES)
        ability_manager:activate_ability(Enum.AbilityType.Ability2, 10)
    elseif kind == "emma" then
        camera_look_at_enemy(enemy)
        ability_manager:activate_ability(Enum.AbilityType.Ability2, 10)
        wait(200)
        camera_look_at_enemy(enemy)
        ability_manager:activate_ability(Enum.AbilityType.Ability1, 10)
    end
end

local function scan_once()
    local player = object_manager.get_local_player()
    if not player or not player:is_valid() or player.is_dead then return end

    local hero_id = get_hero_id(player)
    local cancel_ability = CANCEL_ABILITY[hero_id]
    local reaction_kind = REACTION[hero_id]
    if not cancel_ability and not reaction_kind then return end

    local enemies = object_manager.get_players(true)
    if not enemies then return end

    for i = 1, #enemies do
        local enemy = enemies[i]
        if enemy and enemy:is_valid() and not enemy.is_dead then
            local dist = player.location:get_distance_to_meters(enemy.location)
            if dist <= RANGE_M and ultimate_has_montage(enemy) then
                if reaction_kind then
                    run_reaction(reaction_kind, enemy)
                else
                    camera_look_at_enemy(enemy)
                    ability_manager:activate_ability(cancel_ability, 10)
                end
                break
            end
        end
    end
end

local function start_scanner()
    if scanner_id then return true end

    scanner_id = timer.set_interval(function()
        if input and input.is_key_down and input.is_key_down(END_KEY) then
            scan_active = false
            return
        end

        if scan_active then
            scan_once()
        end
    end, SCAN_MS)

    return true
end

function on_activate_combo(ctx)
    start_scanner()
    scan_active = true
    return true
end

function on_deactivate_combo(ctx)
    scan_active = false
    if scanner_id then
        timer.clear(scanner_id)
        scanner_id = nil
    end
end

]],
}
MODULE_DEFS[#MODULE_DEFS + 1] = {
    name = "Jeff Auto Bubble",
    kind = "scanner",
    source = [[
-- end stop guard
local __route_end_stop_signal = "__route_end_stop_signal"
local __route_raw_wait = wait
local function __route_end_pressed()
    return input and input.is_key_down and input.is_key_down(35) == true
end
local function __route_release_combo_inputs()
    if not input or not input.release_key then return end
    pcall(function() input.release_key(Enum.MouseButton.Left) end)
    pcall(function() input.release_key(Enum.MouseButton.Right) end)
    pcall(function() input.release_key(Enum.Key.Space) end)
    pcall(function() input.release_key(Enum.Key.W) end)
    pcall(function() input.release_key(Enum.Key.A) end)
    pcall(function() input.release_key(Enum.Key.S) end)
    pcall(function() input.release_key(Enum.Key.D) end)
end
local function wait(ms)
    if __route_end_pressed() then
        __route_release_combo_inputs()
        error(__route_end_stop_signal, 0)
    end
    __route_raw_wait(ms)
    if __route_end_pressed() then
        __route_release_combo_inputs()
        error(__route_end_stop_signal, 0)
    end
end

local END_KEY = 35

settings = {
    { key = "hp_thresh", label = "HP Threshold", default = 125, min = 1, max = 250 },
    { key = "ignore_shield", label = "Ignore Shield", default = false },
    { key = "scan_ms", label = "Scan MS", default = 50, min = 10, max = 500 },
}

local scan_active = false
local scanner_id = nil
local scan_busy = false
local triggered = false

local function num(key, fallback)
    local value = script.get_setting(key)
    if type(value) ~= "number" then return fallback end
    return math.floor(value)
end

local function scan_once(ctx)
    if scan_busy then return false end
    scan_busy = true

    ctx = ctx or {}
    local p = ctx.player or object_manager.get_local_player()
    if not p or not p:is_valid() or p.is_dead then triggered = false scan_busy = false return false end

    local hp = (p.health or 0) + (script.get_setting("ignore_shield") and 0 or (p.shield or 0))
    if hp >= num("hp_thresh", 125) then triggered = false scan_busy = false return false end

    local ab1 = p:get_ability(Enum.AbilityType.Ability1)
    if not ab1 or ab1.on_cooldown or (ab1.cooldown_remaining and ab1.cooldown_remaining > 0) then triggered = false scan_busy = false return false end
    if triggered then scan_busy = false return false end

    triggered = true

    local rot = camera.get_rotation()
    camera.set_rotation(-90, rot.yaw)
    ability_manager:activate_ability(Enum.AbilityType.Ability1)
    wait(15)
    ability_manager:activate_ability(Enum.AbilityType.Jump)
    wait(155)

    if not p.is_grounded then
        ability_manager:activate_ability(Enum.AbilityType.Ability2)
    end

    camera.set_rotation(rot.pitch, rot.yaw)
    scan_busy = false
    return true
end

local function start_scanner()
    if scanner_id then return true end

    scanner_id = timer.set_interval(function()
        if input.is_key_down(END_KEY) then
            scan_active = false
            return
        end

        if scan_active then
            scan_once(nil)
        end
    end, num("scan_ms", 50))

    return true
end

local function __route_original_on_activate_combo(ctx)
    start_scanner()
    scan_active = true
    scan_once(ctx)
    return true
end

function on_deactivate_combo(ctx)
    -- End key stops the scanner.
end

start_scanner()


local __route_wrapped_on_activate_combo = __route_original_on_activate_combo
function on_activate_combo(ctx)
    if __route_end_pressed() then
        __route_release_combo_inputs()
        return false
    end

    local ok, result = pcall(__route_wrapped_on_activate_combo, ctx)
    if not ok then
        if result == __route_end_stop_signal or tostring(result) == __route_end_stop_signal then
            __route_release_combo_inputs()
            return false
        end
        error(result)
    end

    return result
end

]],
}

MODULE_DEFS[#MODULE_DEFS + 1] = {
    name = "MagBubble",
    kind = "scanner",
    source = [[
local MAG_HERO_ID = 1037
local ABILITY1 = Enum.AbilityType.Ability1

local ALLY_HP_THRESHOLD = 0.45
local ALLY_RANGE_M = 18
local LOOK_SETTLE_MS = 25
local CAST_SETTLE_MS = 25
local SCAN_MS = script.get_setting("scan_poll_ms") or 100
local END_KEY = 35

local scanner_id = nil
local scan_active = false
local scan_busy = false

local function valid_player(player)
    return player and player:is_valid() and not player.is_dead
end

local function is_mag(player)
    return valid_player(player) and player.hero_id == MAG_HERO_ID
end

local function valid_ally(player, ally)
    return ally
        and ally ~= player
        and ally:is_valid()
        and not ally.is_dead
        and not ally:is_enemy()
        and ally.location
end

local function health_percent(unit)
    if type(unit.health) ~= "number" then return 1 end
    if type(unit.max_health) ~= "number" or unit.max_health <= 0 then return 1 end
    return unit.health / unit.max_health
end

local function find_lowest_ally(player)
    local allies = object_manager.get_players(false)
    if type(allies) ~= "table" then return nil end

    local best = nil
    local best_hp = math.huge

    for _, ally in ipairs(allies) do
        if valid_ally(player, ally) then
            local dist = player.location:get_distance_to(ally.location) * 0.01
            local hp = health_percent(ally)
            if dist <= ALLY_RANGE_M and hp < ALLY_HP_THRESHOLD and hp < best_hp then
                best = ally
                best_hp = hp
            end
        end
    end

    return best
end

local function ability_flag(ability, key)
    local value = ability[key]
    if type(value) == "function" then
        local ok, result = pcall(function()
            return value(ability)
        end)

        return ok and result == true
    end

    return value == true
end

local function ability1_ready(player)
    local ability = player:get_ability(ABILITY1)
    if not ability or not ability:is_valid() then return false end
    if ability_flag(ability, "on_cooldown") then return false end
    if ability_flag(ability, "is_activated") then return false end
    if ability.cooldown_remaining and ability.cooldown_remaining > 0 then return false end

    if ability_manager and ability_manager.can_activate_ability then
        return ability_manager:can_activate_ability(ABILITY1) == true
    end

    if ability.can_activate then
        return ability:can_activate() == true
    end

    return false
end

local function look_at_with_fix(ally)
    local aimed = pcall(function()
        camera.look_at(ally.location)
    end)

    if not aimed then
        return false
    end

    -- Invert pitch AFTER look_at
    local new_rotation = camera.get_rotation()
    if new_rotation and new_rotation.pitch and new_rotation.yaw then
        pcall(function()
            camera.set_rotation(-new_rotation.pitch, new_rotation.yaw)
        end)
    end

    return true
end

local function camera_bubble(ally)
    local saved_rotation = camera.get_rotation()
    if not saved_rotation then return false end

    local saved_pitch = saved_rotation.pitch
    local saved_yaw = saved_rotation.yaw

    local aimed = pcall(function()
        camera.look_at(ally.location)
    end)

    if not aimed then
        return false
    end

    -- Invert pitch AFTER look_at
    local new_rotation = camera.get_rotation()
    if new_rotation and new_rotation.pitch and new_rotation.yaw then
        pcall(function()
            camera.set_rotation(-new_rotation.pitch, new_rotation.yaw)
        end)
    end

    wait(LOOK_SETTLE_MS)
    ability_manager:activate_ability(ABILITY1)
    wait(CAST_SETTLE_MS)

    -- Restore original rotation
    camera.set_rotation(saved_pitch, saved_yaw)

    return true
end

local function scan_once()
    if scan_busy then return false end
    scan_busy = true

    local player = object_manager.get_local_player()
    if not is_mag(player) or not ability1_ready(player) then
        scan_busy = false
        return false
    end

    local ally = find_lowest_ally(player)
    if not ally then
        scan_busy = false
        return false
    end

    camera_bubble(ally)
    scan_busy = false
    return true
end

local function stop_scanner()
    scan_active = false
    scan_busy = false

    if scanner_id then
        timer.clear(scanner_id)
        scanner_id = nil
    end
end

local function start_scanner()
    if scanner_id then
        scan_active = true
        return true
    end

    scan_active = true
    scanner_id = timer.set_interval(function()
        if input.is_key_down(END_KEY) then
            stop_scanner()
            return
        end

        if scan_active then
            scan_once()
        end
    end, SCAN_MS)

    return true
end

function on_activate_combo(ctx)
    return start_scanner()
end

function on_deactivate_combo(ctx)
    -- Releasing trigger_key does not stop the scanner. End stops it.
end

]],
}

MODULE_DEFS[#MODULE_DEFS + 1] = {
    name = "Magneto Groot Angela",
    kind = "scanner",
    source = [[
settings = {
    { key="hp_thresh",               label="Bubble HP %",                 tooltip="Auto bubble when HP% <= this",                                           default=50,   min=1,   max=100  },
    { key="include_shield",          label="Include Shield",               tooltip="Count shield toward HP%",                                                default=true                    },
    { key="team_bubble",             label="Bubble Teammates",             tooltip="Cast Ability1 on low HP allies",                                         default=true                    },
    { key="team_range",              label="Ally Range (m)",               tooltip="Max distance to ally",                                                   default=25,   min=1,   max=60   },
    { key="flick_ally",              label="Flick To Ally",               tooltip="Aim at low HP ally before bubble",                                       default=true                    },
    { key="flick_dur",               label="Flick Duration (ms)",         tooltip="Aim time",                                                              default=120,  min=30,  max=600  },
    { key="auto_ult_eat",            label="Auto-Ult Eat",                 tooltip="Cast Ultimate to absorb Angela/Groot ultimates",                         default=true                    },
    { key="ult_eat_range",           label="Ult Eat Range (m)",            tooltip="Max range to activate ultimate block",                                   default=35,   min=5,   max=60   },
    { key="ult_eat_angela",          label="Eat Angela Ult",               tooltip="Automatically ultimate when Angela ultimates",                           default=true                    },
    { key="ult_eat_groot",           label="Eat Groot Ult",                tooltip="Automatically ultimate when Groot ultimates",                            default=true                    },
    { key="ult_eat_max_age_ms",      label="Ult Eat Max Age (ms)",         tooltip="Only react if the enemy ult started within this time window",            default=2000, min=100, max=5000 },
    { key="shield_cyclops_ult",      label="Shield on Cyclops Ult",        tooltip="Self shield (Ability3) when Cyclops ultimates",                         default=true                    },
    { key="shield_cyclops_delay_ms", label="Cyclops Shield Delay (ms)",    tooltip="Delay after Cyclops starts ult before shielding (syncs with laser)",    default=1000, min=0,   max=5000 },
    { key="shield_strange_ult",      label="Shield on Dr. Strange Ult",    tooltip="Self shield (Ability3) when Dr. Strange ultimates near you",            default=true                    },
    { key="shield_strange_delay_ms", label="Strange Shield Delay (ms)",    tooltip="Delay after Strange starts ult before shielding",                       default=100,  min=0,   max=5000 },
    { key="shield_strange_range",    label="Strange Shield Range (m)",     tooltip="Only shield if Dr. Strange is within this range",                       default=15,   min=5,   max=40   },
    { key="shield_wolverine_ult",      label="Shield on Wolverine Ult",      tooltip="Self shield (Ability3) when Wolverine ultimates near you",              default=true                    },
    { key="shield_wolverine_delay_ms", label="Wolverine Shield Delay (ms)",    tooltip="Delay after Wolverine starts ult before shielding",                     default=0,    min=0,   max=5000 },
    { key="shield_wolverine_range",    label="Wolverine Shield Range (m)",     tooltip="Only shield if Wolverine is within this range",                         default=15,   min=5,   max=40   },
    { key="shield_wolverine_shift",    label="Shield on Wolverine Leap",     tooltip="Self shield (Ability3) when Wolverine leaps/kidnaps near you",          default=true                    },
    { key="shield_wolverine_shift_range", label="Wolverine Leap Range (m)",   tooltip="Only shield if Wolverine is within this range",                         default=4,    min=1,   max=30   },
    { key="shield_wolverine_shift_ally",  label="Bubble Ally on Wolverine Leap", tooltip="Cast Ability1 on teammate when Wolverine leaps/kidnaps near them",     default=true                    },
    { key="shield_wolverine_shift_ally_range", label="Wolverine Leap Ally Range (m)", tooltip="Max distance to teammate to cast bubble",                        default=25,   min=5,   max=60   },
    { key="shield_ally_ults",          label="Bubble Allies on Enemy Ults", tooltip="Cast Ability1 on teammates when they are targeted by Cyclops/Strange/Wolverine ults", default=true },
    { key="shield_rate_limit_ms",      label="Re-shield Cooldown (ms)",     tooltip="Time before shielding/bubbling the same target again",                  default=8000, min=0,   max=15000 },
}

local ULT = Enum.AbilityType.Ultimate

local busy                   = false
local ult_start_times        = {}
local shielded_ult_instances = {}

local ally_flick = {
    use_prediction     = false,
    cancel_aiming_away = false,
    always_fire        = true,
    duration           = 120,
    aim_points         = { Enum.AimPoint.Body },
}

local ally_cfg = {
    aim_fov          = 360,
    dynamic_fov      = false,
    ignore_invisible = false,
    ignore_shield    = true,
    ignore_team      = false,
    ignore_enemy     = true,
    max_distance     = 60,
}

local function ms()
    return math.floor(os.clock() * 1000)
end

local function safe_valid_player(p)
    if not p then return false end
    local ok, res = pcall(function()
        return p.is_valid and p:is_valid() and not p.is_dead
    end)
    return ok and res
end

local function unit_key(e)
    if not e then return nil end
    local ok, res = pcall(function()
        return e.pointer or e.address or e.name or e.hero_id
    end)
    return ok and res or nil
end

local function hp_pct(p)
    if not p then return 100 end
    local ok, res = pcall(function()
        if not p.is_valid or not p:is_valid() or p.is_dead then return 100 end
        local inc = script.get_setting("include_shield")
        local hp  = (p.health or 0) + (inc and (p.shield or 0) or 0)
        local mx  = p.max_health
        if not mx or mx <= 0 then return 100 end
        return (hp / mx) * 100
    end)
    return ok and res or 100
end

local function dist(a, b)
    if not a or not b then return 99999 end
    local ok, d = pcall(function()
        if not a.is_valid or not a:is_valid() or not b.is_valid or not b:is_valid() then return 99999 end
        local a_loc = a.location
        local b_loc = b.location
        if not a_loc or not b_loc then return 99999 end
        if a_loc.get_distance_to_meters then
            return a_loc:get_distance_to_meters(b_loc)
        end
        return a_loc:get_distance_to(b_loc) * 0.01
    end)
    return ok and d or 99999
end

local function visible_or_los(e)
    if not e then return false end
    local ok, res = pcall(function()
        if not e.is_valid or not e:is_valid() then return false end
        local vis = false
        if e.is_visible then
            vis = e:is_visible()
        end
        local los = false
        if e.has_line_of_sight then
            los = e:has_line_of_sight()
        end
        return vis or los
    end)
    return ok and res or false
end

local function get_player_status(enemy)
    local status = {
        is_ulting = false,
        is_shifting = false,
        ult_id = nil,
        shift_id = nil,
        hero_id = nil,
        name = nil
    }
    if not enemy then return status end

    pcall(function()
        if not enemy.is_valid or not enemy:is_valid() or enemy.is_dead then return end
        status.hero_id = enemy.hero_id
        status.name = enemy.hero_name or enemy.name

        if not enemy.get_abilities then return end
        local list = enemy:get_abilities()
        if not list or type(list) ~= "table" then return end

        for i = 1, #list do
            local ab = list[i]
            if ab and ab.is_valid and ab:is_valid() then
                local is_act = false
                if ab.is_activated ~= nil then
                    is_act = ab.is_activated == true
                end
                if is_act then
                    local id = ab.get_id and ab:get_id() or ab.id
                    local ab_type = ab.get_type and ab:get_type() or ab.type
                    if id and ab_type then
                        local prefix = math.floor(id / 100)
                        if prefix == status.hero_id or prefix == math.floor(status.hero_id / 10) then
                            if ab_type == Enum.AbilityType.Ultimate or ab_type == 20 then
                                status.is_ulting = true
                                status.ult_id = id
                            elseif ab_type == Enum.AbilityType.Ability2 or ab_type == 17 then
                                status.is_shifting = true
                                status.shift_id = id
                            end
                        end
                    end
                end
            end
        end
    end)
    return status
end

local function is_hela_ulting(tm)
    if not tm then return false end
    local ok, res = pcall(function()
        local hid = tm.hero_id
        if hid ~= 1024 and hid ~= 1046 then return false end

        local status = get_player_status(tm)
        return status.is_ulting
    end)
    return ok and res
end

local function find_low_ally(p, thresh, range)
    local list = object_manager.get_players(false)
    if not list or type(list) ~= "table" then return nil end
    local best, best_hp = nil, math.huge
    for i = 1, #list do
        local m = list[i]
        if m and m ~= p and safe_valid_player(m) then
            local ok_enemy, is_enemy = pcall(function() return m:is_enemy() end)
            if ok_enemy and is_enemy == false then
                if not is_hela_ulting(m) then
                    local d = dist(p, m)
                    if d <= range then
                        local h = hp_pct(m)
                        if h <= thresh and h < best_hp then
                            best, best_hp = m, h
                        end
                    end
                end
            end
        end
    end
    return best
end

function on_activate_combo(ctx)
    local ok, res = pcall(function()
        local p = ctx.player
        if not safe_valid_player(p) then return false end

        local thresh   = script.get_setting("hp_thresh") or 50
        local self_low = hp_pct(p) <= thresh
        local range    = script.get_setting("team_range") or 25
        local ally     = script.get_setting("team_bubble") and find_low_ally(p, thresh, range) or nil

        if not self_low and not ally then return true end

        local atype = self_low and Enum.AbilityType.Ability3 or Enum.AbilityType.Ability1
        local ab    = p:get_ability(atype)
        if not ab or not ab:is_valid() then return true end

        local blocked = ab.on_cooldown or ab.is_activated or (ab.cooldown_remaining or 0) > 0
        if blocked then return true end
        if not ability_manager:can_activate_ability(atype) then return true end

        if not self_low and ally and script.get_setting("flick_ally") then
            ally_flick.duration = math.floor(script.get_setting("flick_dur") or 120)
            if safe_valid_player(ally) then
                flickbot.perform(ally, atype, ally_flick, ally_cfg, Enum.AbilityWait.None)
            end
        else
            ability_manager:activate_ability(atype)
        end
        return true
    end)
    if not ok then return false end
    return res
end


local function shield_ready()
    local ok, res = pcall(function()
        local player = object_manager.get_local_player()
        if not safe_valid_player(player) then return false end
        local ab = player:get_ability(Enum.AbilityType.Ability3)
        if not ab or not ab:is_valid() then return false end
        if ab.on_cooldown or ab.is_activated or (ab.cooldown_remaining or 0) > 0 then return false end
        return ability_manager:can_activate_ability(Enum.AbilityType.Ability3)
    end)
    return ok and res
end

local function fire_shield(key, now)
    busy = true
    pcall(function()
        shielded_ult_instances[key] = now
        ability_manager:activate_ability(Enum.AbilityType.Ability3)
    end)
    busy = false
end

local function bubble_ready()
    local ok, res = pcall(function()
        local player = object_manager.get_local_player()
        if not safe_valid_player(player) then return false end
        local ab = player:get_ability(Enum.AbilityType.Ability1)
        if not ab or not ab:is_valid() then return false end
        if ab.on_cooldown or ab.is_activated or (ab.cooldown_remaining or 0) > 0 then return false end
        return ability_manager:can_activate_ability(Enum.AbilityType.Ability1)
    end)
    return ok and res
end

local function fire_bubble(target, key, now)
    busy = true
    pcall(function()
        shielded_ult_instances[key] = now
        if safe_valid_player(target) then
            if script.get_setting("flick_ally") then
                ally_flick.duration = math.floor(script.get_setting("flick_dur") or 120)
                flickbot.perform(target, Enum.AbilityType.Ability1, ally_flick, ally_cfg, Enum.AbilityWait.None)
            else
                ability_manager:activate_ability(Enum.AbilityType.Ability1)
            end
        end
    end)
    busy = false
end

timer.set_interval(function()
    pcall(function()
        if busy then return end

        local player = object_manager.get_local_player()
        if not safe_valid_player(player) then return end
        
        local ok_id, hid = pcall(function() return player.hero_id end)
        if not ok_id or hid ~= 1037 then return end

        local now            = ms()

        local list = object_manager.get_players(true)
        if not list or type(list) ~= "table" then return end

        local current_ulting = {}
        local limit_ms       = script.get_setting("shield_rate_limit_ms") or 8000

        -- 1. Query enemies and update ult timings in a single pass
        local enemies = {}
        for i = 1, #list do
            local e = list[i]
            if safe_valid_player(e) then
                local status = get_player_status(e)
                local key = unit_key(e)
                local d = dist(player, e)
                local vis = visible_or_los(e)
                table.insert(enemies, {
                    entity = e,
                    status = status,
                    key = key,
                    dist = d,
                    visible = vis
                })
                if key and status.is_ulting then
                    current_ulting[key] = true
                    if not ult_start_times[key] then
                        ult_start_times[key] = now
                    end
                end
            end
        end

        for key in pairs(ult_start_times) do
            if not current_ulting[key] then
                ult_start_times[key] = nil
            end
        end

        -- Pre-query teammates if needed for ally bubble reactions
        local teammates = {}
        if (script.get_setting("shield_wolverine_shift_ally") or script.get_setting("shield_ally_ults")) and bubble_ready() then
            local teammates_list = object_manager.get_players(false)
            if teammates_list and type(teammates_list) == "table" then
                for j = 1, #teammates_list do
                    local tm = teammates_list[j]
                    if safe_valid_player(tm) and tm ~= player then
                        local ok_enemy, is_enemy = pcall(function() return tm:is_enemy() end)
                        if ok_enemy and is_enemy == false then
                            table.insert(teammates, {
                                entity = tm,
                                key = unit_key(tm),
                                dist_to_player = dist(player, tm),
                                visible = visible_or_los(tm)
                            })
                        end
                    end
                end
            end
        end

        -- 2. Reaction: Shield on Cyclops Ult
        if script.get_setting("shield_cyclops_ult") and shield_ready() then
            for i = 1, #enemies do
                local enemy = enemies[i]
                if enemy.status.hero_id == 1063 and enemy.status.is_ulting then
                    local key = enemy.key
                    local start_time = key and ult_start_times[key]
                    if start_time then
                        local age   = now - start_time
                        local delay = script.get_setting("shield_cyclops_delay_ms") or 1000
                        local fresh = not shielded_ult_instances[key] or (now - shielded_ult_instances[key]) > limit_ms
                        if age >= delay and age <= (delay + 600) and fresh then
                            if enemy.dist <= 45 and enemy.visible then
                                fire_shield(key, now)
                                return
                            end
                        end
                    end
                end
            end
        end

        -- 3. Reaction: Shield on Dr. Strange Ult
        if script.get_setting("shield_strange_ult") and shield_ready() then
            for i = 1, #enemies do
                local enemy = enemies[i]
                if enemy.status.hero_id == 1018 and enemy.status.is_ulting then
                    local key = enemy.key
                    local start_time = key and ult_start_times[key]
                    if start_time then
                        local age   = now - start_time
                        local delay = script.get_setting("shield_strange_delay_ms") or 100
                        local max_r = script.get_setting("shield_strange_range") or 15
                        local fresh = not shielded_ult_instances[key] or (now - shielded_ult_instances[key]) > limit_ms
                        if age >= delay and age <= (delay + 600) and fresh then
                            if enemy.dist <= max_r and enemy.visible then
                                fire_shield(key, now)
                                return
                            end
                        end
                    end
                end
            end
        end

        -- 4. Reaction: Shield on Wolverine Ult
        if script.get_setting("shield_wolverine_ult") and shield_ready() then
            for i = 1, #enemies do
                local enemy = enemies[i]
                if enemy.status.hero_id == 1049 and enemy.status.is_ulting then
                    local key = enemy.key
                    local start_time = key and ult_start_times[key]
                    if start_time then
                        local age   = now - start_time
                        local delay = script.get_setting("shield_wolverine_delay_ms") or 0
                        local max_r = script.get_setting("shield_wolverine_range") or 15
                        local fresh = not shielded_ult_instances[key] or (now - shielded_ult_instances[key]) > limit_ms
                        if age >= delay and age <= (delay + 600) and fresh then
                            if enemy.dist <= max_r and enemy.visible then
                                fire_shield(key, now)
                                return
                            end
                        end
                    end
                end
            end
        end

        -- 5. Reaction: Shield on Wolverine Leap
        if script.get_setting("shield_wolverine_shift") and shield_ready() then
            for i = 1, #enemies do
                local enemy = enemies[i]
                if enemy.status.hero_id == 1049 and enemy.status.is_shifting then
                    local key = enemy.key
                    local fresh = not shielded_ult_instances[key] or (now - shielded_ult_instances[key]) > limit_ms
                    if fresh then
                        local max_r = script.get_setting("shield_wolverine_shift_range") or 4
                        if enemy.dist <= max_r and enemy.visible then
                            fire_shield(key, now)
                            return
                        end
                    end
                end
            end
        end

        -- 6. Reaction: Bubble Ally on Wolverine Leap
        if script.get_setting("shield_wolverine_shift_ally") and bubble_ready() then
            for i = 1, #enemies do
                local enemy = enemies[i]
                if enemy.status.hero_id == 1049 and enemy.status.is_shifting then
                    for j = 1, #teammates do
                        local tm = teammates[j]
                        local key = tm.key
                        local fresh = not shielded_ult_instances[key] or (now - shielded_ult_instances[key]) > limit_ms
                        if fresh and not is_hela_ulting(tm.entity) then
                            local dist_enemy_to_ally = dist(enemy.entity, tm.entity)
                            local max_r = script.get_setting("shield_wolverine_shift_ally_range") or 25
                            if dist_enemy_to_ally <= 4 and tm.dist_to_player <= max_r and tm.visible then
                                fire_bubble(tm.entity, key, now)
                                return
                            end
                        end
                    end
                end
            end
        end

        -- 7. Reaction: Bubble Allies on Enemy Ults
        if script.get_setting("shield_ally_ults") and bubble_ready() then
            for i = 1, #enemies do
                local enemy = enemies[i]
                local is_cyc = enemy.status.hero_id == 1063 and enemy.status.is_ulting
                local is_str = enemy.status.hero_id == 1018 and enemy.status.is_ulting
                local is_wol = enemy.status.hero_id == 1049 and enemy.status.is_ulting
                if is_cyc or is_str or is_wol then
                    local key = enemy.key
                    local start_time = key and ult_start_times[key]
                    if start_time then
                        local age = now - start_time
                        local delay = 100
                        local max_r = 15
                        if is_cyc then
                            delay = script.get_setting("shield_cyclops_delay_ms") or 1000
                            max_r = 45
                        elseif is_str then
                            delay = script.get_setting("shield_strange_delay_ms") or 100
                            max_r = script.get_setting("shield_strange_range") or 15
                        elseif is_wol then
                            delay = script.get_setting("shield_wolverine_delay_ms") or 0
                            max_r = script.get_setting("shield_wolverine_range") or 15
                        end

                        if age >= delay and age <= (delay + 600) then
                            for j = 1, #teammates do
                                local tm = teammates[j]
                                local tkey = tm.key
                                local fresh = not shielded_ult_instances[tkey] or (now - shielded_ult_instances[tkey]) > limit_ms
                                if fresh and not is_hela_ulting(tm.entity) then
                                    local dist_ally_to_enemy = dist(tm.entity, enemy.entity)
                                    local max_team_r = script.get_setting("team_range") or 25
                                    if dist_ally_to_enemy <= max_r and tm.dist_to_player <= max_team_r and tm.visible then
                                        fire_bubble(tm.entity, tkey, now)
                                        return
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        -- 8. Reaction: Auto-Ult Eat
        if script.get_setting("auto_ult_eat") then
            local ult_ab = player:get_ability(ULT)
            if ult_ab and ult_ab:is_valid() then
                local can_cast = not ult_ab.is_activated and (
                    (ult_ab.can_activate and ult_ab:can_activate())
                    or (not ult_ab.on_cooldown and (not ult_ab.cooldown_remaining or ult_ab.cooldown_remaining <= 0))
                )

                if can_cast then
                    local best_target = nil
                    local best_d      = math.huge
                    local max_range   = script.get_setting("ult_eat_range") or 35
                    local max_age     = script.get_setting("ult_eat_max_age_ms") or 2000

                    for i = 1, #enemies do
                        local enemy = enemies[i]
                        local is_angela = enemy.status.hero_id == 1056 and script.get_setting("ult_eat_angela")
                        local is_groot = enemy.status.hero_id == 1027 and script.get_setting("ult_eat_groot")
                        if (is_angela or is_groot) and enemy.status.is_ulting and enemy.visible then
                            local key        = enemy.key
                            local start_time = key and ult_start_times[key]
                            local age        = start_time and (now - start_time) or 0
                            if age <= max_age then
                                if enemy.dist <= max_range and enemy.dist < best_d then
                                    best_target = enemy.entity
                                    best_d      = enemy.dist
                                end
                            end
                        end
                    end

                    if best_target then
                        busy = true
                        pcall(function()
                            ability_manager:activate_ability(ULT)
                        end)
                        busy = false
                    end
                end
            end
        end
    end)
end, 30)
]],
}

MODULE_DEFS[#MODULE_DEFS + 1] = {
    name = "Mantis Heal Buff",
    kind = "scanner",
    source = [[
local HEAL = Enum.AbilityType.SecondaryAttack
local BUFF = Enum.AbilityType.Ability1
local END_KEY = 35

settings = {
    { key="heal_below", label="Heal Below HP %", default=80, min=1, max=100 },
    { key="buff_below", label="Buff Below HP %", default=100, min=1, max=100 },
    { key="healed_window_ms", label="Already Healed Window MS", default=3500, min=500, max=10000 },
    { key="buff_buffer_ms", label="Same Ally Buff Buffer MS", default=5000, min=500, max=15000 },
    { key="team_range", label="Ally Range (m)", default=30, min=1, max=80 },
    { key="include_shield", label="Include Shield", default=true },
    { key="repeat_wait", label="Repeat Wait MS", default=100, min=0, max=1000 },
    { key="scan_ms", label="Scan MS", default=100, min=10, max=1000 },
    { key="aim_fov", label="Aim FOV", default=360, min=1, max=360 },
    { key="flick_ms", label="Flick MS", default=900, min=100, max=2500 },
}

local scan_active = false
local scanner_id = nil
local scan_busy = false
local healed_until = {}
local buffed_until = {}
local last_cast = {
    [HEAL] = 0,
    [BUFF] = 0
}

local flick_cfg = {
    use_prediction = false,
    cancel_aiming_away = false,
    always_fire = false,
    duration = 900,
    aim_points = { Enum.AimPoint.Body }
}

local ally_cfg = {
    aim_fov = 360,
    dynamic_fov = true,
    ignore_invisible = false,
    ignore_shield = true,
    ignore_team = false,
    ignore_enemy = true,
    max_distance = 30
}

local function num(key, fallback)
    local value = script.get_setting(key)
    if type(value) ~= "number" then return fallback end
    return math.floor(value)
end

local function bool(key, fallback)
    local value = script.get_setting(key)
    if value == nil then return fallback end
    return value == true
end

local function valid_player(player)
    return player and player:is_valid() and not player.is_dead
end

local function valid_ally(ally)
    return ally and ally:is_valid() and not ally.is_dead and not ally:is_enemy()
end

local function distance(a, b)
    if not a or not b or not a.location or not b.location then return math.huge end
    return a.location:get_distance_to(b.location) * 0.01
end

local function hp_pct(unit)
    if not unit then return 100 end

    local hp = unit.health or 0
    if bool("include_shield", true) then
        hp = hp + (unit.shield or 0)
    end

    local max_hp = unit.max_health or 0
    if max_hp <= 0 then return 100 end

    return (hp / max_hp) * 100
end

local function ally_key(ally)
    return ally.id or tostring(ally)
end

local function ability_ready(player, ability)
    if not valid_player(player) then return false end

    local ab = player:get_ability(ability)
    if not ab or not ab:is_valid() then return false end
    if ab.on_cooldown then return false end
    if ab.is_activated then return false end
    if ab.cooldown_remaining and ab.cooldown_remaining > 0 then return false end

    return ability_manager:can_activate_ability(ability)
end

local function buff_name_matches(name)
    if type(name) ~= "string" then return false end

    local lower = string.lower(name)
    return string.find(lower, "heal") ~= nil
        or string.find(lower, "flower") ~= nil
        or string.find(lower, "mantis") ~= nil
end

local function has_runtime_heal_buff(ally)
    if ally.has_buff then
        local checks = { "heal", "healing", "healing flower", "mantis" }
        for i = 1, #checks do
            local ok, result = pcall(function() return ally:has_buff(checks[i]) end)
            if ok and result == true then return true end
        end
    end

    if ally.get_buffs then
        local ok, buffs = pcall(function() return ally:get_buffs() end)
        if ok and buffs then
            for i = 1, #buffs do
                local buff = buffs[i]
                local name = buff and (buff.name or buff.id or buff:get_name())
                if buff_name_matches(name) then return true end
            end
        end
    end

    return false
end

local function already_healed(ally, now)
    local until_time = healed_until[ally_key(ally)] or 0
    if now < until_time then return true end
    return has_runtime_heal_buff(ally)
end

local function remember_heal(ally, now)
    healed_until[ally_key(ally)] = now + (num("healed_window_ms", 3500) * 0.001)
end

local function can_buff_ally(ally, now)
    return now >= (buffed_until[ally_key(ally)] or 0)
end

local function remember_buff(ally, now)
    buffed_until[ally_key(ally)] = now + (num("buff_buffer_ms", 5000) * 0.001)
end

local function find_ally_target(player)
    local allies = object_manager.get_players(false)
    if not allies then return nil, 100 end

    local best = nil
    local best_hp = 101
    local range = num("team_range", 30)

    for i = 1, #allies do
        local ally = allies[i]
        if ally and ally ~= player and valid_ally(ally) and distance(player, ally) <= range then
            local hp = hp_pct(ally)
            if hp < best_hp then
                best = ally
                best_hp = hp
            end
        end
    end

    return best, best_hp
end

local function flick_to_ally(ally, ability)
    if not valid_ally(ally) then return false end

    -- Check if Mantis aim is enabled
    local mantis_aim_enabled = script.get_setting("mantis_aim_enabled")
    if mantis_aim_enabled == false then
        return true -- Skip aiming entirely
    end

    local use_flickbot = script.get_setting("mantis_flick_enabled")
    local reverse_aim_control = script.get_setting("mantis_reverse_aim_control")
    local gate_fov = script.get_setting("mantis_gate_fov") or 180
    local aim_fov = script.get_setting("mantis_aim_fov") or 360
    local flickbot_fov = script.get_setting("mantis_flickbot_fov") or 90
    
    -- Mantis Flick has priority - if enabled, use flickbot with flickbot_fov
    if use_flickbot == true then
        ally_cfg.aim_fov = flickbot_fov
    else
        -- If reverse aim control is enabled, check gate FOV
        if reverse_aim_control == true then
            local in_fov = false
            if ally and ally.get_fov_to_target then
                local ok, fov = pcall(function()
                    return ally:get_fov_to_target()
                end)
                if ok and fov then
                    in_fov = math.abs(fov) > gate_fov
                end
            end
            
            if in_fov then
                use_flickbot = false
            else
                use_flickbot = true
            end
        else
            -- If reverse aim control is disabled, just use look_at (no flickbot)
            use_flickbot = false
        end
    end
    
    if use_flickbot and flickbot and flickbot.perform then
        flick_cfg.duration = num("flick_ms", 900)
        ally_cfg.max_distance = num("team_range", 30)

        flickbot.perform(
            ally,
            ability,
            flick_cfg,
            ally_cfg,
            Enum.AbilityWait.None
        )
    else
        local saved_rotation = camera.get_rotation()
        if not saved_rotation then return false end

        local saved_pitch = saved_rotation.pitch
        local saved_yaw = saved_rotation.yaw

        local aimed = pcall(function()
            camera.look_at(ally.location)
        end)

        if not aimed then
            return false
        end

        -- Invert pitch AFTER look_at
        local new_rotation = camera.get_rotation()
        if new_rotation and new_rotation.pitch and new_rotation.yaw then
            pcall(function()
                camera.set_rotation(-new_rotation.pitch, new_rotation.yaw)
            end)
        end

        wait(500)

        local cast_ok = pcall(function()
            ability_manager:activate_ability(ability)
        end)

        if not cast_ok then
            return false
        end

        wait(1000)
    end

    return true
end

local function cast_on_ally(player, ally, ability, now)
    if now - (last_cast[ability] or 0) < 0.15 then return false end
    if not ability_ready(player, ability) then return false end
    if not flick_to_ally(ally, ability) then return false end

    last_cast[ability] = now
    return true
end

local function scan_once(ctx)
    if scan_busy then return false end
    scan_busy = true

    ctx = ctx or {}
    local player = ctx.player or object_manager.get_local_player()
    if not valid_player(player) then scan_busy = false return false end

    local ally, hp = find_ally_target(player)
    if not ally then scan_busy = false return false end

    local now = os.clock()
    local heal_below = num("heal_below", 80)
    local buff_below = num("buff_below", 100)

    if hp <= heal_below then
        if already_healed(ally, now) then
            if can_buff_ally(ally, now) and cast_on_ally(player, ally, BUFF, now) then
                remember_buff(ally, now)
            end
        elseif cast_on_ally(player, ally, HEAL, now) then
            remember_heal(ally, now)
        end
    elseif hp <= buff_below and already_healed(ally, now) then
        if can_buff_ally(ally, now) and cast_on_ally(player, ally, BUFF, now) then
            remember_buff(ally, now)
        end
    end

    wait(num("repeat_wait", 100))
    scan_busy = false
    return true
end

local function start_scanner()
    if scanner_id then return true end

    scanner_id = timer.set_interval(function()
        if input.is_key_down(END_KEY) then
            scan_active = false
            return
        end

        if scan_active then
            scan_once(nil)
        end
    end, num("scan_ms", 100))

    return true
end

function on_activate_combo(ctx)
    start_scanner()
    scan_active = true
    return true
end

function on_deactivate_combo(ctx)
    -- End key stops the scanner.
end

start_scanner()

]],
}

MODULE_DEFS[#MODULE_DEFS + 1] = {
    name = "AutoOverhead",
    kind = "scanner",
    source = [[
local SPIDERMAN_HERO_ID = 1036
local PRIMARY = Enum.AbilityType.PrimaryAttack
local JUMP = Enum.AbilityType.Jump
local END_KEY = 35
local LMB_KEY = Enum.MouseButton and Enum.MouseButton.Left or "LButton"

local SCAN_MS = 25
local OVERHEAD_WAIT_MS = 300
local JUMP_HOLD_MS = 1
local PRIMARY_HOLD_MS = 1
local AUTO_OVERHEAD_RANGE_M = 4

settings = {}

local scan_active = false
local scanner_id = nil
local busy = false
local last_lmb_down = false

local function valid_player(player)
    return player ~= nil and player:is_valid() and not player.is_dead
end

local function get_hero_id(player)
    if player == nil then return nil end

    if player.get_hero_id ~= nil then
        local ok, id = pcall(function()
            return player:get_hero_id()
        end)
        if ok and id ~= nil then return id end
    end

    return player.hero_id
end

local function is_spiderman(player)
    return valid_player(player) and get_hero_id(player) == SPIDERMAN_HERO_ID
end

local function key_down(key)
    if not input or not input.is_key_down then return false end
    local ok, down = pcall(function()
        return input.is_key_down(key)
    end)
    return ok and down == true
end

local function valid_enemy(enemy)
    return enemy ~= nil and enemy:is_valid() and not enemy.is_dead and enemy:is_enemy() and enemy.location ~= nil
end

local function distance_m(player, enemy)
    if player == nil or enemy == nil or player.location == nil or enemy.location == nil then return math.huge end

    if player.location.get_distance_to_meters then
        return player.location:get_distance_to_meters(enemy.location)
    end

    return player.location:get_distance_to(enemy.location) * 0.01
end

-- Closest valid enemy within overhead-slam range, or nil if none.
local function find_close_enemy(player)
    if not valid_player(player) then return nil end

    local enemies = object_manager and object_manager.get_players and object_manager.get_players(true)
    if type(enemies) ~= "table" then return nil end

    local best = nil
    local best_dist = math.huge
    for i = 1, #enemies do
        local enemy = enemies[i]
        if valid_enemy(enemy) then
            local dist = distance_m(player, enemy)
            if dist <= AUTO_OVERHEAD_RANGE_M and dist < best_dist then
                best = enemy
                best_dist = dist
            end
        end
    end

    return best
end

local function is_grounded(player)
    if player == nil then return false end

    if player.is_grounded ~= nil then
        if type(player.is_grounded) == "function" then
            local ok, grounded = pcall(function()
                return player:is_grounded()
            end)
            return ok and grounded == true
        end

        return player.is_grounded == true
    end

    if player.is_on_ground ~= nil then
        if type(player.is_on_ground) == "function" then
            local ok, grounded = pcall(function()
                return player:is_on_ground()
            end)
            return ok and grounded == true
        end

        return player.is_on_ground == true
    end

    return false
end

local function cast(ability_type, hold_ms)
    if ability_manager == nil or ability_manager.activate_ability == nil then return false end

    local ok = pcall(function()
        ability_manager:activate_ability(ability_type, hold_ms or 1)
    end)

    return ok == true
end

-- Aim-assisted primary attack via the shared flickbot helper (Elsa-style
-- aim-to-target instead of a plain camera.look_at).
local function flick_primary(target)
    if not target or target.is_dead then return false end
    if not (flickbot and flickbot.perform) then return false end

    local flick_cfg = {
        use_prediction = false,
        cancel_aiming_away = false,
        always_fire = false,
        duration = 300,
        aim_points = { Enum.AimPoint.Head },
    }

    local target_cfg = {
        aim_fov = 60,
        dynamic_fov = true,
        ignore_invisible = true,
        ignore_shield = false,
        ignore_team = true,
        ignore_enemy = false,
        max_distance = AUTO_OVERHEAD_RANGE_M * 100,
    }

    local ok = pcall(function()
        flickbot.perform(target, PRIMARY, flick_cfg, target_cfg, Enum.AbilityWait.None)
    end)

    return ok == true
end

-- if player is on the ground: jump -> jump -> primary -> wait 300ms -> flickbot primary
-- if player is not on the ground: jump -> primary -> wait 300ms -> flickbot primary
local function run_overhead_slam(player, target)
    if busy then return false end
    busy = true

    if is_grounded(player) then
        cast(JUMP, JUMP_HOLD_MS)
        cast(JUMP, JUMP_HOLD_MS)
        cast(PRIMARY, PRIMARY_HOLD_MS)
        wait(OVERHEAD_WAIT_MS)
        flick_primary(target)
    else
        cast(JUMP, JUMP_HOLD_MS)
        cast(PRIMARY, PRIMARY_HOLD_MS)
        wait(OVERHEAD_WAIT_MS)
        flick_primary(target)
    end

    busy = false
    return true
end

-- LMB is the trigger: while an enemy is within range, pressing LMB fires
-- the overhead slam sequence instead of a plain primary attack.
local function scan_once()
    local player = object_manager and object_manager.get_local_player and object_manager.get_local_player()
    if not is_spiderman(player) then
        last_lmb_down = false
        return false
    end

    local down = key_down(LMB_KEY)

    if down and not last_lmb_down then
        local target = find_close_enemy(player)
        if target then
            run_overhead_slam(player, target)
        end
    end

    last_lmb_down = down
    return true
end

local function start_scanner()
    if scanner_id ~= nil then return true end

    scanner_id = timer.set_interval(function()
        if input and input.is_key_down and input.is_key_down(END_KEY) then
            scan_active = false
            return
        end

        if scan_active then
            scan_once()
        end
    end, SCAN_MS)

    return true
end

function on_activate_combo(ctx)
    start_scanner()
    scan_active = true
    return true
end

function on_deactivate_combo(ctx)
    -- End key stops the scanner.
end

]],
}

MODULE_DEFS[#MODULE_DEFS + 1] = {
    name = "HulkSpaceHold",
    kind = "scanner",
    source = [[
local HULK_HERO_ID = 1011
local SPACE_KEY = Enum.Key.Space
local SCAN_MS = script.get_setting("scan_poll_ms") or 100
local END_KEY = 35

settings = {}

local scan_active = false
local scanner_id = nil
local space_held_by_us = false
local user_pressed_space = false

local function valid_player(player)
    return player and (not player.is_dead) and (not player.is_valid or player:is_valid())
end

local function get_hero_id(player)
    if not player then return nil end
    if player.get_hero_id then
        local ok, id = pcall(function()
            return player:get_hero_id()
        end)
        if ok and id then return id end
    end
    return player.hero_id
end

local function is_hulk(player)
    return valid_player(player) and get_hero_id(player) == HULK_HERO_ID
end

-- Best-guess field/method names for "is on the ground"
local function is_grounded(player)
    if not player then return false end

    if player.is_grounded ~= nil then
        if type(player.is_grounded) == "function" then
            local ok, grounded = pcall(function()
                return player:is_grounded()
            end)
            return ok and grounded == true
        end
        return player.is_grounded == true
    end

    if player.is_on_ground ~= nil then
        if type(player.is_on_ground) == "function" then
            local ok, grounded = pcall(function()
                return player:is_on_ground()
            end)
            return ok and grounded == true
        end
        return player.is_on_ground == true
    end

    return false
end

local function press_space()
    if space_held_by_us then return end
    if not input or not input.press_key then return end
    input.press_key(SPACE_KEY)
    space_held_by_us = true
end

local function release_space()
    if not space_held_by_us then return end
    if not input or not input.release_key then return end
    input.release_key(SPACE_KEY)
    space_held_by_us = false
end

local function scan_once()
    local player = object_manager and object_manager.get_local_player and object_manager.get_local_player()

    if not is_hulk(player) then
        release_space()
        user_pressed_space = false
        return
    end

    if input and input.is_key_down and input.is_key_down(END_KEY) then
        scan_active = false
        release_space()
        user_pressed_space = false
        return
    end

    -- Check if user is pressing space
    local player_holds_space = false
    if input and input.is_key_down then
        local ok, down = pcall(function() return input.is_key_down(SPACE_KEY) end)
        player_holds_space = ok and down == true
    end

    -- If user presses space, mark it and release our hold
    if player_holds_space and not space_held_by_us then
        user_pressed_space = true
        return
    end

    -- If user is holding space (they pressed it), release our hold
    if player_holds_space and space_held_by_us then
        release_space()
        return
    end

    -- If user released space and we're back on ground, hold space again
    if not player_holds_space and user_pressed_space and is_grounded(player) then
        press_space()
        user_pressed_space = false
        return
    end

    -- Initial condition: if Hulk is on ground and user hasn't pressed space, hold space
    if is_grounded(player) and not user_pressed_space then
        press_space()
    end
end

local function start_scanner()
    if scanner_id ~= nil then return true end

    scanner_id = timer.set_interval(function()
        if scan_active then
            scan_once()
        end
    end, SCAN_MS)

    return true
end

function on_activate_combo(ctx)
    start_scanner()
    scan_active = true
    user_pressed_space = false
    return true
end

function on_deactivate_combo(ctx)
    scan_active = false
    user_pressed_space = false
    release_space()
    if scanner_id then
        timer.clear(scanner_id)
        scanner_id = nil
    end
end

]],
}

MODULE_DEFS[#MODULE_DEFS + 1] = {
    name = "Spiderman Dynamic",
    kind = "combo",
    source = [[
-- Spider-Man combined dynamic route combo with YOYO + HP-based routes.
--
-- Route priority:
-- 1) YOYO route if player is 5m+ above any valid enemy.
--    This has highest precedence over ALL other routes.
--
-- 2) SEKKOMBO route if opener target effective HP <= LOW_HP_EFFECTIVE_HP_THRESHOLD:
--    SECONDARY -> confirm SpidermanMark -> ABILITY1 -> PRIMARY
--    -> SECONDARY -> confirm SpidermanMark -> optional jumps -> ABILITY3
--
-- 3) HYDRO route if opener target effective HP > 250 and <= 350:
--    SECONDARY -> confirm SpidermanMark -> ABILITY1 -> PRIMARY
--    -> SECONDARY -> confirm SpidermanMark -> R -> PRIMARY
--    -> SECONDARY -> confirm SpidermanMark -> ABILITY3
--
-- 4) HIGH-HP route if opener target effective HP > HIGH_HP_EFFECTIVE_HP_THRESHOLD:
--    TRACER -> PULL -> PRIMARY -> TRACER -> DOUBLE JUMP -> PRIMARY -> TRACER -> UPPERCUT
--    -> HOLD TRACER -> ABILITY2 -> PRIMARY
--
-- Optional setting:
-- Hydro <=350 HP override sends all targets at 350 effective HP or less to Hydro.
--
-- Dynamic polling:
-- All Primary/Punch and Uppercut steps poll up to 1500ms for any enemy
-- to enter range/FOV before failing.

settings = {
    {
        key = "jump_route_mode",
        label = "Jump Route Mode",
        tooltip = "1 = jumps only, 2 = no jumps only, 3 = jumps except Jeff.",
        default = 3,
        min = 1,
        max = 3
    },

    {
        key = "hydro_low_hp_override",
        label = "Hydro <=350 HP",
        tooltip = "Use Hydro instead of Sekkombo for targets at 350 effective HP or less.",
        default = false
    },
}

local TRACER   = Enum.AbilityType.SecondaryAttack
local PULL     = Enum.AbilityType.Ability1
local PUNCH    = Enum.AbilityType.PrimaryAttack
local UPPERCUT = Enum.AbilityType.Ability3
local ABILITY2 = Enum.AbilityType.Ability2
local JUMP     = Enum.AbilityType.Jump

local R_KEY = Enum.Key.R or "R"

local ROUTE_YOYO    = "yoyo"
local ROUTE_SEKKOMBO = "sekkombo"
local ROUTE_HIGH_HP = "high_hp"
local ROUTE_HYDRO   = "hydro"

local JUMP_ROUTE_JUMPS_ONLY = 1
local JUMP_ROUTE_NO_JUMPS_ONLY = 2
local JUMP_ROUTE_JUMPS_EXCEPT_JEFF = 3

-- Fill this in once we confirm Jeff's hero_id in this Lua runtime.
local JEFF_HERO_ID = nil

local BUFF_BUBBLED = Enum.Buff and Enum.Buff.Bubbled
local BUFF_STUNNED = Enum.Buff and Enum.Buff.Stunned
local BUFF_DIAMOND_FORM = Enum.Buff and Enum.Buff.DiamondForm
local BUFF_KIDNAPPED = Enum.Buff and Enum.Buff.Kidnapped
local BUFF_SPIDERMAN_MARK = Enum.Buff and Enum.Buff.SpidermanMark

local AIM_FOV = 45

-- Shared aligned ranges.
local RANGE_TRACER   = 20
local RANGE_PULL     = 20
local RANGE_PUNCH    = 6
local RANGE_SEKKOMBO_PUNCH = 4
local RANGE_UPPERCUT = 5
local RANGE_ABILITY2 = 20

-- Route HP thresholds use current effective HP, not max HP.
-- effective HP = health + shield
local LOW_HP_EFFECTIVE_HP_THRESHOLD  = 250
local HIGH_HP_EFFECTIVE_HP_THRESHOLD = 350

-- YOYO trigger.
-- This is NOT using player.is_grounded.
-- It checks whether player is physically above an enemy by this many meters.
local YOYO_HEIGHT_ADVANTAGE_METERS = 5
local YOYO_TRIGGER_RANGE = 20

-- R route timings.
local WITH_R_TRACER_TO_PULL_DELAY_MS           = 100
local WITH_R_PULL_TO_PUNCH_DELAY_MS            = 950
local WITH_R_PUNCH1_TO_TRACER_DELAY_MS         = 200
local WITH_R_TRACER_TO_R_DELAY_MS              = 200
local WITH_R_R_TO_PUNCH_DELAY_MS               = 50
local WITH_R_PUNCH2_TO_TRACER_DELAY_MS         = 200
local WITH_R_TRACER_TO_UPPERCUT_DELAY_MS       = 120

local R_HOLD_MS = 1

-- Sekkombo route timings.
local SEKKOMBO_PULL_TO_PRIMARY_START_DELAY_MS    = 950
local SEKKOMBO_PRIMARY_TO_TRACER_DELAY_MS        = 185
local SEKKOMBO_TRACER_TO_UPPERCUT_START_DELAY_MS = 100
local SEKKOMBO_JUMP_HOLD_MS                      = 1
local SEKKOMBO_JUMP_DELAY_MS                     = 200

-- Buff / mark polling.
local BUFF_CHECK_STEP_MS = 20
local TRACER_MARK_CONFIRM_MAX_WAIT_MS = 100
local TRACER_MARK_CHECK_STEP_MS = 10
local TRACER_RETRY_DELAY_MS = 50
local TRACER_MAX_ATTEMPTS = 3

-- ===========================================================================
-- YOYO route timings (Updated Dynamic Cancel Version)
-- ===========================================================================
local YOYO_PULL_TO_JUMP_DELAY_MS             = 225  
local YOYO_JUMP_HOLD_MS                      = 25   
local YOYO_PULL_MAX_WAIT_MS                  = 1500 
local YOYO_RANGE_CHECK_STEP_MS               = 20   
local YOYO_INTRA_CAST_MAX_WAIT_MS            = 1500 

local YOYO_OPENER_SWING_HOLD_MS              = 10   
local YOYO_OPENER_SWING_TO_TRACER_DELAY_MS   = 100  
local YOYO_OPENER_TRACER_HOLD_MS             = 800  
local YOYO_OPENER_TRACER_TO_UPPERCUT_DELAY_MS= 300  

local YOYO_POST_UPPERCUT_DELAY_MS            = 300  
local YOYO_POST_UPPERCUT_TRACER_HOLD_MS      = 500  
local YOYO_TIGHT_PLINK_DELAY_MS              = 20   
local YOYO_POST_UPPERCUT_SWING_HOLD_MS       = 10   
local YOYO_SWING_TO_PUNCH_DELAY_MS           = 425  
local YOYO_PUNCH_HOLD_MS                     = 200  
-- ===========================================================================

-- HIGH-HP route timings
local HIGH_HP_NEW_DELAY_MS                     = 250
local HIGH_HP_TRACER_TO_PULL_DELAY_MS          = 115
local HIGH_HP_PULL_TO_PUNCH1_DELAY_MS          = 950
local HIGH_HP_PUNCH1_TO_TRACER2_DELAY_MS       = 200
local HIGH_HP_TRACER2_TO_JUMP1_DELAY_MS        = 10
local HIGH_HP_JUMP1_TO_JUMP2_DELAY_MS          = 100
local HIGH_HP_JUMP2_TO_OVERHEAD_DELAY_MS       = 325
local HIGH_HP_OVERHEAD_TO_TRACER3_DELAY_MS     = 750
local HIGH_HP_TRACER3_TO_UPPERCUT_DELAY_MS     = 120
local HIGH_HP_UPPERCUT_TO_TRACER_DELAY_MS      = 100
local HIGH_HP_TRACER_HOLD_MS                   = 750
local HIGH_HP_TRACER_HOLD_TO_ABILITY2_DELAY_MS = 250
local HIGH_HP_ABILITY2_HOLD_MS                 = 1

-- High-HP route stricter cancel check.
local HIGH_HP_CANCEL_AIM_FOV = 6
local HIGH_HP_CANCEL_RANGE = 4

-- Dynamic polling for short-range attacks (Standard Routes).
local PRIMARY_MAX_WAIT_MS  = 1500
local UPPERCUT_MAX_WAIT_MS = 1500
local RANGE_CHECK_STEP_MS  = 5

local AIM_BEFORE_CAST = false

-- ---------------------------------------------------------------------------
-- Combo state guard
-- ---------------------------------------------------------------------------

local active_combo_id = 0

local function start_new_combo()
    active_combo_id = active_combo_id + 1
    return active_combo_id
end

local function combo_is_current(combo_id)
    return combo_id == active_combo_id
end

local function stop_combo(combo_id)
    if combo_is_current(combo_id) then
        active_combo_id = active_combo_id + 1
    end
end

local function schedule(combo_id, delay_ms, callback)
    if not combo_is_current(combo_id) then
        return nil
    end

    if delay_ms == nil or delay_ms <= 0 then
        callback()
        return nil
    end

    return timer.set_timeout(function()
        if not combo_is_current(combo_id) then
            return
        end

        callback()
    end, delay_ms)
end

-- ---------------------------------------------------------------------------
-- Basic helpers
-- ---------------------------------------------------------------------------

local function get_distance(player, target)
    return player.location:get_distance_to(target.location) * 0.01
end

local function get_vertical_delta_meters(player, target)
    if player == nil or target == nil then
        return 0
    end

    if player.location == nil or target.location == nil then
        return 0
    end

    return (player.location.z - target.location.z) * 0.01
end

local function valid_player(player)
    return player ~= nil
        and player:is_valid()
        and not player.is_dead
end

local function valid_enemy_basic(enemy)
    return enemy ~= nil
        and enemy:is_valid()
        and not enemy.is_dead
        and enemy:is_enemy()
end

local function cfg(key, default_value)
    if script ~= nil and script.get_setting ~= nil then
        local value = script.get_setting(key)

        if type(value) == "number" or type(value) == "boolean" then
            return value
        end
    end

    return default_value
end

local function get_jump_route_mode()
    local mode = cfg("jump_route_mode", JUMP_ROUTE_JUMPS_EXCEPT_JEFF)

    if type(mode) ~= "number" then
        return JUMP_ROUTE_JUMPS_EXCEPT_JEFF
    end

    mode = math.floor(mode + 0.5)

    if mode < JUMP_ROUTE_JUMPS_ONLY or mode > JUMP_ROUTE_JUMPS_EXCEPT_JEFF then
        return JUMP_ROUTE_JUMPS_EXCEPT_JEFF
    end

    return mode
end

local function hydro_low_hp_override_enabled()
    return cfg("hydro_low_hp_override", false) == true
end

local function get_hero_id(target)
    if target == nil then
        return nil
    end

    if target.get_hero_id ~= nil then
        local ok, id = pcall(function()
            return target:get_hero_id()
        end)

        if ok and id ~= nil then
            return id
        end
    end

    return target.hero_id
end

local function get_hero_name(target)
    return tostring((target and (target.hero_name or target.name)) or "")
end

local function target_is_jeff(target)
    local id = get_hero_id(target)

    if JEFF_HERO_ID ~= nil and id == JEFF_HERO_ID then
        return true
    end

    local name = string.lower(get_hero_name(target))

    return string.find(name, "jeff", 1, true) ~= nil
        or string.find(name, "land shark", 1, true) ~= nil
end

local function character_has_buff(target, buff_type)
    if target == nil or buff_type == nil or target.has_buff == nil then
        return false
    end

    local ok, has_buff = pcall(function()
        return target:has_buff(buff_type)
    end)

    return ok and has_buff == true
end

local function target_has_cast_wait_buff(target)
    return character_has_buff(target, BUFF_BUBBLED)
        or character_has_buff(target, BUFF_STUNNED)
        or character_has_buff(target, BUFF_DIAMOND_FORM)
        or character_has_buff(target, BUFF_KIDNAPPED)
end

local function target_has_spiderman_mark(target)
    return character_has_buff(target, BUFF_SPIDERMAN_MARK)
end

local function wait_until_target_ready(target)
    while valid_enemy_basic(target) and target_has_cast_wait_buff(target) do
        wait(BUFF_CHECK_STEP_MS)
    end

    return valid_enemy_basic(target)
end

local function should_use_sekkombo_jumps(target)
    local mode = get_jump_route_mode()

    if mode == JUMP_ROUTE_JUMPS_ONLY then
        return true
    end

    if mode == JUMP_ROUTE_NO_JUMPS_ONLY then
        return false
    end

    return not target_is_jeff(target)
end

local function target_in_custom_fov_and_range(player, target, max_range, max_fov)
    if not valid_player(player) then
        return false
    end

    if not valid_enemy_basic(target) then
        return false
    end

    local fov = target:get_fov_to_target()
    if fov == nil or fov > max_fov then
        return false
    end

    if get_distance(player, target) > max_range then
        return false
    end

    return true
end

local function target_in_fov_and_range(player, target, max_range)
    return target_in_custom_fov_and_range(player, target, max_range, AIM_FOV)
end

local function get_effective_hp(target)
    if target == nil or target.health == nil then
        return nil
    end

    return target.health + (target.shield or 0)
end

local function is_low_effective_hp_target(target)
    local hp = get_effective_hp(target)

    return hp ~= nil and hp <= LOW_HP_EFFECTIVE_HP_THRESHOLD
end

local function is_high_effective_hp_target(target)
    local hp = get_effective_hp(target)

    return hp ~= nil and hp > HIGH_HP_EFFECTIVE_HP_THRESHOLD
end

-- ---------------------------------------------------------------------------
-- Dynamic target + aiming
-- ---------------------------------------------------------------------------

local function find_dynamic_target_custom(player, max_range, max_fov)
    if not valid_player(player) then
        return nil
    end

    if object_manager == nil or object_manager.get_players == nil then
        return nil
    end

    local enemies = object_manager.get_players(true)

    if enemies == nil then
        return nil
    end

    local best_enemy = nil
    local best_distance = nil

    for _, enemy in ipairs(enemies) do
        if target_in_custom_fov_and_range(player, enemy, max_range, max_fov) then
            local distance = get_distance(player, enemy)

            if best_enemy == nil or distance < best_distance then
                best_enemy = enemy
                best_distance = distance
            end
        end
    end

    return best_enemy
end

local function find_dynamic_target(player, max_range)
    return find_dynamic_target_custom(player, max_range, AIM_FOV)
end

local function has_dynamic_target_custom(player, max_range, max_fov)
    return find_dynamic_target_custom(player, max_range, max_fov) ~= nil
end

local function target_matches_yoyo_height(player, target)
    if not target_in_fov_and_range(player, target, YOYO_TRIGGER_RANGE) then
        return false
    end

    return get_vertical_delta_meters(player, target) >= YOYO_HEIGHT_ADVANTAGE_METERS
end

local function find_yoyo_target(player, fallback_target)
    if not valid_player(player) then
        return nil
    end

    if target_matches_yoyo_height(player, fallback_target) then
        return fallback_target
    end

    if object_manager == nil or object_manager.get_players == nil then
        return nil
    end

    local enemies = object_manager.get_players(true)

    if enemies == nil then
        return nil
    end

    local best_enemy = nil
    local best_distance = nil

    for _, enemy in ipairs(enemies) do
        if target_matches_yoyo_height(player, enemy) then
            local distance = get_distance(player, enemy)

            if best_enemy == nil or distance < best_distance then
                best_enemy = enemy
                best_distance = distance
            end
        end
    end

    return best_enemy
end

local function get_route_target(player, fallback_target)
    if target_in_fov_and_range(player, fallback_target, RANGE_TRACER) then
        return fallback_target
    end

    return find_dynamic_target(player, RANGE_TRACER)
end

local function choose_route_for_target(target)
    local hp = get_effective_hp(target)

    if hp == nil then
        return ROUTE_HYDRO
    end

    if hp > HIGH_HP_EFFECTIVE_HP_THRESHOLD then
        return ROUTE_HIGH_HP
    end

    if hydro_low_hp_override_enabled() then
        return ROUTE_HYDRO
    end

    if is_low_effective_hp_target(target) then
        return ROUTE_SEKKOMBO
    end

    return ROUTE_HYDRO
end

local function aim_at_target(target)
    return
end

-- ---------------------------------------------------------------------------
-- Cast helpers
-- ---------------------------------------------------------------------------

local function cast_if_fov_and_range(player, target, ability, range)
    if not target_in_fov_and_range(player, target, range) then
        return false
    end

    if not wait_until_target_ready(target) then
        return false
    end

    if not target_in_fov_and_range(player, target, range) then
        return false
    end

    aim_at_target(target)
    ability_manager:activate_ability(ability)
    return true
end

local function cast_if_any_enemy_in_range(player, ability, range)
    local dynamic_target = find_dynamic_target(player, range)

    if dynamic_target == nil then
        return false
    end

    if not wait_until_target_ready(dynamic_target) then
        return false
    end

    if not target_in_fov_and_range(player, dynamic_target, range) then
        return false
    end

    aim_at_target(dynamic_target)
    ability_manager:activate_ability(ability)
    return true
end

local function wait_for_spiderman_mark(combo_id, target)
    local elapsed_ms = 0

    while elapsed_ms <= TRACER_MARK_CONFIRM_MAX_WAIT_MS do
        if not combo_is_current(combo_id) then
            return false
        end

        if not valid_enemy_basic(target) then
            return false
        end

        if target_has_spiderman_mark(target) then
            return true
        end

        wait(TRACER_MARK_CHECK_STEP_MS)
        elapsed_ms = elapsed_ms + TRACER_MARK_CHECK_STEP_MS
    end

    return false
end

local function cast_tracer_until_mark(combo_id, player, target)
    local attempts = 0

    while combo_is_current(combo_id) and attempts < TRACER_MAX_ATTEMPTS do
        if not target_in_fov_and_range(player, target, RANGE_TRACER) then
            return false
        end

        if not wait_until_target_ready(target) then
            return false
        end

        if not target_in_fov_and_range(player, target, RANGE_TRACER) then
            return false
        end

        aim_at_target(target)
        ability_manager:activate_ability(TRACER)

        if wait_for_spiderman_mark(combo_id, target) then
            return true
        end

        attempts = attempts + 1
        wait(TRACER_RETRY_DELAY_MS)
    end

    return false
end

local function cast_tracer_on_any_enemy_until_mark(combo_id, player)
    local dynamic_target = find_dynamic_target(player, RANGE_TRACER)

    if dynamic_target == nil then
        return false
    end

    return cast_tracer_until_mark(combo_id, player, dynamic_target)
end

local function wait_for_any_enemy_then_cast(combo_id, player, ability, range, max_wait_ms, on_success, on_fail)
    local elapsed_ms = 0
    local interval_id = nil

    local function try_cast()
        if not combo_is_current(combo_id) then
            if interval_id ~= nil then timer.clear(interval_id) end
            return true
        end

        if not valid_player(player) then
            if interval_id ~= nil then timer.clear(interval_id) end
            if on_fail ~= nil then on_fail() end
            return true
        end

        local dynamic_target = find_dynamic_target(player, range)

        if dynamic_target ~= nil then
            if interval_id ~= nil then timer.clear(interval_id) end

            if not wait_until_target_ready(dynamic_target) then
                if on_fail ~= nil then on_fail() end
                return true
            end

            if not target_in_fov_and_range(player, dynamic_target, range) then
                if on_fail ~= nil then on_fail() end
                return true
            end

            aim_at_target(dynamic_target)
            ability_manager:activate_ability(ability)

            if on_success ~= nil then on_success(dynamic_target) end
            return true
        end

        return false
    end

    if try_cast() then return end

    interval_id = timer.set_interval(function()
        if try_cast() then return end

        elapsed_ms = elapsed_ms + RANGE_CHECK_STEP_MS

        if elapsed_ms >= max_wait_ms then
            timer.clear(interval_id)

            if on_fail ~= nil then
                on_fail()
            end
        end
    end, RANGE_CHECK_STEP_MS)
end

local function wait_for_enemy_in_range(combo_id, player, range, max_wait_ms, on_success, on_fail)
    local elapsed_ms = 0
    local interval_id = nil

    local function check()
        if not combo_is_current(combo_id) then
            if interval_id ~= nil then timer.clear(interval_id) end
            return true
        end

        if not valid_player(player) then
            if interval_id ~= nil then timer.clear(interval_id) end
            if on_fail ~= nil then on_fail() end
            return true
        end

        local dynamic_target = find_dynamic_target(player, range)
        if dynamic_target ~= nil then
            if interval_id ~= nil then timer.clear(interval_id) end

            if not wait_until_target_ready(dynamic_target) then
                if on_fail ~= nil then on_fail() end
                return true
            end

            if not target_in_fov_and_range(player, dynamic_target, range) then
                if on_fail ~= nil then on_fail() end
                return true
            end

            if on_success ~= nil then on_success(dynamic_target) end
            return true
        end
        return false
    end

    if check() then return end

    interval_id = timer.set_interval(function()
        if check() then return end

        elapsed_ms = elapsed_ms + YOYO_RANGE_CHECK_STEP_MS
        if elapsed_ms >= max_wait_ms then
            timer.clear(interval_id)
            if on_fail ~= nil then on_fail() end
        end
    end, YOYO_RANGE_CHECK_STEP_MS)
end

local function press_r_now()
    input.send_key(R_KEY, R_HOLD_MS)
    return true
end

local function high_hp_jump_now()
    ability_manager:activate_ability(JUMP)
    return true
end

local function has_high_hp_cancel_enemy(player)
    return has_dynamic_target_custom(player, HIGH_HP_CANCEL_RANGE, HIGH_HP_CANCEL_AIM_FOV)
end

-- ---------------------------------------------------------------------------
-- YOYO route (Updated dynamic integration)
-- ---------------------------------------------------------------------------

local function run_yoyo_route(combo_id, player, opener_target)
    -- 1) PULL
    if not cast_if_fov_and_range(player, opener_target, PULL, RANGE_PULL) then
        stop_combo(combo_id)
        return
    end

    -- 2) JUMP
    schedule(combo_id, YOYO_PULL_TO_JUMP_DELAY_MS, function()
        ability_manager:activate_ability(JUMP, YOYO_JUMP_HOLD_MS)
    end)

    -- 3) POLL for enemy to reach Uppercut range (5m)
    wait_for_enemy_in_range(combo_id, player, RANGE_UPPERCUT, YOYO_PULL_MAX_WAIT_MS, function()
        
        -- 4) TAP MANUAL SWING
        ability_manager:activate_ability(ABILITY2, YOYO_OPENER_SWING_HOLD_MS)

        -- 5) HOLD TRACER (Cancels the manual swing)
        schedule(combo_id, YOYO_OPENER_SWING_TO_TRACER_DELAY_MS, function()
            ability_manager:activate_ability(TRACER, YOYO_OPENER_TRACER_HOLD_MS)
            
            -- 6) UPPERCUT
            schedule(combo_id, YOYO_OPENER_TRACER_TO_UPPERCUT_DELAY_MS, function()
                wait_for_enemy_in_range(combo_id, player, RANGE_UPPERCUT, YOYO_INTRA_CAST_MAX_WAIT_MS, function(dynamic_target)
                    aim_at_target(dynamic_target)
                    ability_manager:activate_ability(UPPERCUT)

                    -- 7) WAIT POST UPPERCUT
                    schedule(combo_id, YOYO_POST_UPPERCUT_DELAY_MS, function()
                        ability_manager:activate_ability(TRACER, YOYO_POST_UPPERCUT_TRACER_HOLD_MS)

                        -- 8) TIGHT PLINK SWING
                        schedule(combo_id, YOYO_TIGHT_PLINK_DELAY_MS, function()
                            ability_manager:activate_ability(ABILITY2, YOYO_POST_UPPERCUT_SWING_HOLD_MS)

                            -- 9) PRIMARY / PUNCH
                            schedule(combo_id, YOYO_SWING_TO_PUNCH_DELAY_MS, function()
                                wait_for_enemy_in_range(combo_id, player, RANGE_PUNCH, YOYO_INTRA_CAST_MAX_WAIT_MS, function(dynamic_target)
                                    aim_at_target(dynamic_target)
                                    ability_manager:activate_ability(PUNCH, YOYO_PUNCH_HOLD_MS)
                                end, function()
                                    stop_combo(combo_id)
                                end)
                            end)
                        end)
                    end)
                end, function()
                    stop_combo(combo_id)
                end)
            end)
        end)
    end, function() 
        stop_combo(combo_id) 
    end)
end

-- ---------------------------------------------------------------------------
-- SEKKOMBO route
-- ---------------------------------------------------------------------------

local function run_sekkombo_pre_uppercut_jumps(use_jumps)
    if not use_jumps then
        return
    end

    ability_manager:activate_ability(JUMP, SEKKOMBO_JUMP_HOLD_MS)
    wait(SEKKOMBO_JUMP_DELAY_MS)
    ability_manager:activate_ability(JUMP, SEKKOMBO_JUMP_HOLD_MS)
end

local function run_sekkombo_route(combo_id, player, opener_target)
    local use_pre_uppercut_jumps = should_use_sekkombo_jumps(opener_target)

    -- 1) SECONDARY / TRACER
    if not cast_tracer_until_mark(combo_id, player, opener_target) then
        stop_combo(combo_id)
        return
    end

    -- 2) ABILITY1 / PULL
    if not cast_if_fov_and_range(player, opener_target, PULL, RANGE_PULL) then
        stop_combo(combo_id)
        return
    end

    -- 3) PRIMARY / PUNCH
    schedule(combo_id, SEKKOMBO_PULL_TO_PRIMARY_START_DELAY_MS, function()
        wait_for_any_enemy_then_cast(
            combo_id,
            player,
            PUNCH,
            RANGE_SEKKOMBO_PUNCH,
            PRIMARY_MAX_WAIT_MS,
            function()
                -- 4) SECONDARY / TRACER
                schedule(combo_id, SEKKOMBO_PRIMARY_TO_TRACER_DELAY_MS, function()
                    if not cast_tracer_on_any_enemy_until_mark(combo_id, player) then
                        stop_combo(combo_id)
                        return
                    end

                    -- 5) ABILITY3 / UPPERCUT
                    run_sekkombo_pre_uppercut_jumps(use_pre_uppercut_jumps)
                    schedule(combo_id, SEKKOMBO_TRACER_TO_UPPERCUT_START_DELAY_MS, function()
                        wait_for_any_enemy_then_cast(
                            combo_id,
                            player,
                            UPPERCUT,
                            RANGE_UPPERCUT,
                            UPPERCUT_MAX_WAIT_MS,
                            function()
                                -- SEKKOMBO route complete.
                            end,
                            function()
                                stop_combo(combo_id)
                            end
                        )
                    end)
                end)
            end,
            function()
                stop_combo(combo_id)
            end
        )
    end)
end

-- ---------------------------------------------------------------------------
-- HIGH-HP route
-- ---------------------------------------------------------------------------

local function run_high_hp_route(combo_id, player, opener_target)
    -- 1) TRACER
    if not cast_tracer_until_mark(combo_id, player, opener_target) then
        stop_combo(combo_id)
        return
    end

    -- 2) PULL
    schedule(combo_id, HIGH_HP_TRACER_TO_PULL_DELAY_MS, function()
        if not cast_if_fov_and_range(player, opener_target, PULL, RANGE_PULL) then
            stop_combo(combo_id)
            return
        end

        -- 3) PRIMARY / OVERHEAD
        schedule(combo_id, HIGH_HP_PULL_TO_PUNCH1_DELAY_MS, function()
            wait_for_any_enemy_then_cast(
                combo_id,
                player,
                PUNCH,
                RANGE_PUNCH,
                PRIMARY_MAX_WAIT_MS,
                function()
                    -- 4) TRACER
                    schedule(combo_id, HIGH_HP_PUNCH1_TO_TRACER2_DELAY_MS, function()
                        if not cast_tracer_on_any_enemy_until_mark(combo_id, player) then
                            stop_combo(combo_id)
                            return
                        end

                        -- 5) DOUBLE JUMP
                        schedule(combo_id, HIGH_HP_TRACER2_TO_JUMP1_DELAY_MS, function()
                            high_hp_jump_now()

                            schedule(combo_id, HIGH_HP_JUMP1_TO_JUMP2_DELAY_MS, function()
                                high_hp_jump_now()

                                -- 6) OVERHEAD / PRIMARY
                                schedule(combo_id, HIGH_HP_JUMP2_TO_OVERHEAD_DELAY_MS, function()
                                    wait_for_any_enemy_then_cast(
                                        combo_id,
                                        player,
                                        PUNCH,
                                        RANGE_PUNCH,
                                        PRIMARY_MAX_WAIT_MS,
                                        function()
                                            -- 7) TRACER
                                            schedule(combo_id, HIGH_HP_OVERHEAD_TO_TRACER3_DELAY_MS, function()
                                                if not cast_tracer_on_any_enemy_until_mark(combo_id, player) then
                                                    stop_combo(combo_id)
                                                    return
                                                end

                                                -- 8) UPPERCUT
                                                schedule(combo_id, HIGH_HP_TRACER3_TO_UPPERCUT_DELAY_MS, function()
                                                    wait_for_any_enemy_then_cast(
                                                        combo_id,
                                                        player,
                                                        UPPERCUT,
                                                        RANGE_UPPERCUT,
                                                        UPPERCUT_MAX_WAIT_MS,
                                                        function()
                                                            -- 9) UPPERCUT CANCEL CHECK
                                                            if not has_high_hp_cancel_enemy(player) then
                                                                return
                                                            end

                                                            -- 10) BUFFERED TRACER HOLD
                                                            schedule(combo_id, HIGH_HP_UPPERCUT_TO_TRACER_DELAY_MS, function()
                                                                ability_manager:activate_ability(TRACER, HIGH_HP_TRACER_HOLD_MS)

                                                                -- 11) ABILITY2 CANCEL
                                                                schedule(combo_id, HIGH_HP_TRACER_HOLD_TO_ABILITY2_DELAY_MS, function()
                                                                    ability_manager:activate_ability(ABILITY2, HIGH_HP_ABILITY2_HOLD_MS)

                                                                    -- 12) FINAL OVERHEAD / PRIMARY
                                                                    schedule(combo_id, HIGH_HP_NEW_DELAY_MS, function()
                                                                        wait_for_any_enemy_then_cast(
                                                                            combo_id,
                                                                            player,
                                                                            PUNCH,
                                                                            RANGE_PUNCH,
                                                                            PRIMARY_MAX_WAIT_MS,
                                                                            function()
                                                                                -- HIGH-HP route complete.
                                                                            end,
                                                                            function()
                                                                            end
                                                                        )
                                                                    end)
                                                                end)
                                                            end)
                                                        end,
                                                        function()
                                                            stop_combo(combo_id)
                                                        end
                                                    )
                                                end)
                                            end)
                                        end,
                                        function()
                                            stop_combo(combo_id)
                                        end
                                    )
                                end)
                            end)
                        end)
                    end)
                end,
                function()
                    stop_combo(combo_id)
                end
            )
        end)
    end)
end

-- ---------------------------------------------------------------------------
-- Hydro / R route
-- ---------------------------------------------------------------------------

local function run_with_r_route(combo_id, player, opener_target)
    -- 1) TRACER
    if not cast_tracer_until_mark(combo_id, player, opener_target) then
        stop_combo(combo_id)
        return
    end

    -- 2) PULL
    schedule(combo_id, WITH_R_TRACER_TO_PULL_DELAY_MS, function()
        if not cast_if_fov_and_range(player, opener_target, PULL, RANGE_PULL) then
            stop_combo(combo_id)
            return
        end

        -- 3) PUNCH / PRIMARY
        schedule(combo_id, WITH_R_PULL_TO_PUNCH_DELAY_MS, function()
            wait_for_any_enemy_then_cast(
                combo_id,
                player,
                PUNCH,
                RANGE_PUNCH,
                PRIMARY_MAX_WAIT_MS,
                function()
                    -- 4) TRACER
                    schedule(combo_id, WITH_R_PUNCH1_TO_TRACER_DELAY_MS, function()
                        if not cast_tracer_on_any_enemy_until_mark(combo_id, player) then
                            stop_combo(combo_id)
                            return
                        end

                        -- 5) R KEY
                        schedule(combo_id, WITH_R_TRACER_TO_R_DELAY_MS, function()
                            press_r_now()

                            -- 6) PUNCH / PRIMARY
                            schedule(combo_id, WITH_R_R_TO_PUNCH_DELAY_MS, function()
                                wait_for_any_enemy_then_cast(
                                    combo_id,
                                    player,
                                    PUNCH,
                                    RANGE_PUNCH,
                                    PRIMARY_MAX_WAIT_MS,
                                    function()
                                        -- 7) TRACER
                                        schedule(combo_id, WITH_R_PUNCH2_TO_TRACER_DELAY_MS, function()
                                            if not cast_tracer_on_any_enemy_until_mark(combo_id, player) then
                                                stop_combo(combo_id)
                                                return
                                            end

                                            -- 8) UPPERCUT
                                            schedule(combo_id, WITH_R_TRACER_TO_UPPERCUT_DELAY_MS, function()
                                                wait_for_any_enemy_then_cast(
                                                    combo_id,
                                                    player,
                                                    UPPERCUT,
                                                    RANGE_UPPERCUT,
                                                    UPPERCUT_MAX_WAIT_MS,
                                                    function()
                                                        -- Combo complete.
                                                    end,
                                                    function()
                                                        stop_combo(combo_id)
                                                    end
                                                )
                                            end)
                                        end)
                                    end,
                                    function()
                                        stop_combo(combo_id)
                                    end
                                )
                            end)
                        end)
                    end)
                end,
                function()
                    stop_combo(combo_id)
                end
            )
        end)
    end)
end

-- ---------------------------------------------------------------------------
-- Entrypoint
-- ---------------------------------------------------------------------------

function on_activate_combo(ctx)
    local combo_id = start_new_combo()

    local player = nil
    local fallback_target = nil

    if ctx ~= nil then
        player = ctx.player
        fallback_target = ctx.target
    end

    if not valid_player(player) then
        stop_combo(combo_id)
        return false
    end

    -- Highest precedence:
    -- If player is 5m+ above any valid enemy, run YOYO regardless of max HP.
    local yoyo_target = find_yoyo_target(player, fallback_target)

    if yoyo_target ~= nil then
        run_yoyo_route(combo_id, player, yoyo_target)
        return true
    end

    -- Otherwise choose normal/high-HP route by opener target current effective HP.
    local opener_target = get_route_target(player, fallback_target)

    if opener_target == nil then
        stop_combo(combo_id)
        return false
    end

    local route = choose_route_for_target(opener_target)

    if route == ROUTE_HIGH_HP then
        run_high_hp_route(combo_id, player, opener_target)
    elseif route == ROUTE_SEKKOMBO then
        run_sekkombo_route(combo_id, player, opener_target)
    else
        run_with_r_route(combo_id, player, opener_target)
    end

    return true
end

]],
}

MODULE_DEFS[#MODULE_DEFS + 1] = {
    name = "StrangeAnimCancel",
    kind = "combo",
    source = [[
-- end stop guard
local __route_end_stop_signal = "__route_end_stop_signal"
local __route_raw_wait = wait
local function __route_end_pressed()
    return input and input.is_key_down and input.is_key_down(35) == true
end
local function __route_release_combo_inputs()
    if not input or not input.release_key then return end
    pcall(function() input.release_key(Enum.MouseButton.Left) end)
    pcall(function() input.release_key(Enum.MouseButton.Right) end)
    pcall(function() input.release_key(Enum.Key.Space) end)
    pcall(function() input.release_key(Enum.Key.W) end)
    pcall(function() input.release_key(Enum.Key.A) end)
    pcall(function() input.release_key(Enum.Key.S) end)
    pcall(function() input.release_key(Enum.Key.D) end)
end
local function wait(ms)
    if __route_end_pressed() then
        __route_release_combo_inputs()
        error(__route_end_stop_signal, 0)
    end
    __route_raw_wait(ms)
    if __route_end_pressed() then
        __route_release_combo_inputs()
        error(__route_end_stop_signal, 0)
    end
end

local DMG_BASE = 1.5
local DMG_ULT  = 2.97
local RANGE    = 10

settings = {
    { key="min_energy", label="Min Dark Magic", tooltip="Don't fire Ability1 below this energy", default=50, min=0, max=100 },
    { key="buffer", label="Damage Safety Buffer", tooltip="Require projected damage to exceed HP by this amount", default=40, min=0, max=200 },
}

local function is_reloading(p)
    local r = p:get_ability(Enum.AbilityType.WeaponReload)
    return r and r.is_activated
end

local function wait_for_reload(p)
    while p and not p.is_dead and is_reloading(p) do
        wait(25)
    end
    return p and not p.is_dead
end

local function shield_ready(p)
    local s = p:get_ability(Enum.AbilityType.SecondaryAttack)
    return s and not s.on_cooldown
end

local function killable(p, min_e, buf)
    local a = p:get_ability(Enum.AbilityType.Ability1)
    if not a or a.on_cooldown then return false end
    local e = a.energy_value
    if e < min_e then return false end
    local ult = p:get_ability(Enum.AbilityType.Ultimate)
    local dmg = (ult and ult.is_activated) and DMG_ULT or DMG_BASE
    local total = e * dmg
    local pl = p.location
    for _, en in next, object_manager.get_players(true) do
        if en and not en.is_dead and en.location
            and pl:get_distance_to(en.location) * 0.01 <= RANGE
            and total >= (en.health + (en.shield or 0)) + buf then
            return true
        end
    end
    return false
end

local function poll(p, min_e, buf, ms)
    local step = 25
    for _ = 1, math.max(1, ms // step) do
        if not wait_for_reload(p) then return false end
        if killable(p, min_e, buf) then
            ability_manager:activate_ability(Enum.AbilityType.Ability1)
            return true
        end
        wait(step)
    end
    return false
end

local function __route_original_on_activate_combo(ctx)
    local p = ctx.player
    if not wait_for_reload(p) then return true end
    local min_e = script.get_setting("min_energy") or 50
    local buf = script.get_setting("buffer") or 40

    if killable(p, min_e, buf) then
        ability_manager:activate_ability(Enum.AbilityType.Ability1)
        return true
    end

    if not wait_for_reload(p) then return true end
    ability_manager:activate_ability(Enum.AbilityType.PrimaryAttack, 500)
	wait(5)
    if poll(p, min_e, buf, 300) then return true end

    if not wait_for_reload(p) then return true end
    ability_manager:activate_ability(Enum.AbilityType.MeleeAttack, 400)
	wait(5)
    if poll(p, min_e, buf, 300) then return true end

    if shield_ready(p) then
        if not wait_for_reload(p) then return true end
        ability_manager:activate_ability(Enum.AbilityType.SecondaryAttack, 100)
        if poll(p, min_e, buf, 400) then return true end
    end
    return true
end


local __route_wrapped_on_activate_combo = __route_original_on_activate_combo
function on_activate_combo(ctx)
    if __route_end_pressed() then
        __route_release_combo_inputs()
        return false
    end

    local ok, result = pcall(__route_wrapped_on_activate_combo, ctx)
    if not ok then
        if result == __route_end_stop_signal or tostring(result) == __route_end_stop_signal then
            __route_release_combo_inputs()
            return false
        end
        error(result)
    end

    return result
end

]],
}

MODULE_DEFS[#MODULE_DEFS + 1] = {
    name = "Thor",
    kind = "combo",
    source = [[
-- end stop guard
local __route_end_stop_signal = "__route_end_stop_signal"
local __route_raw_wait = wait
local function __route_end_pressed()
    return input and input.is_key_down and input.is_key_down(35) == true
end
local function __route_release_combo_inputs()
    if not input or not input.release_key then return end
    pcall(function() input.release_key(Enum.MouseButton.Left) end)
    pcall(function() input.release_key(Enum.MouseButton.Right) end)
    pcall(function() input.release_key(Enum.Key.Space) end)
    pcall(function() input.release_key(Enum.Key.W) end)
    pcall(function() input.release_key(Enum.Key.A) end)
    pcall(function() input.release_key(Enum.Key.S) end)
    pcall(function() input.release_key(Enum.Key.D) end)
end
local function wait(ms)
    if __route_end_pressed() then
        __route_release_combo_inputs()
        error(__route_end_stop_signal, 0)
    end
    __route_raw_wait(ms)
    if __route_end_pressed() then
        __route_release_combo_inputs()
        error(__route_end_stop_signal, 0)
    end
end

local F_RANGE = 30
local MELEE_RANGE = 4.5
local RMB_RANGE = 24

settings = {
    { key = "fov_limit", label = "Global FOV", default = 60.0, min = 1.0, max = 360.0 },
    { key = "rmb_fov_limit", label = "RMB FOV", default = 10.0, min = 1.0, max = 360.0 },
    { key = "use_rmb", label = "Use RMB", default = true },
    { key = "use_f", label = "Use F", default = true }
}

local last_cast = {
    [Enum.AbilityType.PrimaryAttack] = 0,
    [Enum.AbilityType.SecondaryAttack] = 0,
    [Enum.AbilityType.Ability3] = 0
}

local primary_held = false

local function dist(player, target)
    return player.location:get_distance_to(target.location) * 0.01
end

local function hold_primary()
    if primary_held then
        return
    end

    input.press_key(Enum.MouseButton.Left)
    primary_held = true
end

local function release_primary()
    if not primary_held then
        return
    end

    input.release_key(Enum.MouseButton.Left)
    primary_held = false
end

local function target_visible(target)
    if not target then return false end

    if target.is_visible then
        local ok, visible = pcall(function() return target:is_visible() end)
        if ok and visible == true then return true end
    end

    if target.has_line_of_sight then
        local ok, los = pcall(function() return target:has_line_of_sight() end)
        if ok and los == true then return true end
    end

    return false
end

local function __route_original_on_activate_combo(ctx)
    local player = ctx.player
    local target = ctx.target
    local now = os.clock()

    if not player then return false end

    if not target or not target_visible(target) or target.is_dead then 
        return false 
    end

    local fov_limit = script.get_setting("fov_limit") or 25.0
    if target:get_fov_to_target() > fov_limit then 
        return false 
    end

    local f = player:get_ability(Enum.AbilityType.Ability3)
    if not f then return false end

    -- 1. Awakened Mode Continuous Beam
    if f.is_activated then
        hold_primary()
        return true
    else
        release_primary()
    end

    -- 2. Auto Awakened Mode (F)
    local use_f = script.get_setting("use_f")
    if use_f == nil then use_f = false end

    if use_f and not f.is_activated and f:can_activate() and f.energy_value and f.energy_value >= 2.9 and dist(player, target) <= F_RANGE then
        if now - last_cast[Enum.AbilityType.Ability3] > 0.4 then
            ability_manager:activate_ability(Enum.AbilityType.Ability3, 200)
            last_cast[Enum.AbilityType.Ability3] = now
        end
    end

    -- 3. Auto Hammer Throw (RMB)
    local use_rmb = script.get_setting("use_rmb")
    if use_rmb == nil then use_rmb = true end

    if use_rmb and dist(player, target) <= RMB_RANGE then
        local rmb_fov = script.get_setting("rmb_fov_limit") or 10.0
        if target:get_fov_to_target() <= rmb_fov then
            local rmb = player:get_ability(Enum.AbilityType.SecondaryAttack)
            if rmb and rmb:can_activate() then
                if now - last_cast[Enum.AbilityType.SecondaryAttack] > 0.4 then
                    ability_manager:activate_ability(Enum.AbilityType.SecondaryAttack)
                    last_cast[Enum.AbilityType.SecondaryAttack] = now
                end
            end
        end
    end

    -- 4. Melee (LMB Triggerbot)
    if dist(player, target) <= MELEE_RANGE then
        local lmb = player:get_ability(Enum.AbilityType.PrimaryAttack)
        if lmb and lmb:can_activate() then
            if now - last_cast[Enum.AbilityType.PrimaryAttack] > 0.02 then
                ability_manager:activate_ability(Enum.AbilityType.PrimaryAttack, 5)
                last_cast[Enum.AbilityType.PrimaryAttack] = now
            end
            return true
        end
    end

    return false
end

function on_deactivate_combo(ctx)
    release_primary()
end


local __route_wrapped_on_activate_combo = __route_original_on_activate_combo
function on_activate_combo(ctx)
    if __route_end_pressed() then
        __route_release_combo_inputs()
        return false
    end

    local ok, result = pcall(__route_wrapped_on_activate_combo, ctx)
    if not ok then
        if result == __route_end_stop_signal or tostring(result) == __route_end_stop_signal then
            __route_release_combo_inputs()
            return false
        end
        error(result)
    end

    return result
end

]],
}

-- LookAtPitchProbe removed per user request



MODULE_DEFS[#MODULE_DEFS + 1] = {
    name = "BlackCatLowHPScan",
    kind = "scanner",
    source = [[
local BLACK_CAT_HERO_ID = 1061
local ABILITY1 = Enum.AbilityType.Ability1
local SCAN_MS = script.get_setting("scan_poll_ms") or 50
local END_KEY = 35

local EXECUTE_HP_THRESHOLD = 75
local SAVE_ME_HP = 75

settings = {
    { key = "black_cat_save_me_enabled", label = "Save me?!", default = true },
    { key = "black_cat_save_me_fov", label = "Save me Fov", default = 360, min = 0, max = 360 },
    { key = "black_cat_execute_them_enabled", label = "Execute Them!!", default = true },
    { key = "black_cat_execute_them_fov", label = "Execute Them Fov", default = 360, min = 0, max = 360 },
    { key = "black_cat_use_aim", label = "Use Aim?", default = true },
    { key = "black_cat_flickbot", label = "Flickbot?", default = false },
    { key = "black_cat_fov", label = "Fov", default = 50, min = 0, max = 360 },
    { key = "black_cat_fast_pursuit", label = "Fast Pursuit for Black Cat", default = false },
}

local function get_hero_id(p)
    if not p then return nil end
    if p.get_hero_id then
        local ok, id = pcall(function() return p:get_hero_id() end)
        if ok and id then return id end
    end
    return p.hero_id
end

local function is_black_cat(player)
    return player and player:is_valid() and not player.is_dead and get_hero_id(player) == BLACK_CAT_HERO_ID
end

local function safe_players(enemies_only)
    if not object_manager or not object_manager.get_players then return nil end
    local ok, ps = pcall(function() return object_manager.get_players(enemies_only) end)
    if ok then return ps end
    return nil
end

local function valid_enemy(e)
    if not e then return false end
    local ok, v = pcall(function() return e:is_valid() end)
    if not ok or not v then return false end
    if e.is_dead then return false end
    local ok2, vis = pcall(function() return e:is_visible() end)
    if not ok2 or vis ~= true then return false end
    local ok3, los = pcall(function() return e:has_line_of_sight() end)
    if not ok3 or los ~= true then return false end
    return true
end

local function distance_m(a, b)
    if not a or not b or not a.location or not b.location then return math.huge end
    if a.location.get_distance_to_meters then
        local ok, d = pcall(function() return a.location:get_distance_to_meters(b.location) end)
        if ok and d then return d end
    end
    local ok, d = pcall(function() return a.location:get_distance_to(b.location) * 0.01 end)
    if ok and d then return d end
    return math.huge
end

local function ability1_ready(player)
    if not player then return false end
    local ok, a = pcall(function() return player.get_ability and player:get_ability(ABILITY1) end)
    if not ok or not a then return false end
    if a.on_cooldown then return false end
    if a.cooldown_remaining and a.cooldown_remaining > 0 then return false end
    if a.is_activated then return false end
    return true
end

local function ability1_energy(player)
    if not player then return 0 end
    local ok, a = pcall(function() return player.get_ability and player:get_ability(ABILITY1) end)
    if not ok or not a then return 0 end
    return (a.energy_value and tonumber(a.energy_value)) or 0
end

local function press_if_not_down(key)
    if not input or not input.is_key_down or not input.press_key then return false end
    local ok, down = pcall(function() return input.is_key_down(key) end)
    if ok and down then return false end
    return pcall(function() input.press_key(key) end)
end

local function release_lmb_for_rmb_ability1()
    if not input or not input.is_key_down or not input.release_key then return false end
    local ok, was_down = pcall(function() return input.is_key_down(Enum.MouseButton.Left) end)
    if not ok or was_down ~= true then return false end
    pcall(function() input.release_key(Enum.MouseButton.Left) end)
    return true
end

local function restore_lmb_after_rmb_ability1(was_down)
    if not was_down or not input or not input.press_key then return end
    pcall(function() input.press_key(Enum.MouseButton.Left) end)
end

local function camera_look_at_and_invert(target)
    if not camera or not target or not camera.look_at then return false end
    local looked = false
    pcall(function()
        if target.location then camera.look_at(target.location) else camera.look_at(target) end
        looked = true
    end)
    if looked and camera.get_rotation and camera.set_rotation then
        local ok, rot = pcall(function() return camera.get_rotation() end)
        if ok and rot and rot.pitch and rot.yaw then
            pcall(function() camera.set_rotation(-rot.pitch, rot.yaw) end)
        end
    end
    -- Small delay to allow camera to settle
    if looked then wait(30) end
    return looked
end

local function fov_limit()
    local limit = 50
    if script.get_setting then
        local ok, fv = pcall(function() return script.get_setting("black_cat_fov") end)
        if ok and fv then limit = tonumber(fv) or 50 end
    end
    return limit
end

local function do_cast_ability1_on(target)
    if not target then return end
    local use_aim = script.get_setting and script.get_setting("black_cat_use_aim") == true
    local use_flickbot = script.get_setting and script.get_setting("black_cat_flickbot") == true
    if use_flickbot then
        if not (flickbot and flickbot.perform) then return end
        local flick_cfg = { use_prediction = true, duration = 150, aim_points = { Enum.AimPoint.Head } }
        local targ_cfg = { aim_fov = fov_limit(), dynamic_fov = true, ignore_invisible = true, max_distance = 9999 }
        local lmb_was_down = release_lmb_for_rmb_ability1()
        local pressed = press_if_not_down(Enum.MouseButton.Right)
        if pressed then rmb_pressed_by_script = true end
        wait(50)
        pcall(function()
            flickbot.perform(target, ABILITY1, flick_cfg, targ_cfg, Enum.AbilityWait.None)
        end)
        wait(50)
        if rmb_pressed_by_script then
            pcall(function() input.release_key(Enum.MouseButton.Right) end)
            rmb_pressed_by_script = false
        end
        restore_lmb_after_rmb_ability1(lmb_was_down)
    elseif use_aim then
        pcall(function() camera_look_at_and_invert(target) end)
        local lmb_was_down = release_lmb_for_rmb_ability1()
        local pressed = press_if_not_down(Enum.MouseButton.Right)
        if pressed then rmb_pressed_by_script = true end
        wait(50)
        pcall(function() ability_manager:activate_ability(ABILITY1) end)
        wait(50)
        if rmb_pressed_by_script then
            pcall(function() input.release_key(Enum.MouseButton.Right) end)
            rmb_pressed_by_script = false
        end
        restore_lmb_after_rmb_ability1(lmb_was_down)
    else
        local lmb_was_down = release_lmb_for_rmb_ability1()
        local pressed = press_if_not_down(Enum.MouseButton.Right)
        if pressed then rmb_pressed_by_script = true end
        wait(50)
        pcall(function() ability_manager:activate_ability(ABILITY1) end)
        wait(50)
        if rmb_pressed_by_script then
            pcall(function() input.release_key(Enum.MouseButton.Right) end)
            rmb_pressed_by_script = false
        end
        restore_lmb_after_rmb_ability1(lmb_was_down)
    end
end

local function effective_hp(enemy)
    if not enemy then return math.huge end
    local hp = enemy.health
    if not hp then return math.huge end
    return hp + (enemy.shield or 0)
end

local function fov_angle(enemy)
    if not enemy or not enemy.get_fov_to_target then return 0 end
    local ok, fov = pcall(function() return enemy:get_fov_to_target() end)
    if not ok or fov == nil then return 0 end
    return math.abs(fov)
end

local function select_fov_target(player, hp_filter, custom_fov_key)
    local ps = safe_players(true)
    if type(ps) ~= "table" then return nil end
    local limit = fov_limit()
    if custom_fov_key and script.get_setting then
        local ok, fv = pcall(function() return script.get_setting(custom_fov_key) end)
        if ok and fv then limit = tonumber(fv) or 360 end
    end

    local best, best_fov = nil, math.huge
    for _, e in ipairs(ps) do
        if valid_enemy(e) and (not hp_filter or effective_hp(e) <= hp_filter) then
            local ang = fov_angle(e)
            if (limit >= 360 or ang <= limit) and ang < best_fov then
                best, best_fov = e, ang
            end
        end
    end
    return best
end

local function select_execution_target(player)
    return select_fov_target(player, EXECUTE_HP_THRESHOLD, "black_cat_execute_them_fov")
end

local function select_save_me_target(player)
    local ps = safe_players(true)
    if type(ps) ~= "table" then return nil end

    local nearest, nearest_d = nil, math.huge
    local within_15 = {}
    for _, e in ipairs(ps) do
        if valid_enemy(e) then
            local d = distance_m(player, e)
            if d < nearest_d then nearest, nearest_d = e, d end
            if d <= 15 then within_15[#within_15 + 1] = e end
        end
    end

    if #within_15 > 1 then
        local best, best_hp = nil, math.huge
        for _, e in ipairs(within_15) do
            local hp = effective_hp(e)
            if hp < best_hp then best, best_hp = e, hp end
        end
        return best
    end

    return nearest
end

local scanner_id = nil
local scan_active = false
local busy = false
local rmb_pressed_by_script = false
local last_cast_time = 0
local CAST_COOLDOWN_MS = 500

local function scan_once()
    if busy then return false end
    local player = object_manager.get_local_player()
    if not is_black_cat(player) then return false end

    if not ability1_ready(player) then return false end
    
    -- Require at least 300 energy for Phantom Pursuit
    local energy = ability1_energy(player)
    if energy < 300 then return false end

    -- Check if we're still in cooldown from last cast
    local now = os.clock() * 1000
    if now - last_cast_time < CAST_COOLDOWN_MS then
        return false
    end

    busy = true

    -- Check if trigger_key is pressed and release it for low hp paths
    local trigger_was_down = false
    if script and script.is_keybind_active then
        local ok, down = pcall(function() return script.is_keybind_active("trigger_key") end)
        if ok and down then
            trigger_was_down = true
            -- Release trigger_key by simulating key up
            pcall(function() input.release_key(script.get_setting("trigger_key")) end)
        end
    end

    -- Fast Pursuit check - if enabled, watch for RMB press
    local fast_pursuit_enabled = script.get_setting and script.get_setting("black_cat_fast_pursuit") == true
    if fast_pursuit_enabled then
        local rmb_down = false
        if input and input.is_key_down then
            local ok, down = pcall(function() return input.is_key_down(Enum.MouseButton.Right) end)
            if ok and down then rmb_down = true end
        end
        
        if rmb_down then
            -- Find closest target in FOV
            local target = select_fov_target(player, math.huge, "black_cat_fov")
            if target then
                wait(100) -- Wait 100ms as requested
                do_cast_ability1_on(target)
                last_cast_time = now
                busy = false
                -- Restore trigger_key if it was pressed
                if trigger_was_down then
                    pcall(function() input.press_key(script.get_setting("trigger_key")) end)
                end
                return true
            end
        end
    end

    -- Execute check
    local execute_enabled = script.get_setting and script.get_setting("black_cat_execute_them_enabled") == true
    if execute_enabled then
        local exec_target = select_execution_target(player)
        if exec_target then
            do_cast_ability1_on(exec_target)
            last_cast_time = now
            busy = false
            -- Restore trigger_key if it was pressed
            if trigger_was_down then
                pcall(function() input.press_key(script.get_setting("trigger_key")) end)
            end
            return true
        end
    end

    -- Save-me check
    local save_me_enabled = script.get_setting and script.get_setting("black_cat_save_me_enabled") == true
    if save_me_enabled then
        local player_hp = (player.health or 0) + (player.shield or 0)
        if player_hp < SAVE_ME_HP then
            local target = select_save_me_target(player)
            if target then
                do_cast_ability1_on(target)
                last_cast_time = now
                busy = false
                -- Restore trigger_key if it was pressed
                if trigger_was_down then
                    pcall(function() input.press_key(script.get_setting("trigger_key")) end)
                end
                return true
            end
        end
    end

    busy = false
    return true
end

local function start_scanner()
    if scanner_id then return true end
    scanner_id = timer.set_interval(function()
        if input and input.is_key_down and input.is_key_down(END_KEY) then
            scan_active = false
            return
        end
        if scan_active then
            scan_once()
        end
    end, SCAN_MS)
    return true
end

function on_activate_combo(ctx)
    start_scanner()
    scan_active = true
    return true
end

function on_deactivate_combo(ctx)
    if rmb_pressed_by_script then
        pcall(function() input.release_key(Enum.MouseButton.Right) end)
        rmb_pressed_by_script = false
    end
    scan_active = false
    if scanner_id then
        timer.clear(scanner_id)
        scanner_id = nil
    end
end
]],
}

MODULE_DEFS[#MODULE_DEFS + 1] = {
    name = "BlackCat",
    kind = "combo",
    source = [[
local BLACK_CAT_HERO_ID = 1061
local ABILITY1 = Enum.AbilityType.Ability1
local PRIMARY = Enum.AbilityType.PrimaryAttack
local SECONDARY = Enum.AbilityType.SecondaryAttack

local HOLD_RANGE_M = 4
local SECONDARY_REACT_ENERGY = 300

settings = {
    { key = "black_cat_fov", label = "Fov", default = 50, min = 0, max = 360 },
    { key = "black_cat_use_shift", label = "Use Shift?", default = true },
    { key = "black_cat_use_aim", label = "Use Aim?", default = true },
    { key = "black_cat_flickbot", label = "Flickbot?", default = false },
    { key = "black_cat_whip_threshold", label = "Whip Threshhold", default = 50, min = 0, max = 360 },
}

local function get_whip_threshold()
    local val = 50
    if script.get_setting then
        local ok, v = pcall(function() return script.get_setting("black_cat_whip_threshold") end)
        if ok and v then
            local n = tonumber(v)
            if n then val = n end
        end
    end
    if val < 0 then val = 0 end
    if val > 360 then val = 360 end
    return val
end

local busy = false
local lmb_pressed_by_script = false
local rmb_pressed_by_script = false

local function get_hero_id(p)
    if not p then return nil end
    if p.get_hero_id then
        local ok, id = pcall(function() return p:get_hero_id() end)
        if ok and id then return id end
    end
    return p.hero_id
end

local function is_black_cat(player)
    return player and player:is_valid() and not player.is_dead and get_hero_id(player) == BLACK_CAT_HERO_ID
end

local function safe_players(enemies_only)
    if not object_manager or not object_manager.get_players then return nil end
    local ok, ps = pcall(function() return object_manager.get_players(enemies_only) end)
    if ok then return ps end
    return nil
end

local function valid_enemy(e)
    if not e then return false end
    local ok, v = pcall(function() return e:is_valid() end)
    if not ok or not v then return false end
    if e.is_dead then return false end
    local ok2, vis = pcall(function() return e:is_visible() end)
    if not ok2 or vis ~= true then return false end
    local ok3, los = pcall(function() return e:has_line_of_sight() end)
    if not ok3 or los ~= true then return false end
    return true
end

local function distance_m(a, b)
    if not a or not b or not a.location or not b.location then return math.huge end
    if a.location.get_distance_to_meters then
        local ok, d = pcall(function() return a.location:get_distance_to_meters(b.location) end)
        if ok and d then return d end
    end
    local ok, d = pcall(function() return a.location:get_distance_to(b.location) * 0.01 end)
    if ok and d then return d end
    return math.huge
end

local function ability1_ready(player)
    if not player then return false end
    local ok, a = pcall(function() return player.get_ability and player:get_ability(ABILITY1) end)
    if not ok or not a then return false end
    if a.on_cooldown then return false end
    if a.cooldown_remaining and a.cooldown_remaining > 0 then return false end
    if a.is_activated then return false end
    return true
end

local function ability1_energy(player)
    local ok, a = pcall(function() return player and player.get_ability and player:get_ability(ABILITY1) end)
    if not ok or not a then return 0 end
    return (a.energy_value and tonumber(a.energy_value)) or 0
end

local last_secondary_active = false
local function secondary_just_activated(player)
    if not player then return false end
    local ok, a = pcall(function() return player.get_ability and player:get_ability(SECONDARY) end)
    if not ok or not a then
        last_secondary_active = false
        return false
    end
    local now_active = a.is_activated == true
    local fired = now_active and not last_secondary_active
    last_secondary_active = now_active
    return fired
end

local function press_if_not_down(key)
    if not input or not input.is_key_down or not input.press_key then return false end
    local ok, down = pcall(function() return input.is_key_down(key) end)
    if ok and down then return false end
    return pcall(function() input.press_key(key) end)
end

-- Ability1 casts that require RMB must not be issued while LMB is held.
-- Preserve the previous logical LMB state without changing ownership: the
-- primary-fallback state remains tracked exclusively by lmb_pressed_by_script.
local function release_lmb_for_rmb_ability1()
    if not input or not input.is_key_down or not input.release_key then return false end
    local ok, was_down = pcall(function() return input.is_key_down(Enum.MouseButton.Left) end)
    if not ok or was_down ~= true then return false end
    pcall(function() input.release_key(Enum.MouseButton.Left) end)
    return true
end

local function restore_lmb_after_rmb_ability1(was_down)
    if not was_down or not input or not input.press_key then return end
    pcall(function() input.press_key(Enum.MouseButton.Left) end)
end

local function camera_look_at_and_invert(target)
    if not camera or not target or not camera.look_at then return false end
    local looked = false
    pcall(function()
        if target.location then camera.look_at(target.location) else camera.look_at(target) end
        looked = true
    end)
    if looked and camera.get_rotation and camera.set_rotation then
        local ok, rot = pcall(function() return camera.get_rotation() end)
        if ok and rot and rot.pitch and rot.yaw then
            pcall(function() camera.set_rotation(-rot.pitch, rot.yaw) end)
        end
    end
    -- Small delay to allow camera to settle
    if looked then wait(30) end
    return looked
end

local function fov_limit()
    local limit = 50
    if script.get_setting then
        local ok, fv = pcall(function() return script.get_setting("black_cat_fov") end)
        if ok and fv then limit = tonumber(fv) or 50 end
    end
    return limit
end

local function do_cast_ability1_on(target)
    if not target then return end
    local use_aim = script.get_setting and script.get_setting("black_cat_use_aim") == true
    local use_flickbot = script.get_setting and script.get_setting("black_cat_flickbot") == true
    if use_flickbot then
        if not (flickbot and flickbot.perform) then return end
        local flick_cfg = { use_prediction = true, duration = 150, aim_points = { Enum.AimPoint.Head } }
        local targ_cfg = { aim_fov = fov_limit(), dynamic_fov = true, ignore_invisible = true, max_distance = 9999 }
        local lmb_was_down = release_lmb_for_rmb_ability1()
        local pressed = press_if_not_down(Enum.MouseButton.Right)
        if pressed then rmb_pressed_by_script = true end
        wait(50)
        pcall(function()
            flickbot.perform(target, ABILITY1, flick_cfg, targ_cfg, Enum.AbilityWait.None)
        end)
        wait(50)
        if rmb_pressed_by_script then
            pcall(function() input.release_key(Enum.MouseButton.Right) end)
            rmb_pressed_by_script = false
        end
        restore_lmb_after_rmb_ability1(lmb_was_down)
    elseif use_aim then
        pcall(function() camera_look_at_and_invert(target) end)
        local lmb_was_down = release_lmb_for_rmb_ability1()
        local pressed = press_if_not_down(Enum.MouseButton.Right)
        if pressed then rmb_pressed_by_script = true end
        wait(50)
        pcall(function() ability_manager:activate_ability(ABILITY1) end)
        wait(50)
        if rmb_pressed_by_script then
            pcall(function() input.release_key(Enum.MouseButton.Right) end)
            rmb_pressed_by_script = false
        end
        restore_lmb_after_rmb_ability1(lmb_was_down)
    else
        local lmb_was_down = release_lmb_for_rmb_ability1()
        local pressed = press_if_not_down(Enum.MouseButton.Right)
        if pressed then rmb_pressed_by_script = true end
        wait(50)
        pcall(function() ability_manager:activate_ability(ABILITY1) end)
        wait(50)
        if rmb_pressed_by_script then
            pcall(function() input.release_key(Enum.MouseButton.Right) end)
            rmb_pressed_by_script = false
        end
        restore_lmb_after_rmb_ability1(lmb_was_down)
    end
end

-- Same rmb-down/cast/rmb-up timing as do_cast_ability1_on, but aims and
-- fires via flickbot instead of camera.look_at. Used for every trigger
-- except execute and save-me, which keep the camera.look_at version above.
local function do_flick_ability1_on(target)
    if not target then return end
    if not (flickbot and flickbot.perform) then return end

    local flick_cfg = { use_prediction = true, duration = 150, aim_points = { Enum.AimPoint.Head } }
    local targ_cfg = { aim_fov = fov_limit(), dynamic_fov = true, ignore_invisible = true, max_distance = 9999 }

    local lmb_was_down = release_lmb_for_rmb_ability1()
    local pressed = press_if_not_down(Enum.MouseButton.Right)
    if pressed then rmb_pressed_by_script = true end
    wait(50)
    pcall(function()
        flickbot.perform(target, ABILITY1, flick_cfg, targ_cfg, Enum.AbilityWait.None)
    end)
    wait(50)
    if rmb_pressed_by_script then
        pcall(function() input.release_key(Enum.MouseButton.Right) end)
        rmb_pressed_by_script = false
    end
    restore_lmb_after_rmb_ability1(lmb_was_down)
end

local function effective_hp(enemy)
    if not enemy then return math.huge end
    local hp = enemy.health
    if not hp then return math.huge end
    return hp + (enemy.shield or 0)
end

local function fov_angle(enemy)
    if not enemy or not enemy.get_fov_to_target then return 0 end
    local ok, fov = pcall(function() return enemy:get_fov_to_target() end)
    if not ok or fov == nil then return 0 end
    return math.abs(fov)
end

-- Nearest-to-center-of-fov among valid enemies passing an optional filter.
local function select_fov_target(player, hp_filter)
    local ps = safe_players(true)
    if type(ps) ~= "table" then return nil end
    local limit = fov_limit()

    local best, best_fov = nil, math.huge
    for _, e in ipairs(ps) do
        if valid_enemy(e) and (not hp_filter or effective_hp(e) <= hp_filter) then
            local ang = fov_angle(e)
            if (limit >= 360 or ang <= limit) and ang < best_fov then
                best, best_fov = e, ang
            end
        end
    end
    return best
end

-- Replacement Black Cat combo.
local function ability1_ready_now(player)
    local ok, ability = pcall(function() return player:get_ability(ABILITY1) end)
    if not ok or not ability then return false end

    local function enabled_state(key)
        local value = ability[key]
        if type(value) == "function" then
            local called, result = pcall(function() return value(ability) end)
            return called and result == true
        end
        return value == true
    end

    return not enabled_state("on_cooldown")
        and not enabled_state("is_activated")
        and (tonumber(ability.cooldown_remaining) or 0) <= 0
end

local function aiming_enabled()
    return script.get_setting and script.get_setting("black_cat_use_aim") == true
end

local function flickbot_enabled()
    return script.get_setting and script.get_setting("black_cat_flickbot") == true
end

-- Held-trigger repeats can run every scan tick. Re-aiming the camera at the
-- same object that often causes visible camera snapping, so only refresh it
-- at a modest cadence; a newly selected target always aims immediately.
local last_camera_target = nil
local last_camera_aim_ms = 0
local CAMERA_AIM_REFRESH_MS = 250

local function aim_target(target)
    -- FlickBot does its aim while it performs the following cast. There is no
    -- standalone FlickBot aim API, so a non-casting re-aim is intentionally a
    -- no-op in that mode.
    if aiming_enabled() and not flickbot_enabled() then
        local now = os.clock() * 1000
        if target == last_camera_target and now - last_camera_aim_ms < CAMERA_AIM_REFRESH_MS then
            return
        end
        pcall(function() camera_look_at_and_invert(target) end)
        last_camera_target = target
        last_camera_aim_ms = now
    end
end

local function cast(target, ability_type)
    if aiming_enabled() and flickbot_enabled() and flickbot and flickbot.perform then
        local flick_cfg = { use_prediction = true, duration = 150, aim_points = { Enum.AimPoint.Head } }
        local target_cfg = { aim_fov = fov_limit(), dynamic_fov = true, ignore_invisible = true, max_distance = 9999 }
        pcall(function() flickbot.perform(target, ability_type, flick_cfg, target_cfg, Enum.AbilityWait.None) end)
        return
    end
    pcall(function() ability_manager:activate_ability(ability_type) end)
end

local function cast_aimed(target, ability_type)
    aim_target(target)
    cast(target, ability_type)
end

local function cast_unaimed(ability_type)
    pcall(function() ability_manager:activate_ability(ability_type) end)
end

local function rmb_down()
    if not rmb_pressed_by_script then
        local ok = pcall(function() input.press_key(Enum.MouseButton.Right) end)
        if ok then rmb_pressed_by_script = true end
    end
end

local function rmb_up()
    if rmb_pressed_by_script then
        pcall(function() input.release_key(Enum.MouseButton.Right) end)
        rmb_pressed_by_script = false
    end
end

local function perform_global_checks(player)
    local target = select_fov_target(player, nil)
    if not target then return false end
    local distance = distance_m(player, target)
    if distance > 20 then return false end

    if distance >= 13 then
        if not ability1_ready_now(player) then return false end
        cast_aimed(target, ABILITY1)
        wait(200)
        return true
    end

    if distance >= 4 then
        if not ability1_ready_now(player) then return false end
        cast_aimed(target, ABILITY1)
        wait(100)

        if script.get_setting and script.get_setting("black_cat_use_shift") == true then
            aim_target(target)
            wait(50)
            cast(target, Enum.AbilityType.Ability2)
            aim_target(target)
            wait(100)
        elseif ability1_energy(player) >= SECONDARY_REACT_ENERGY then
            aim_target(target)
            rmb_down()
            wait(50)
            cast(target, ABILITY1)
            wait(100)
            rmb_up()
            wait(100)
        end
        return true
    end

    if not ability1_ready_now(player) then return false end
    cast_aimed(target, ABILITY1)
    wait(100)

    if ability1_energy(player) < get_whip_threshold() then
        cast_unaimed(PRIMARY)
        wait(50)
        cast_unaimed(PRIMARY)
        wait(50)
    else
        rmb_down()
        wait(25)
        cast_unaimed(PRIMARY)
        wait(25)
        rmb_up()
        wait(50)
    end
    return true
end

function on_activate_combo(ctx)
    if busy then return false end
    busy = true

    local player = ctx.player or object_manager.get_local_player()
    if not is_black_cat(player) then
        busy = false
        return false
    end

    -- Run only the replacement distance-band flow above.
    pcall(function() perform_global_checks(player) end)

    busy = false
    return true
end

function on_deactivate_combo(ctx)
    last_camera_target = nil
    last_camera_aim_ms = 0
    if lmb_pressed_by_script then
        pcall(function() input.release_key(Enum.MouseButton.Left) end)
        lmb_pressed_by_script = false
    end
    if rmb_pressed_by_script then
        pcall(function() input.release_key(Enum.MouseButton.Right) end)
        rmb_pressed_by_script = false
    end
end
]]
}

local modules = {}
local module_order = {}
local active_modules = {}
local scan_enabled = false
local current_hero_id = nil
local scan_timer_id = nil
local combo_modules_down = {}
local last_combo_button_down = false
local loader_combo_down = false

function camera_look_at_enemy(enemy)
    if not camera or not enemy then return false end
    if not camera.look_at then return false end

    local looked = false
    if enemy.location and pcall(function()
        camera.look_at(enemy.location)
    end) then
        looked = true
    elseif enemy.location and enemy.location.x and enemy.location.y and enemy.location.z and pcall(function()
        camera.look_at(enemy.location.x, enemy.location.y, enemy.location.z)
    end) then
        looked = true
    end

    if looked and camera.get_rotation and camera.set_rotation then
        local ok, rotation = pcall(function()
            return camera.get_rotation()
        end)
        if ok and rotation and rotation.pitch and rotation.yaw then
            pcall(function()
                camera.set_rotation(-rotation.pitch, rotation.yaw)
            end)
        end
    end

    return looked
end


function global_combo_key_down()
    if not script or not script.is_keybind_active then return false end
    return script.is_keybind_active("trigger_key")
end

local function slugify(text)
    text = tostring(text or "module"):lower()
    text = text:gsub("[^%w]+", "_")
    text = text:gsub("^_+", ""):gsub("_+$", "")
    if text == "" then text = "module" end
    return text
end

local function get_setting_number(key, fallback)
    if script and script.get_setting then
        local value = tonumber(script.get_setting(key))
        if value ~= nil then return value end
    end
    return fallback
end

local function get_setting_bool(key, fallback)
    if script and script.get_setting then
        local value = script.get_setting(key)
        if value ~= nil then return value == true end
    end
    return fallback
end

local function valid_player(player)
    return player and (not player.is_dead) and (not player.is_valid or player:is_valid())
end

local function local_player()
    if object_manager and object_manager.get_local_player then
        local ok, player = pcall(function() return object_manager.get_local_player() end)
        if ok then return player end
    end
    return nil
end

local function hero_id_of(player)
    if not player then return nil end
    if player.get_hero_id then
        local ok, id = pcall(function() return player:get_hero_id() end)
        if ok and id then return tonumber(id) end
    end
    return tonumber(player.hero_id)
end

local function local_hero_id()
    local player = local_player()
    if not valid_player(player) then return nil end
    return hero_id_of(player)
end

-- Same as local_hero_id() but does NOT exclude a dead player -- used for the
-- scan_tick kill-switch comparison so death alone never counts as a "hero
-- changed" event. Only an actual hero id swap, or losing the player object
-- entirely (menu/disconnect), kills the scan.
local function local_hero_id_ignore_death()
    local player = local_player()
    if not player then return nil end
    if player.is_valid and not player:is_valid() then return nil end
    return hero_id_of(player)
end

local function safe_call(module, fn_name, ctx)
    if not module or not module.env then return false end
    local fn = module.env[fn_name]
    if type(fn) ~= "function" then return false end
    local ok, result = pcall(fn, ctx)
    if not ok then return false end
    return result
end

local function has_clear_view(unit)
    if not unit then return false end

    if unit.is_visible then
        local ok, visible = pcall(function() return unit:is_visible() end)
        if ok and visible == true then return true end
    end

    if unit.has_line_of_sight then
        local ok, los = pcall(function() return unit:has_line_of_sight() end)
        if ok and los == true then return true end
    end

    return false
end

local ALLY_VISIBLE_FILTER_MODULES = {
    ["AdamAutoHeal KindaSilent"] = true,
    ["MagBubble"] = true,
    ["Magneto Groot Angela"] = true,
}

local function make_player_list_proxy(module)
    local proxy = {}

    setmetatable(proxy, {
        __index = function(_, key)
            if object_manager then return object_manager[key] end
            return nil
        end
    })

    proxy.get_players = function(enemy_team)
        if not object_manager or not object_manager.get_players then return nil end

        local players = object_manager.get_players(enemy_team)
        if type(players) ~= "table" then
            return players
        end

        local filter_units = enemy_team == true
            or (enemy_team == false and module and ALLY_VISIBLE_FILTER_MODULES[module.name] == true)

        if not filter_units then
            return players
        end

        local filtered = {}
        for _, unit in next, players do
            if has_clear_view(unit) then
                filtered[#filtered + 1] = unit
            end
        end

        return filtered
    end

    proxy.get_local_player = function()
        if object_manager and object_manager.get_local_player then
            return object_manager.get_local_player()
        end
        return nil
    end

    return proxy
end

local function make_timer_proxy(module)
    local proxy = {}

    setmetatable(proxy, {
        __index = function(_, key)
            if timer then return timer[key] end
            return nil
        end
    })

    proxy.set_interval = function(callback, interval_ms)
        if not timer or not timer.set_interval then return nil end
        return timer.set_interval(function(...)
            if module.enabled then
                return callback(...)
            end
            return nil
        end, interval_ms)
    end

    proxy.set_timeout = function(callback, timeout_ms)
        if not timer or not timer.set_timeout then return nil end
        return timer.set_timeout(function(...)
            if module.enabled then
                return callback(...)
            end
            return nil
        end, timeout_ms)
    end

    proxy.clear = function(id)
        if timer and timer.clear then return timer.clear(id) end
        return nil
    end

    return proxy
end

local function make_script_proxy(module)
    local proxy = {}

    setmetatable(proxy, {
        __index = function(_, key)
            if key == "get_setting" then
                return function(setting_key)
                    if setting_key == "__panther_mousex1_held" then
                        return loader_combo_down
                    end

                    local mapped = module.setting_key_map and module.setting_key_map[setting_key]
                    if mapped and script and script.get_setting then
                        local value = script.get_setting(mapped)
                        if value ~= nil then return value end
                    end

                    if script and script.get_setting then
                        local value = script.get_setting(setting_key)
                        if value ~= nil then return value end
                    end

                    if module.setting_defaults and module.setting_defaults[setting_key] ~= nil then
                        return module.setting_defaults[setting_key]
                    end

                    return nil
                end
            end

            if script then return script[key] end
            return nil
        end
    })

    return proxy
end

local FLICKBOT_POST_DELAY_MS = 25

local function make_flickbot_proxy()
    local proxy = {}

    setmetatable(proxy, {
        __index = function(_, key)
            if not flickbot then return nil end

            if key == "perform" then
                return function(...)
                    if not flickbot.perform then return nil end

                    local results = { flickbot.perform(...) }
                    if wait then wait(FLICKBOT_POST_DELAY_MS) end

                    if table and table.unpack then
                        return table.unpack(results)
                    end

                    return unpack(results)
                end
            end

            return flickbot[key]
        end
    })

    return proxy
end

local function compile_module(module)
    if module.loaded then return true end

    local env = {}
    local timer_proxy = make_timer_proxy(module)
    local script_proxy = make_script_proxy(module)
    local object_manager_proxy = make_player_list_proxy(module)
    local flickbot_proxy = make_flickbot_proxy()

    setmetatable(env, {
        __index = function(_, key)
            if key == "timer" then return timer_proxy end
            if key == "script" then return script_proxy end
            if key == "object_manager" then return object_manager_proxy end
            if key == "flickbot" then return flickbot_proxy end
            return _G[key]
        end
    })

    env.timer = timer_proxy
    env.script = script_proxy
    env.object_manager = object_manager_proxy
    env.flickbot = flickbot_proxy
    module.env = env

    local chunk, err
    if load then
        local load_ok, load_result, load_err = pcall(function()
            return load(module.source, "@HeroID_AllInOne/" .. module.name, "t", env)
        end)

        if load_ok then
            chunk, err = load_result, load_err
        else
            err = load_result
        end
    end

    if not chunk and loadstring then
        chunk, err = loadstring(module.source, "@HeroID_AllInOne/" .. module.name)
        if chunk and setfenv then setfenv(chunk, env) end
    end

    if not chunk then return false end

    local ok, runtime_err = pcall(chunk)
    if not ok then return false end

    module.loaded = true
    return true
end

local function setting_default(item)
    if type(item) ~= "table" then return nil end
    return item.default
end

local function setting_is_bool(item)
    return type(setting_default(item)) == "boolean"
end

local function setting_is_fov_or_range(item)
    local key = tostring(item.key or ""):lower()
    local label = tostring(item.label or ""):lower()
    return key:find("fov", 1, true) ~= nil
        or key:find("range", 1, true) ~= nil
        or label:find("fov", 1, true) ~= nil
        or label:find("range", 1, true) ~= nil
end

local function clone_setting_for_module(module, item)
    local copy = {}
    for k, v in next, item do copy[k] = v end
    copy.key = module.slug .. "__" .. tostring(item.key)
    copy.label = module.display .. " - " .. tostring(item.label or item.key)
    return copy
end

local function add_setting_unique(seen, item)
    if type(item) ~= "table" then return end
    local key = item.key
    if key == nil or seen[key] then return end
    seen[key] = true
    settings[#settings + 1] = item
end

for _, def in next, MODULE_DEFS do
    local module = {
        name = def.name,
        display = def.name,
        slug = slugify(def.name),
        kind = def.kind,
        source = def.source,
        enabled = false,
        loaded = false,
        env = nil,
        setting_key_map = {},
        setting_defaults = {},
    }
    modules[module.name] = module
    module_order[#module_order + 1] = module
    compile_module(module)
end

local MANUAL_SETTING_MAP = {
    ["AdamAutoHeal KindaSilent"] = {
        require_two_energy = "adam_require_two_energy",
    },
    ["BlackCat"] = {
        fov = "black_cat_fov",
        use_shift = "black_cat_use_shift",
        use_aim = "black_cat_use_aim",
        flickbot = "black_cat_flickbot",
        whip_threshold = "black_cat_whip_threshold",
    },
    ["BlackCatLowHPScan"] = {
        save_me_enabled = "black_cat_save_me_enabled",
        save_me_fov = "black_cat_save_me_fov",
        execute_them_enabled = "black_cat_execute_them_enabled",
        execute_them_fov = "black_cat_execute_them_fov",
        use_aim = "black_cat_use_aim",
        flickbot = "black_cat_flickbot",
        fov = "black_cat_fov",
    },
    ["BlackPanther"] = {
        bp_low_hp_toggle = "bp_low_hp_toggle",
        bp_low_hp_key = "bp_low_hp_key",
        bp_mark_key = "bp_mark_key",
        low_hp_dash_enabled = "bp_low_hp_toggle",
        new_ability_enabled = "bp_new_ability_enabled",
        new_aim_method = "bp_new_aim_method",
        fov = "Blackpanther_aim_fov",
        range_m = "bp_range",
    },
    ["IronFist"] = {
        dash_low_hp_targets = "iron_fist_low_hp_enabled",
        include_shield = "iron_fist_include_shield",
        fov = "iron_fist_fov",
    },
    ["Psylocke"] = {
        dash_low_hp_targets = "psylocke_low_hp_enabled",
        include_shield = "psylocke_include_shield",
        fov = "psylocke_fov",
        range_m = "psylocke_range",
    },
    ["Captain America Dynamic"] = {
        aiming = "cap_combo_aim",
        aim_fov = "cap_combo_fov",
        humanized_aim = "cap_humanized_aim",
    },
    ["Cnd Auto Bubble"] = {
        ignore_shield = "cnd_ignore_shield",
    },
    ["Dino Melee"] = {
    },
    ["DpsPool"] = {
        combo_range = "deadpool_combo_range",
        aim_fov = "deadpool_aim_fov",
        close_range = "deadpool_close_range",
        ignore_shield = "deadpool_ignore_shield",
        prefer_ability_manager = "deadpool_prefer_ability_manager",
    },
    ["Ultimate Cancels"] = {
        fov = "cap_block_fov",
        ultimate_cancel_route = "route_ultimate_cancels_enabled",
        invisible_woman_enabled = "route_invisible_woman_enabled",
    },
    ["Auto Shield CC"] = {
        cc_shield_block_route = "route_auto_shield_cc_enabled",
        cap_shield_block = "route_auto_shield_cc_enabled",
    },
    ["Jeff Auto Bubble"] = {
        ignore_shield = "jeff_ignore_shield",
    },
    ["Magneto Groot Angela"] = {
        team_bubble = "magneto_bubble_allies",
        team_range = "magneto_ally_range",
        flick_ally = "magneto_flick_ally",
        auto_ult_eat = "magneto_auto_ult_eat",
        ult_eat_range = "magneto_ult_eat_range",
        ult_eat_angela = "magneto_eat_angela_ult",
        ult_eat_groot = "magneto_eat_groot_ult",
        shield_cyclops_ult = "magneto_shield_cyclops_ult",
        shield_strange_ult = "magneto_shield_strange_ult",
        shield_strange_range = "magneto_strange_range",
        shield_wolverine_ult = "magneto_shield_wolverine_ult",
        shield_wolverine_range = "magneto_wolverine_range",
        shield_wolverine_shift = "magneto_shield_wolverine_leap",
        shield_wolverine_shift_range = "magneto_wolverine_leap_range",
        shield_wolverine_shift_ally = "magneto_bubble_wolverine_leap_ally",
        shield_wolverine_shift_ally_range = "magneto_wolverine_leap_ally_range",
        shield_ally_ults = "magneto_bubble_ally_ults",
    },
    ["Mantis Heal Buff"] = {
        aim_fov = "mantis_aim_fov",
        team_range = "mantis_team_range",
        include_shield = "mantis_include_shield",
    },
    ["Spiderman Dynamic"] = {
        hydro_low_hp_override = "spiderman_hydro_low_hp",
    },
    ["Thor"] = {
        fov_limit = "thor_fov",
        rmb_fov_limit = "thor_rmb_fov",
        use_rmb = "thor_use_rmb",
        use_f = "thor_use_f",
    },
}

local MODULE_ENABLE_SETTINGS = {
    ["AdamAutoHeal KindaSilent"] = "adam_auto_heal_enabled",
    ["Adamquickfire"] = "adam_quick_fire_enabled",
    ["BlackCatLowHPScan"] = "route_black_cat_enabled",
    ["Ultimate Cancels"] = "route_ultimate_cancels_enabled",
    ["Ultimate Cancels Test"] = "ultimate_cancels_test_enabled",
    ["Auto Shield CC"] = "route_auto_shield_cc_enabled",
    ["MagBubble"] = "magneto_bubble_allies",
    ["Mantis Heal Buff"] = "mantis_heal_buff_enabled",
}

local REPEAT_WHILE_HELD_COMBOS = {
    ["Adamquickfire"] = true,
    ["BlackCat"] = true,
    ["Captain America Dynamic"] = true,
    ["Cyclops Melee"] = true,
    ["DpsPool"] = true,
    ["StrangeAnimCancel"] = true,
    ["Thor"] = true,
}

for _, module in next, module_order do
    local module_settings = module.env and module.env.settings or nil
    if type(module_settings) == "table" then
        for _, item in next, module_settings do
            if type(item) == "table" and item.key then
                module.setting_defaults[item.key] = setting_default(item)
            end
        end
    end

    local map = MANUAL_SETTING_MAP[module.name]
    if type(map) == "table" then
        for source_key, mapped_key in next, map do
            module.setting_key_map[source_key] = mapped_key
        end
    end
end

local HERO_MODULES = {
    [HERO_CAPTAIN_AMERICA] = {
        route_key = "route_cap_enabled",
        scanners = { "Auto Shield CC" },
        combos = { "Captain America Dynamic" },
    },
    [HERO_DOCTOR_STRANGE] = {
        route_key = "route_strange_enabled",
        scanners = { "Auto Shield CC" },
        combos = { "StrangeAnimCancel" },
    },
    [HERO_LUNA] = {
        route_key = "route_luna_enabled",
        scanners = { "Ultimate Cancels", "Ultimate Cancels Test" },
        combos = {},
    },
    [HERO_SCARLET_WITCH] = {
        route_key = "route_scarlet_enabled",
        scanners = { "Ultimate Cancels", "Ultimate Cancels Test" },
        combos = {},
    },
    [HERO_ADAM] = {
        route_key = "route_adam_enabled",
        scanners = { "AdamAutoHeal KindaSilent" },
        combos = { "Adamquickfire" },
    },
    [HERO_MAGNETO] = {
        route_key = "route_magneto_enabled",
        scanners = { "Auto Shield CC", "MagBubble", "Magneto Groot Angela" },
        combos = {},
    },
    [HERO_CLOAK_DAGGER] = {
        route_key = "route_cnd_enabled",
        scanners = { "Cnd Auto Bubble" },
        combos = {},
    },
    [HERO_BRUCE_BANNER] = {
        route_key = "route_hulk_enabled",
        scanners = { "Ultimate Cancels", "HulkSpaceHold", "Ultimate Cancels Test" },
        combos = {},
    },
    [HERO_BLACK_PANTHER] = {
        route_key = "route_bp_enabled",
        scanners = { "BlackPanther" },
        combos = {},
    },
    [HERO_IRON_FIST] = {
        route_key = "route_iron_fist_enabled",
        scanners = { "IronFist" },
        combos = {},
    },
    [HERO_PSYLOCKE] = {
        route_key = "route_psylocke_enabled",
        scanners = { "Psylocke" },
        combos = {},
    },
    [HERO_ANGELA] = {
        route_key = "route_angela_enabled",
        scanners = { "Auto Shield CC" },
        combos = {},
    },
    [HERO_INVISIBLE_WOMAN] = {
        route_key = "route_invisible_woman_enabled",
        scanners = { "Ultimate Cancels", "Ultimate Cancels Test" },
        combos = {},
    },
    [HERO_SPIDERMAN] = {
        route_key = "route_spiderman_enabled",
        scanners = { "Ultimate Cancels", "AutoOverhead", "Ultimate Cancels Test" },
        combos = { "Spiderman Dynamic" },
    },
    [HERO_BUCKY] = {
        route_key = "route_bucky_enabled",
        scanners = { "Ultimate Cancels" },
        combos = {},
    },
    [HERO_PENI] = {
        route_key = "route_peni_enabled",
        scanners = { "Ultimate Cancels", "Ultimate Cancels Test" },
        combos = {},
    },
    [HERO_WHITEFOX] = {
        route_key = "route_whitefox_enabled",
        scanners = { "Ultimate Cancels", "Ultimate Cancels Test" },
        combos = {},
    },
    [HERO_BLACK_CAT] = {
        route_key = "route_black_cat_enabled",
        scanners = { "BlackCatLowHPScan" },
        combos = { "BlackCat" },
    },
    [HERO_MANTIS] = {
        route_key = "route_mantis_enabled",
        scanners = { "Mantis Heal Buff" },
        combos = {},
    },
    [HERO_JEFF] = {
        route_key = "route_jeff_enabled",
        scanners = { "Jeff Auto Bubble" },
        combos = {},
    },
    [HERO_DEVIL_DINO] = {
        route_key = "route_dino_enabled",
        scanners = { "Dino Melee" },
        combos = {},
    },
    [HERO_DEADPOOL] = {
        route_key = "route_deadpool_enabled",
        scanners = {  },
        combos = { "DpsPool" },
    },
    [HERO_DEADPOOL_DMG] = {
        route_key = "route_deadpool_enabled",
        scanners = {  },
        combos = { "DpsPool" },
    },
    [HERO_DEADPOOL_STRAT] = {
        route_key = "route_deadpool_enabled",
        scanners = {  },
        combos = { "DpsPool" },
    },
    [HERO_THOR] = {
        route_key = "route_thor_enabled",
        scanners = {  },
        combos = { "Thor" },
    },
    [HERO_CYCLOPS] = {
        route_key = "route_cyclops_enabled",
        scanners = {  },
        combos = { "Cyclops Melee" },
    },
}

local function route_enabled_for_plan(plan)
    if not plan then return false end
    if not plan.route_key then return true end
    return get_setting_bool(plan.route_key, true) == true
end

local function disable_module(name, reason)
    local module = modules[name]
    if not module then return end
    if module.enabled then
        safe_call(module, "on_deactivate_combo", { reason = reason or "scan disable" })
    end
    module.enabled = false
    active_modules[name] = nil
    combo_modules_down[name] = nil
end

local function disable_all(reason)
    for name in next, active_modules do
        disable_module(name, reason)
    end
    current_hero_id = nil
end

local function stop_scan(reason)
    disable_all(reason)
    scan_enabled = false
    last_combo_button_down = false
end

local function enable_module(name, ctx)
    local module = modules[name]
    if not module then return false end
    local toggle_key = MODULE_ENABLE_SETTINGS[name]
    if toggle_key and get_setting_bool(toggle_key, true) ~= true then return false end
    if not compile_module(module) then return false end
    module.enabled = true
    active_modules[name] = true
    safe_call(module, "on_activate_combo", ctx)
    return true
end

local function scanner_enabled_for_hero(scanner_name, hero_id)
    return true
end

local function ensure_scanners_for_hero(hero_id, ctx)
    local plan = HERO_MODULES[hero_id]
    if not plan then return false end
    if not route_enabled_for_plan(plan) then return false end

    for _, scanner_name in next, plan.scanners or {} do
        local toggle_key = MODULE_ENABLE_SETTINGS[scanner_name]
        if not scanner_enabled_for_hero(scanner_name, hero_id) then
            disable_module(scanner_name, "scanner setting disabled")
        elseif toggle_key and get_setting_bool(toggle_key, true) ~= true then
            disable_module(scanner_name, "module setting disabled")
        elseif not active_modules[scanner_name] then
            enable_module(scanner_name, ctx)
        else
            modules[scanner_name].enabled = true
        end
    end

    return true
end

local function disable_modules_not_for_hero(hero_id)
    local plan = HERO_MODULES[hero_id]
    local allowed = {}

    if route_enabled_for_plan(plan) then
        for _, scanner_name in next, plan.scanners or {} do
            if scanner_enabled_for_hero(scanner_name, hero_id) then
                allowed[scanner_name] = true
            end
        end

        for _, combo_name in next, plan.combos or {} do
            allowed[combo_name] = true
        end
    end

    for name in next, active_modules do
        if not allowed[name] then
            disable_module(name, "hero changed")
        end
    end
end

local function valid_enemy(enemy)
    return enemy and (not enemy.is_dead) and (not enemy.is_valid or enemy:is_valid()) and (not enemy.is_enemy or enemy:is_enemy()) and enemy.location
end

local function distance_m(a, b)
    if not a or not b or not a.location or not b.location then return math.huge end
    local ok, d = pcall(function()
        if a.location.get_distance_to_meters then
            return a.location:get_distance_to_meters(b.location)
        end
        return a.location:get_distance_to(b.location) * 0.01
    end)
    return ok and d or math.huge
end

local function fov_to(enemy)
    if not enemy or not enemy.get_fov_to_target then return 0 end
    local ok, fov = pcall(function() return enemy:get_fov_to_target() end)
    return ok and tonumber(fov) or 0
end

local function enemy_visible(enemy)
    if not enemy then return false end
    if enemy.is_visible then
        local ok, visible = pcall(function() return enemy:is_visible() end)
        if ok and visible == true then return true end
    end
    if enemy.has_line_of_sight then
        local ok, los = pcall(function() return enemy:has_line_of_sight() end)
        if ok and los == true then return true end
    end
    return false
end

local function find_scan_target(player)
    if not valid_player(player) or not object_manager or not object_manager.get_players then return nil end
    local enemies = object_manager.get_players(true)
    if type(enemies) ~= "table" then return nil end

    local best = nil
    local best_score = math.huge
    local max_fov = 60
    local max_range = 30

    for _, enemy in next, enemies do
        if valid_enemy(enemy) and enemy_visible(enemy) then
            local d = distance_m(player, enemy)
            local f = fov_to(enemy)
            if d <= max_range and f <= max_fov then
                local score = (f * 10) + d
                if score < best_score then
                    best = enemy
                    best_score = score
                end
            end
        end
    end

    return best
end

local function make_combo_ctx(ctx)
    local player = (ctx and ctx.player) or local_player()
    local target = ctx and ctx.target or nil

    if target and (not valid_enemy(target) or not enemy_visible(target)) then
        target = nil
    end

    target = target or find_scan_target(player)
    return { player = player, target = target, scan = true }
end

local function run_combos_for_hero(hero_id, ctx)
    local plan = HERO_MODULES[hero_id]
    if not plan then return false end
    if not route_enabled_for_plan(plan) then return false end

    local combo_ctx = make_combo_ctx(ctx)
    if not valid_player(combo_ctx.player) then return false end

    local ran = false
    for _, combo_name in next, plan.combos or {} do
        local module = modules[combo_name]
        local toggle_key = MODULE_ENABLE_SETTINGS[combo_name]
        if toggle_key and get_setting_bool(toggle_key, true) ~= true then
            disable_module(combo_name, "module setting disabled")
        elseif module and compile_module(module) then
            module.enabled = true
            active_modules[combo_name] = true
            combo_modules_down[combo_name] = true
            safe_call(module, "on_activate_combo", combo_ctx)
            ran = true
        end
    end

    return ran
end

local function combo_repeats_while_held(hero_id)
    local plan = HERO_MODULES[hero_id]
    if not plan then return false end

    for _, combo_name in next, plan.combos or {} do
        if REPEAT_WHILE_HELD_COMBOS[combo_name] then
            return true
        end
    end

    return false
end

-- SIGNATURE: sticky lifecycle
-- on_activate_combo locks onto whatever hero id is current at that moment and
-- starts the scan timer. From then on, scanners keep scanning and the trigger_key
-- fires the hero's combo(s) each time it is pressed -- none of that depends on the
-- activation bind being held. on_deactivate_combo (activation bind release) is a no-op.
-- The ONLY thing that stops everything is the local hero id changing from
-- whatever it was at activation time -- to a different hero, or to nothing
-- (e.g. death/respawn/menu). A changed hero id always kills everything and
-- requires on_activate_combo to be pressed again, even if the new id is a
-- perfectly valid hero.

local function combo_trigger_down()
    if not script or not script.is_keybind_active then return false end
    return script.is_keybind_active("trigger_key") == true
end

local function handle_combo_trigger(hero_id)
    local down = combo_trigger_down()
    if down and (not last_combo_button_down or combo_repeats_while_held(hero_id)) then
        run_combos_for_hero(hero_id, nil)
    elseif not down and last_combo_button_down then
        local plan = HERO_MODULES[hero_id]
        if plan then
            for _, combo_name in next, plan.combos or {} do
                if combo_modules_down[combo_name] then
                    local module = modules[combo_name]
                    safe_call(module, "on_deactivate_combo", { reason = "combo trigger release", scan = true })
                    combo_modules_down[combo_name] = nil
                end
            end
        end
    end
    last_combo_button_down = down
end

local function scan_tick()
    if not scan_enabled then return end

    if input and input.is_key_down and input.is_key_down(END_KEY) then
        stop_scan("end key")
        return
    end

    -- Death alone never counts as a hero change -- see local_hero_id_ignore_death.
    local hero_id = local_hero_id_ignore_death()

    if hero_id ~= current_hero_id then
        -- An actual hero id swap -- valid, invalid, or nil (lost the player
        -- object) -- kills everything until on_activate_combo fires again.
        stop_scan("hero id changed")
        return
    end

    if not hero_id then return end

    local plan = HERO_MODULES[hero_id]
    if not route_enabled_for_plan(plan) then
        disable_modules_not_for_hero(hero_id)
        return
    end

    ensure_scanners_for_hero(hero_id, nil)
    handle_combo_trigger(hero_id)
end

local function start_scan_timer()
    if scan_timer_id or not timer or not timer.set_interval then return end
    scan_timer_id = timer.set_interval(scan_tick, get_setting_number("scan_poll_ms", 100))
end

function on_activate_combo(ctx)
    loader_combo_down = true

    if input and input.is_key_down and input.is_key_down(END_KEY) then
        stop_scan("end key")
        return true
    end

    if scan_enabled then
        -- Already running (locked onto current_hero_id) -- activating again
        -- while still active is a no-op, it does not re-lock the hero id.
        return true
    end

    current_hero_id = local_hero_id_ignore_death()
    last_combo_button_down = false
    scan_enabled = true
    start_scan_timer()
    scan_tick()
    return true
end

function on_deactivate_combo(ctx)
    loader_combo_down = false
    -- Releasing the activation bind intentionally does nothing. Scanning and
    -- combo-firing keep running until the hero id changes (see scan_tick)
    -- or the End key panic-stop is hit.
    return true
end
