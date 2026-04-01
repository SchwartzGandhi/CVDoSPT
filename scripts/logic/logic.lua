-- put logic functions here using the Lua API: https://github.com/black-sliver/PopTracker/blob/master/doc/PACKS.md#lua-interface
-- don't be afraid to use custom logic functions. it will make many things a lot easier to maintain, for example by adding logging.
-- to see how this function gets called, check: locations/locations.json
-- example:
ScriptHost:LoadScript("scripts/autotracking/bullet_souls.lua")

function has_more_then_n_consumable(n)
    local count = Tracker:ProviderCountForCode('consumable')
    local val = (count > tonumber(n))
    if ENABLE_DEBUG_LOG then
        print(string.format("called has_more_then_n_consumable: count: %s, n: %s, val: %s", count, n, val))
    end
    if val then
        return 1 -- 1 => access is in logic
    end
    return 0 -- 0 => no access
end

function has(item, amount)
    local count = Tracker:ProviderCountForCode(item)
    amount = tonumber(amount)
    if not amount then
        return count > 0
    else
        return count >= amount
    end
end

-- Move Macros
function smalluppies()
    return has("zip") or has("bat") or has("jump")
end

function tinyuppies()
    return smalluppies() or has("puppet")
end

function biguppies()
    return has("zip") or has("bat")
end

function widies()
    return has("glide") or has("fast")
end

function holes()
    return has("puppet") or has("bat")
end

-- Settings Macros
function abyssaccess()
    return has("abyss") or has("abyssplus")
end

function workingbuttons()
    if has("buttonsoff") or has("buttonkeys") then
        return true
    end
end

function low()
    if not has("speed") then
        return true
    end
end

function vanillasouls()
    if not has("soulsanity") then
        return true
    end
end

function oulviewoff()
    if not has("soulview") then
        return true
    end
end

function gateclips()
    if has("buttonsoff") or has("buttonkeys") then
        if has("backslash") then
            return AccessibilityLevel.SequenceBreak
        end
    else
        if has("backslash") and has("yoko") then
            return AccessibilityLevel.SequenceBreak
        end
    end
    return AccessibilityLevel.None
end

function unsupportedgate()
    if has("backslash") then
        return AccessibilityLevel.SequenceBreak
    else
        return AccessibilityLevel.None
    end
end

function OpenSoulWall(wall)
    local soul = Tracker:FindObjectForCode(wall)
    -- If soulsanity is off, the player needs access to the enemy's region.
    -- If soulsanity is on, the player just needs the enemy's soul.
    if not has("soulsanity") then
        local enemy = get_name_for_wall(soul.CurrentStage)
        local enemy_region = Tracker:FindObjectForCode(string.format('@Soul Farming Regions/%s', enemy))
        if enemy_region.AccessibilityLevel == AccessibilityLevel.Normal then
            return AccessibilityLevel.Normal
        elseif enemy_region.AccessibilityLevel == AccessibilityLevel.SequenceBreak then
            return AccessibilityLevel.SequenceBreak
        end
    else
        local code = get_code_for_wall(soul.CurrentStage)
        return has(code)
    end
end

function GetSeal(door)
    local seal = Tracker:FindObjectForCode(door)
    return has(string.format("seal%s", seal.CurrentStage + 1))
end

function allbosses(mode)
    local boss_reach = {
        armor = Tracker:FindObjectForCode("@The Lost Village/Flying Armor Soul/").AccessibilityLevel,
        balore = Tracker:FindObjectForCode("@Wizardry Lab/Balore Soul/").AccessibilityLevel,
        dario = Tracker:FindObjectForCode("@Garden of Madness/Dario/").AccessibilityLevel,
        puppet = Tracker:FindObjectForCode("@Demon Guest House/Puppet Master Soul/").AccessibilityLevel,
        dmitrii = Tracker:FindObjectForCode("@The Dark Chapel/Dmitrii/").AccessibilityLevel,
        malphas = Tracker:FindObjectForCode("@The Dark Chapel/Malphas Soul/").AccessibilityLevel,
        gergoth = Tracker:FindObjectForCode("@Condemned Tower/Gergoth Soul/").AccessibilityLevel,
        rahab = Tracker:FindObjectForCode("@Subterranean Hell/Rahab Soul/").AccessibilityLevel,
        zephyr = Tracker:FindObjectForCode("@Cursed Clock Tower/Zephyr Soul/").AccessibilityLevel,
        bat = Tracker:FindObjectForCode("@Silenced Ruins/Bat Company Soul/").AccessibilityLevel,
        aguni = Tracker:FindObjectForCode("@The Pinnacle/Aguni Soul/").AccessibilityLevel,
        paranoia = Tracker:FindObjectForCode("@Demon Guest House/Paranoia Soul/").AccessibilityLevel
    }
    local post_mine = {
        death = Tracker:FindObjectForCode("@Mine of Judgment/Death Soul/").AccessibilityLevel,
        abaddon = Tracker:FindObjectForCode("@The Abyss/Abaddon Soul/").AccessibilityLevel
    }

    -- Break and return false if any boss listed isn't reachable.
    for name, access in pairs(boss_reach) do
        if access ~= AccessibilityLevel.Normal then
            -- print(string.format("%s is cringe", name))
            return false
        end
        -- print(string.format("%s is based", name))
    end

    -- Garden doesn't need all bosses if mine is set to garden or all bosses.
    -- Mine never needs all bosses.
    -- Menace always needs all bosses.
    if mode == "menace" or (mode == "garden" and (has("openmine") or has("minethrone"))) then
        for _, access in pairs(post_mine) do
            if access ~= AccessibilityLevel.Normal then
                return false
            end
        end
    end

    -- If it hasn't returned already it must be in logic.
    return true
end