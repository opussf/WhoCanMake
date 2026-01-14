WCM_SLUG, WCM   = ...
WCM.MSG_ADDONNAME = C_AddOns.GetAddOnMetadata( WCM_SLUG, "Title" )
WCM.MSG_VERSION   = C_AddOns.GetAddOnMetadata( WCM_SLUG, "Version" )
WCM.MSG_AUTHOR    = C_AddOns.GetAddOnMetadata( WCM_SLUG, "Author" )

WhoCanMake_data = {}

function WCM.OnLoad()
	WhoCanMakeFrame:RegisterEvent( "LOADING_SCREEN_DISABLED" )
	WhoCanMakeFrame:RegisterEvent( "TRADE_SKILL_LIST_UPDATE" )
end
function WCM.LOADING_SCREEN_DISABLED()
	WCM.name = UnitName("player")
	WCM.realm = GetRealmName()
end
function WCM.TRADE_SKILL_LIST_UPDATE()
	print( "TRADE_SKILL_LIST_UPDATE" )
	local recipeTable = C_TradeSkillUI.GetAllRecipeIDs()
	local recipeInfoTable = {}
	local schematicInfo = {}
	local itemID = nil
	for _,recipeID in pairs( recipeTable ) do
		recipeInfoTable = C_TradeSkillUI.GetRecipeInfo( recipeID )
		schematicInfo = C_TradeSkillUI.GetRecipeSchematic( recipeID, false )  -- ID, isRecraft, recipeLevel
		itemID = schematicInfo.outputItemID

		print( recipeID, recipeInfoTable.name, recipeInfoTable.learned, itemID )
		if itemID and recipeInfoTable.learned then
			WhoCanMake_data[itemID] = WhoCanMake_data[itemID] or {}
			-- WhoCanMake_data[itemID][WCM.realm] = WhoCanMake_data[itemID][WCM.realm] or {}
			WhoCanMake_data[itemID][WCM.realm.."-"..WCM.name] = true
		end

	end
end



--[[
C_TradeSkillUI.GetRecipeSchematic( ID, isRecraft, recipeLevel )




{
			Name = "CraftingRecipeSchematic",
			Type = "Structure",
			Fields =
			{
				{ Name = "recipeID", Type = "number", Nilable = false },
				{ Name = "icon", Type = "number", Nilable = false },
				{ Name = "quantityMin", Type = "number", Nilable = false },
				{ Name = "quantityMax", Type = "number", Nilable = false },
				{ Name = "name", Type = "cstring", Nilable = false },
				{ Name = "recipeType", Type = "TradeskillRecipeType", Nilable = false, Default = "Item" },
				{ Name = "productQuality", Type = "number", Nilable = true },
				{ Name = "outputItemID", Type = "number", Nilable = true },
				{ Name = "reagentSlotSchematics", Type = "table", InnerType = "CraftingReagentSlotSchematic", Nilable = false },
				{ Name = "isRecraft", Type = "bool", Nilable = false },
				{ Name = "hasCraftingOperationInfo", Type = "bool", Nilable = false },
			},
		},

]]