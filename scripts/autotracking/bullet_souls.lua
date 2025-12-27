BULLET_SOULS_FOR_WALLS = {
    {code = "skeleton", name = "Skeleton Soul"},
    {code = "zombie", name = "Zombie Soul"},
    {code = "axe", name = "Axe Armor Soul"},
    {code = "switch", name = "Student Witch Soul"},
    {code = "warg", name = "Warg Soul"},
    {code = "bomber", name = "Bomber Armor Soul"},
    {code = "angel", name = "Amalaric Sniper Soul"},
    {code = "troll", name = "Cave Troll Soul"},
    {code = "food", name = "Waiter Skeleton Soul"},
    {code = "slime", name = "Slime Soul"},
    {code = "soccer", name = "Yorick Soul"},
    {code = "une", name = "Une Soul"},
    {code = "yell", name = "Mandragora Soul"},
    {code = "shock", name = "Rycuda Soul"},
    {code = "littleguy", name = "Fleaman Soul"},
    {code = "littleguy2", name = "Ripper Soul"},
    {code = "guillotine", name = "Guillotiner Soul"},
    {code = "clown", name = "Killer Clown Soul"},
    {code = "cthulu", name = "Malachi Soul"},
    {code = "disc", name = "Disc Armor Soul"},
    {code = "bigaxe", name = "Great Axe Armor Soul"},
    {code = "pinkpig", name = "Slaughterer Soul"},
    {code = "bluepig", name = "Hell Boar Soul"},
    {code = "icedemon", name = "Frozen Shade Soul"},
    {code = "fishguy", name = "Merman Soul"},
    {code = "larva", name = "Larva Soul"},
    {code = "flame", name = "Ukoback Soul"},
    {code = "wheel", name = "Decarabia Soul"},
    {code = "yoko", name = "Succubus Soul"},
    {code = "flaahgra", name = "Slogra Soul"},
    {code = "valkyrie2", name = "Erinys Soul"},
    {code = "humanchicken", name = "Homunculus Soul"},
    {code = "witch", name = "Witch Soul"},
    {code = "bonepillarfish", name = "Fish Head Soul"},
    {code = "slug", name = "Mollusca Soul"},
    {code = "dog", name = "Dead Mate Soul"},
    {code = "lubicant3", name = "Malacoda Soul"},
    {code = "devil2", name = "Flame Demon Soul"},
    -- {code = "aguni", name = "Aguni Soul"},
    {code = "famine", name = "Abaddon Soul"},
}

-- Returns the index for the given enemy name (ie: Student Witch Soul)
function get_idx_for_wall(soul)
    for i, enemy in ipairs(BULLET_SOULS_FOR_WALLS) do
        if enemy.name == soul then
            return i - 1 -- Lua is cringe and doesn't index on 0?
        end
    end
end

-- Retursn the code for the given enemy's index (ie: 4)
function get_code_for_wall(id)
    for i, enemy in ipairs(BULLET_SOULS_FOR_WALLS) do
        if id + 1 == i then
            return enemy.code
        end
    end
end