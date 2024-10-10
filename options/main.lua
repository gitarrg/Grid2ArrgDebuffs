local _, ns = ...


-- Main Window
ns.GUI = {}


-- "foo/bar/path" --> "foo/bar", "path"
function split_path(path)
    -- Returns the Path, Filename, and Extension as 3 values
    return string.match(path, "(.*)/(.*)$")
end


function ns.gui_refresh()
 
    local options = ns.GUI
    wipe(options)

    -------------------------------------
    -- Create Groups
    local groups = {}
    for key, info in pairs(ns.db.groups or {}) do
        groups[key] = ns.widgets.DebuffGroup(key, info)
    end
    -- sort groups
    for key, group in pairs(groups) do
        local parent, name = split_path(key)
        local parent_group = parent and groups[parent]
        parent_group = (parent_group and parent_group.args) or options
        parent_group[name or key] = group
    end -- for group

    -------------------------------------
    -- Create Debuffs
    for spell_id, info in pairs(ns.db.debuffs or {}) do
        local parent = groups[info.group or ""] or groups[""] -- fallback to "unsorted"
        parent = (parent and parent.args) or options -- or fallback to root
            
        local settings = ns.widgets.DebuffSettings(spell_id, info)
        if settings then -- could be invalid spell id
            parent[tostring(spell_id)] = settings
        end

    end -- for spell id


    -- Add Scripts to "unsorted" group
    do
        local group = groups[""] -- or options
        group.plugins["scripts"] = ns.widgets.Scripts()
    end

end
