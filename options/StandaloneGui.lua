--------------------------------------------------------------------------------
--
-- Standalone Config Window
--
--------------------------------------------------------------------------------
local _, ns = ...

local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")


local GUI_NAME = "ArrgDebuffOptions"


-- Config Window Root Group
local WINDOW = {
	name = GUI_NAME,
	type = "group",
	args = ns.GUI,
	plugins = {},
}

AceConfig:RegisterOptionsTable(GUI_NAME, WINDOW)


function toggle_gui()
    if AceConfigDialog.OpenFrames[GUI_NAME] then
		AceConfigDialog:Close(GUI_NAME)
	else
		ns.gui_refresh()
		AceConfigDialog:Open(GUI_NAME)
	end
end


SLASH_ARRG_DEBUFFS1 = "/arrg_debuffs"
SLASH_ARRG_DEBUFFS2 = "/ard"
SLASH_ARRG_DEBUFFS3 = "/ad"   -- old command
SlashCmdList["ARRG_DEBUFFS"] = toggle_gui
