REGION_TABLE = {
    {name = "Lost Village", code = "lv", id = 1},
    {name = "Wizardry Lab", code = "wl", id = 2},
    {name = "Garden of Madness", code = "gom", id = 3},
    {name = "Dark Chapel", code = "dc", id = 4},
    {name = "Dark Chapel Inner", code = "dc2", id = 4},
    {name = "Demon Guest House", code = "dgh", id = 5},
    {name = "Condemned Tower", code = "ct", id = 6},
    {name = "Cursed Clock Tower", code = "cct", id = 7},
    {name = "Subterranean Hell", code = "sh", id = 8},
    {name = "Silenced Ruins", code = "sr", id = 9},
    {name = "The Pinnacle", code = "tp", id = 10},
    {name = "Demon Guest House Upper", code = "dgh2", id = 5},
    {name = "Castle Center", code = "gom2", id = 3},
    {name = "Mine of Judgment", code = "moj", id = 11},
    {name = "The Abyss", code = "ta", id = 12},
}

MAGIC_SEAL_TO_ID = {
    {name = "Magic Seal 1", id = 0},
    {name = "Magic Seal 2", id = 1},
    {name = "Magic Seal 3", id = 2},
    {name = "Magic Seal 4", id = 3},
    {name = "Magic Seal 5", id = 4},
}

function get_seal_stage(stageseal)
    for _, seal  in ipairs(MAGIC_SEAL_TO_ID) do
        if seal.name == stageseal then
            return seal.id
        end
    end
end