BULLET_SOULS_FOR_WALLS = {
    "Skeleton Soul",
    "Zombie Soul",
    "Axe Armor Soul",
    "Student Witch Soul",
    "Warg Soul",
    "Bomber Armor Soul",
    "Amalaric Sniper Soul",
    "Cave Troll Soul",
    "Waiter Skeleton Soul",
    "Slime Soul",
    "Yorick Soul",
    "Une Soul",
    "Mandragora Soul",
    "Rycuda Soul",
    "Fleaman Soul",
    "Ripper Soul",
    "Guillotiner Soul",
    "Killer Clown Soul",
    "Malachi Soul",
    "Disc Armor Soul",
    "Great Axe Armor Soul",
    "Slaughterer Soul",
    "Hell Boar Soul",
    "Frozen Shade Soul",
    "Merman Soul",
    "Larva Soul",
    "Ukoback Soul",
    "Decarabia Soul",
    "Succubus Soul",
    "Slogra Soul",
    "Erinys Soul",
    "Homunculus Soul",
    "Witch Soul",
    "Fish Head Soul",
    "Mollusca Soul",
    "Dead Mate Soul",
    "Malacoda Soul",
    "Flame Demon Soul",
    -- "Aguni Soul",
    "Abaddon Soul",
}

function get_idx_for_wall(soul)
    for i, enemy in ipairs(BULLET_SOULS_FOR_WALLS) do
        if enemy == soul then
            return i - 1
        end
    end
end