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

function abyssaccess()
    return has("abyss") or has("abyssplus")
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

function cutallclips()
    if has("cutall") then
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