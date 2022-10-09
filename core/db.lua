local _, ns = ...

-- Global Var
-- (name needs to match the #SavedVariables mentioned in the .toc)
ArrgDebuffsDB = {

    -- Debuff Configs, keyed by their Spell IDs
    debuffs = {},

    -- Debuff Groups
    -- used to organize debuffs in the UI
    groups = {
        [""] = {
            ["name"] = "Unsorted",
            ["icon"] = 136243,
        },
    },
}
