local addon_name, ns = ...

local Addon = LibStub("AceAddon-3.0"):NewAddon(addon_name)


function Addon:OnInitialize()
    ns.db = ArrgDebuffsDB
end
