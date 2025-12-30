-- entry point for all lua code of the pack
-- more info on the lua API: https://github.com/black-sliver/PopTracker/blob/master/doc/PACKS.md#lua-interface
ENABLE_DEBUG_LOG = true
-- get current variant
local variant = Tracker.ActiveVariantUID
-- check variant info
IS_ITEMS_ONLY = variant:find("itemsonly")

LINKED_SOULS = {
	["glide"] = "armor",
	["ice"] = "balore",
	["jump"] = "malphas",
	["puppet"] = "ningyo",
	["water"] = "rahab",
	["fastwater"] = "waterface",
	["fastmud"] = "mudface",
	["dio"] = "zawarudo",
	["bat"] = "bad",
	["mirror"] = "jester",
	["spirit"] = "imp",
	["throw"] = "drydk",
	["ride"] = "bark",
	["fast"] = "wakanda",
	["food"] = "waiter",
	["yell"] = "freak",
	["shock"] = "bird",
	["bone"] = "skeleton",
	["axe"] = "smallaxe",
	["cards"] = "clown",
	["flame"] = "goblin"
}

print("-- Example Tracker --")
print("Loaded variant: ", variant)
if ENABLE_DEBUG_LOG then
    print("Debug logging is enabled!")
end

-- Utility Script for helper functions etc.
ScriptHost:LoadScript("scripts/utils.lua")

-- Logic
ScriptHost:LoadScript("scripts/logic/logic.lua")

-- Custom Items
ScriptHost:LoadScript("scripts/custom_items/class.lua")
ScriptHost:LoadScript("scripts/custom_items/progressiveTogglePlus.lua")
ScriptHost:LoadScript("scripts/custom_items/progressiveTogglePlusWrapper.lua")

-- Items
Tracker:AddItems("items/items.jsonc")
Tracker:AddItems("items/red_souls.jsonc")
Tracker:AddItems("items/blue_souls.jsonc")
Tracker:AddItems("items/yellow_souls.jsonc")
Tracker:AddItems("items/grey_souls.jsonc")
Tracker:AddItems("items/settings.json")

-- Link item codes and bestiary codes
for k, v in pairs(LINKED_SOULS) do
    ScriptHost:AddWatchForCode(k, v, LinkSouls)
    ScriptHost:AddWatchForCode(v, k, LinkSouls)
end

if not IS_ITEMS_ONLY then -- <--- use variant info to optimize loading
    -- Maps
    Tracker:AddMaps("maps/maps.jsonc")
    -- Locations
    Tracker:AddLocations("locations/regions.jsonc")
    Tracker:AddLocations("locations/locations.jsonc")
    Tracker:AddLocations("locations/frontend.jsonc")
    Tracker:AddLocations("locations/soulsanity.jsonc")
    Tracker:AddLocations("locations/soulsbyregion.jsonc")
end

-- Layout
Tracker:AddLayouts("layouts/items.jsonc")
Tracker:AddLayouts("layouts/bestiary.jsonc")
Tracker:AddLayouts("layouts/popup.json")
Tracker:AddLayouts("layouts/tracker.jsonc")
Tracker:AddLayouts("layouts/broadcast.jsonc")

-- AutoTracking for Poptracker
if PopVersion and PopVersion >= "0.18.0" then
    ScriptHost:LoadScript("scripts/autotracking.lua")
end
