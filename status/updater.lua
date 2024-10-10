--------------------------------------------------------------------------------
--
--			AURA Watcher
--
--------------------------------------------------------------------------------

local _, ns = ...
local unit_in_roster = Grid2.roster_guids


local function update_auras(a, event, unit)

	-- check if unit is part of the rooster
	if not unit_in_roster[unit] then return end

	-- clear old debuffs
	ns.debuffs[unit] = {}
	for i=1, ns.num_statuses do
		ns.debuffs[unit][i] = {}
	end

	-- loop over aura slots
	local i = 1
	while true do

		local aura = C_UnitAuras.GetDebuffDataByIndex(unit, i, "HARMFUL")
		-- local name, icon, count, type, duration, expiration, _, _, _, spell_id = C_UnitAuras.GetAuraDataByIndex(unit, i, "HARMFUL")
		i = i + 1
		if not aura then
			break
		end

		local config = ns.db.debuffs[aura.spellId] or {}
		if config.enabled ~= false then

			local state = {
				spell_id=aura.spellId,
				name=aura.name,
				icon=aura.icon,
				count=aura.applications or 0, -- stacks?
				type=aura.dispelName,
				duration=aura.duration or 0,
				expiration=aura.expirationTime or 0,
			}

			-- assigned status
			local status = config.status or 1

			ns.debuffs[unit][status][i] = state
		end -- config.enabled
	end -- while true


	for status in next, ns.statuses do
		status:UpdateIndicators(unit)
	end
end


local frame = CreateFrame("Frame")
frame:Hide()
frame:SetScript('OnEvent', update_auras)
frame:RegisterEvent('UNIT_AURA')
