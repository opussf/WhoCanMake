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
	TooltipDataProcessor.AddTooltipPostCall( Enum.TooltipDataType.Item, WCM.onTooltipSetItem )
end
function WCM.TRADE_SKILL_LIST_UPDATE()
	-- print( "TRADE_SKILL_LIST_UPDATE" )
	local recipeTable = C_TradeSkillUI.GetAllRecipeIDs()
	local recipeInfoTable = {}
	local schematicInfo = {}
	local itemID = nil
	for _,recipeID in pairs( recipeTable ) do
		recipeInfoTable = C_TradeSkillUI.GetRecipeInfo( recipeID )
		schematicInfo = C_TradeSkillUI.GetRecipeSchematic( recipeID, false )  -- ID, isRecraft, recipeLevel
		itemID = schematicInfo.outputItemID

		-- print( recipeID, recipeInfoTable.name, recipeInfoTable.learned, itemID )
		if itemID and recipeInfoTable.learned then
			WhoCanMake_data[itemID] = WhoCanMake_data[itemID] or {}
			-- WhoCanMake_data[itemID][WCM.realm] = WhoCanMake_data[itemID][WCM.realm] or {}
			WhoCanMake_data[itemID][WCM.realm.."-"..WCM.name] = true
		end
	end
end
function WCM.onTooltipSetItem( tooltip, tooltipdata )
	local itemID = tooltipdata.id

	if itemID and WhoCanMake_data[itemID] then
		local sortedMakers = {}
		for m in pairs( WhoCanMake_data[itemID] ) do
			table.insert( sortedMakers, m )
		end
		table.sort( sortedMakers )
		for _,maker in ipairs( sortedMakers ) do
			WCM.lineData = {
				["leftText"] = maker
			}
			tooltip:AddLineDataText( WCM.lineData )
		end
	end
end
