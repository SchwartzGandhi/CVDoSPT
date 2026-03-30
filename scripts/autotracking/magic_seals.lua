MAGIC_SEAL_TO_ID = {
    {name = "Magic Seal 1", id = 0},
    {name = "Magic Seal 2", id = 1},
    {name = "Magic Seal 3", id = 2},
    {name = "Magic Seal 4", id = 3},
    {name = "Magic Seal 5", id = 4},
}

function get_seal_stage(stageseal)
    for i, seal  in ipairs(MAGIC_SEAL_TO_ID) do
        if seal.name == stageseal then
            return seal.id
        end
    end
end