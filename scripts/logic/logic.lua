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

function ukoback()
    return SHShaftBottom() or SHCentralExit()
end

-- The Lost Village Regions
function LVUpper()
    return
        true -- Starting Region
        or LVUpperDoorway()
        or DGHLower()
        or (LVLower() and has("seal1"))
end

function LVUpperDoorway()
    return
        (LVUpper() and ((has("puppet") and has("armor")) or smalluppies()))
        or DGHNumberPuzzleWest()
end

function LVLower()
    return
        (LVUpper() and has("seal1"))
        or LVUndergroundTop()
        -- or WLMain() and Moat Drained
end

function LVUndergoundBottom()
    return
        WLSunkenWestDoor()
        or LVUndergroundMiddle()
end

function LVUndergoundMiddle()
    return
        (LVUndergoundBottom() and mediumuppies())
        or WLWestGate()
        or LVUndergoundTop()
end

function LVUndergroundTop()
    return LVUndergoundMiddle() and mediumuppies()
end

-- Wizardry Lab Regions
function WLMain()
    return
        (LVUpper() and LVLower() and (mediumuppies() or has("armor")))
        or WLEastGate()
        or WLWestGate()
        or GoMLower()
end

function WLWestGate()
    return LVUndergoundMiddle()
end

function WLEastGate()
    return SHShaftTop()
end

function WLSunken()
    return
        WLSunkenEastDoor()
        or WLSunkenWestDoor()
end

function WLSunkenWestDoor()
    return 
        WLSunken()
        or LVUndergoundBottom()
end

function WLSunkenEastDoor()
    return
        SHSpikeRoomWest()
        or WLSunken()
end

-- Garden of Madness Regions
function GoMLower()
    return
        (WLMain() and (has("ice") or smalluppies()))
        or GoMWaterBlocked() and has("water")
        or GoMUpper()
        or DGHLower()
        or DC()
        -- or false
end

function GoMUpper()
    return
        (GoMLower() and mediumuppies())
        or GoMPostBoss() and has("seal2")
end

function GoMWaterBlocked()
    return
        (GoMLower() and has("water"))
        or SHCentralExit()
end

function GoMPostBoss()
    return
        (GoMUpper() and has("seal2"))
        or DGHMain()
end

function GoMEastGate()
    return CCTEntrance()
end

-- The Dark Chapel Regions
function DC()
    return
        GoMLower()
        or DCBigRoom()
        or CTBottom()
        or (SHTopEntrance() and holes())
end

function DCBigRoom()
    return
        (DC() and holes())
        or (CTBottom() and smalluppies())
end

-- Demon Guest House Regions
function DGHMain()
    return 
        GoMPostBoss()
        or (DGHPuppetWallRight() and holes())
        or DGHNumberPuzzle()
        or (DGHWestWing() and holes())
        or DGHUpper()
end

function DGHPuppetWallRight()
    return
        (DGHMain() and holes())
        or (DGHLower() and mediumuppies())
end

function DGHLower()
    return
        (LVUpper() and smalluppies())
        or GoMLower()
        or DGHPuppetWallRight()
end

function DGHNumberPuzzle()
    return
        DGHMain()
        or DGHWestWing()
end

function DGHNumberPuzzleWest()
    return
        LVUpperDoorway()
        or DGHNumberPuzzle()
end

function DGHWestWing()
    return
        (DGHMain() and holes())
        or DGHNumberPuzzle()
end

function DGHUpper()
    return TPLower()
end

-- Condemned Tower Regions
function CTBottom()
    return
        DCBigRoom()
        or CTTop()
end

function CTTop()
    return
        (
            CTBottom() and (
                biguppies() or (
                    has("armor") and (
                        has("jump") or has("puppet")
                    )
                )
            )
        )
        or (CCTEntrance() and has("tkey"))
end

-- Cursed Clock Tower Regions
function CCTEntrance()
    return
        (CTTop() and has("tkey"))
        or GoMEastGate()
        or (CCTCentral() and mediumuppies())
        or CCTBossArea()
end

function CCTCentral()
    return
        (CCTEntrance() and mediumuppies())
        or CCTBossArea()
end

function CCTBossArea()
    return
        CCTCentral()
        or (CCTExit() and (has("seal4") and has("bat")))
end

function CCTExit()
    return
        (CCTBossArea() and (has("seal4") and has("bat")))
        or (TPLower() and mediumuppies())
end

-- Subterranean Hell Regions
function SHTopEntrance()
    return
        (DC() and holes())
        or (SHEast() and (has("water") and has("seal3") and mediumuppies()))
end

function SHEast()
    return
        (SHTopEntrance() and (has("water") and has("seal3")))
        or SHCentralEastConnection()
end

function SHCentralEastConnection()
    return
        (SHEast() and mediumuppies())
        or (SHCentralUpper() and (has("water") or has("jump")) and mediumuppies())
end

function SHCentralUpper()
    return
        (SHCentralEastConnection() and (has("water") or has("jump")))
        or (SHCentralLower() and mediumuppies())
        or (SHCentralExit() and (has("water") or has("jump")))
end

function SHCentralExit()
    return
        (SHCentralUpper() and mediumuppies())
        or GoMWaterBlocked()
end

function SHCentralLower()
    return
        (SHCentralUpper() and mediumuppies())
        or SHShaftMiddle()
        or SHShaftBottom()
end

function SHShaftMiddle()
    return
        SHCentralLower()
        or SHShaftTop()
        or (SHShaftBottom() and mediumuppies())
end

function SHShaftTop()
    return SHShaftMiddle() and biguppies()
end

function SHShaftBottom()
    return
        SHShaftMiddle()
        or WLEastGate()
        or SRAntechamber()
end

function SHSpikeRoomWest()
    return
        SHSpikeRoomEast()
        -- bro doesn't know about bone ark
        or WLSunkenEastDoor()
end

function SHSpikeRoomEast()
    return
        (SHShaftBottom() and mediumuppies())
        or SHSpikeRoomWest()
        -- bro doesn't know about bone ark
end

-- Silenced Ruins Regions
function SRAntechamber()
    return 
        (SHShaftBottom() and (mediumuppies() or has("armor")))
        or (SR() and has("dio"))
end

function SR()
    return
        (SRAntechamber() and has("dio"))
        or SRBackExit() -- TODO
end

function SRBackExit()
    return SR() and smalluppies()
end

-- The Pinnacle Regions
function TP()
    return TPLower() and smalluppies()
end

function TPThroneRoom()
    return TP() and biguppies()
end

function TPLower()
    return
        CCTExit()
        or TP()
        or DGHUpper()
end

-- Mine of Judgement Regions
function MoJ()
    return
        CTBottom() -- TODO mine conditions
        or (TA() and smalluppies())
end

-- The Abyss Regions
function TA()
    return MoJ() and mediumuppies()
end

function TABeyondAbaddon()
    return TA() and biguppies() and has("seal5")
end