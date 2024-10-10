
local ADDON_NAME, ns = ...

-- aliases
local debuffTypeColors = Grid2.debuffTypeColors
local db = ArrgDebuffsDB


--------------------------------------------------------------------------------
--
--			STATUS
--
--------------------------------------------------------------------------------

local class = {}


function class:OnEnable()
	ns.statuses[self] = true
end


function class:OnDisable()
	ns.statuses[self] = nil
end


function class:IsActive(self, unit)
	return true
end


function class:GetIcons(unit, max)

	local icons = {}
	local counts = {}
	local expirations = {}
	local durations = {}
	local colors = {}
	local slots = {}

	local i, j = 1, 1 -- j = number of auras found
	local name, type

	local unit_debuffs = ns.debuffs[unit]
	if not unit_debuffs then return 0 end

	local status_debuffs = unit_debuffs[self.dbx.index or 0]
	if not status_debuffs then return 0 end


	for s, state in pairs(status_debuffs) do

		local config = db.debuffs[state.spell_id] or {}
		if config.enabled ~= false then

			local color = (state.type and debuffTypeColors[state.type]) or self.dbx.color
			icons[j] = state.icon
			colors[j] = color
			counts[j] = state.count or 1
			durations[j] = state.duration
			expirations[j] = state.expiration
			j = j + 1

			-- not sure if this is correct... 
			slots[j] = s

		end -- if enabled

		if j > max then
			break
		end
	end


	return j-1, icons, counts, expirations, durations, colors, slots
end


--------------------------------------------------------------------------------
--
--			REGISTER
--
--------------------------------------------------------------------------------

local function Create(baseKey, dbx)

	-- Create Status for each Clone
	local status = Grid2.statusPrototype:new(baseKey, false)
	status:Inject(class)


	Grid2:RegisterStatus(status, { "icon" }, baseKey, dbx)
	return status
end


-- Register the Type
Grid2.setupFunc["arrg-debuffs"] = Create


-- Create Default Statuses
for i=1, ns.num_statuses do
	local name = "arrg-debuffs-" .. i

	Grid2:DbSetStatusDefaultValue(
		name,
		{
			type = "arrg-debuffs",
			index = i,
			color = {r=1.0, g=0.0, b=0.0, a=1.0},
		}
	)
end
