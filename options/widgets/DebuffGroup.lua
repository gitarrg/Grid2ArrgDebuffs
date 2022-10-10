local _, ns = ...


local OPTIONS_ADD_ITEMS = {

    header = { type="header", order=100, name="Add:" },

    add_group = {
        type = "input",
        order = 110,
        name = "Add Group:",
        get = function(info) return "" end,
        set = function(info , name)

            name = name:trim()

            local path = name:lower()
            path = path:gsub("[%c%s%(%)]", "")
            if info.handler.key ~= "" then
                path = info.handler.key .. "/" .. path
            end

            print("Adding Group:", path)
            ns.db.groups[path] = {
                name = name,
            }

            -- refresh the debuffs list
            ns.gui_refresh()

        end,
    },

    add_spell = {
        type = "input",
        order = 220,
        name = "Add Spell:",
        get = function() return "" end,
        set = function(info , value)
            if not value then return end
            value = value:trim()
            value = tonumber(value)
            if not value then return end

            ns.db.debuffs[value] = {
                enabled = true,
                group = info.handler.key or "",
            }
            -- refresh the debuffs list
            ns.gui_refresh()
        end,
		validate = function(_, value)
			if tonumber(value) then
				return true
			end
		end,
    },
}


--------------------------------------------------------------------------------
--  Main
--

function ns.widgets.DebuffGroup(key, data)

    local name = data.name or key or "<NO NAME>"

    local options = {

        header1 = { type="header", order=0, name="Group Settings:" },

        header = {
            order = 10,
            type = "description",
            fontSize = "large",
            name = name,
            image = data.icon,
        },

        name = {
            order = 20,
            type = "input",
            name = "Name:",
            width = "full",
            get = function(info) return name end,
            set = function(info, value)
                data.name = value
                ns.gui_refresh()
            end,
        },

        key = {
            order = 20,
            type = "input",
            name = "Key:",
            width = "full",
            get = function() return key end,
            set = function(info, value)
                ns.replace_key(info.handler.key, value)
                ns.gui_refresh()
            end,
            confirm = true,
            confirmText = "Update Key"
        },

        order = {
            order = 25,
            type = "input",
            name = "Order:",
            get = function(info)
                return tostring(data.order or 0)
            end,
            set = function(info, value)
                local n = tonumber(value)
                if n == nil then return end
                data.order = n
                ns.gui_refresh()
            end,

        },

        group_icon = {
            order = 30,
            type = "input",
            name = "Icon:",
            get = function()
                return data.icon or ""
            end,
            set = function(_, value)
                if value == "" then
                    value = nil
                end
                data.icon = value
                ns.gui_refresh()
            end,
        },

        button_remove_group = {
            type = "execute",
            order = 50,
            name = "Remove",
            func = function(info)
                ns.db.groups[info.handler.key] = nil
                ns.gui_refresh()
            end,
        },

    } -- options

    if key == "" then
        options = {}
    end

    ----------------------------------------------------------------------------
    -- Main

    local title = name
    if data.icon then
        title = "|T" .. data.icon .. ":0|t" .. title
    end

	return {
		type = "group",
        childGroups = "tree",
		name = title,
		args = options,
        plugins = {
            add_items = OPTIONS_ADD_ITEMS,
        },
		order = tonumber(data.order),
		handler = {
            name = name,
            key = key,
            data = data,
        },
	}

end
