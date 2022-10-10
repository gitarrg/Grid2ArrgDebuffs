local _, ns = ...


function ns.replace_key(old, new)

    old = "^" .. old -- match start of the string

    -- Update Groups
    local groups = {}
    for key, group in pairs(ns.db.groups) do
        local key_new = key:gsub(old, new)
        groups[key_new] = group
    end
    ns.db.groups = groups

    -- Update Spells
    for key, spell in pairs(ArrgDebuffsDB.debuffs) do
        spell.group = spell.group:gsub(old, new)
    end

end
