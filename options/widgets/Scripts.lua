local _, ns = ...


function fix_group_name(key, group)

    local old = group.name or key or ""
    if old == "" then return end

    local parts = { strsplit("/", old) }
    local new = parts[#parts]
    group.name = new
end


function fix_key(key)

    local new = key
    new = new:lower(new)
    new = new:gsub("[%c%s%(%)]", "")
    return new
end

--------------------------------------------------------------------------------

function ns.widgets.Scripts()

    order = order or 900


    local options = {

        header1 = { type="header", order=order+10, name="Scripts" },

        button_fix_names = {
            type = "execute",
            order = order + 20,
            name = "Fix Names",
            func = function(info)
                for key, group in pairs(ArrgDebuffsDB.groups) do
                    fix_group_name(key, group)
                end
                ns.gui_refresh()
            end,
        },

        button_fix_keys = {
            type = "execute",
            order = order + 30,
            name = "Fix Keys",
            func = function(info)

                local groups = {}
                for key, group in pairs(ArrgDebuffsDB.groups) do
                    groups[fix_key(key)] = group
                end
                ArrgDebuffsDB.groups = groups

                for key, spell in pairs(ArrgDebuffsDB.debuffs) do
                    spell.group = fix_key(spell.group)
                end

                ns.gui_refresh()
            end,
        },


    }
    return options
end
