local _, ns = ...

--------------------------------------------------------------------------------
-- Register the Options with the Grid2 Addon
--------------------------------------------------------------------------------

Grid2.OnOptionsLoad = Grid2.OnOptionsLoad or {}

Grid2.OnOptionsLoad["arrg-debuffs"] = function()
	Grid2Options:RegisterStatusOptions(
		"arrg-debuffs", -- type
		"debuff",       -- categoryKey

		function(self, status, options, optionParams)

			ns.gui_refresh()

			options.debuffs_tab = {
				type = "group",
				name = "Debuffs",
				order = 10,
				args = ns.GUI,
			}
		end, -- end funcMakeOptions

		-- optionParams
		{
			titleIcon = 133074,
			hideTitle = true,
			masterStatus = "arrg-debuffs-1",
		}
	)
end