-- put logic functions here using the Lua API: https://github.com/black-sliver/PopTracker/blob/master/doc/PACKS.md#lua-interface
-- don't be afraid to use custom logic functions. it will make many things a lot easier to maintain, for example by adding logging.
-- to see how this function gets called, check: locations/locations.json
-- example:
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

function mediumuppies()
    return smalluppies() or has("puppet")
end

function biguppies()
    return has("zip") or has("bat")
end

function holes()
    return has("puppet") or has("bat")
end

function slow()
    if not has("speed") then
        return true
    end
end

function vanillasouls()
    if not has("soulsanity") then
        return true
    end
end

function gated()
    if not has("drawbridge") then
        return true
    end
end