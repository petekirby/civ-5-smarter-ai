-- Lua Script
-- Author: Mark
-- DateCreated: 4/7/2013 1:48:51 PM
--------------------------------------------------------------
print('***[ Wonder Race Loaded ]***')

local gWonderTable = {}
local gWonderWinner = {}
local gShowPlayer = {}
local gRacing = {}

function DoDirty(playerID, cityID,  updateType)
	local player = Players[playerID]
	local city = player:GetCityByID(cityID)
	local pCity
		
	-- Get info on what we are building in this city
	buildingInfo = GameInfo.Buildings[city:GetProductionBuilding()]
		
	-- Not building anything so jump out
	if not buildingInfo then
		return
	end

	-- Not building a wonder so jump out
	buildingClassInfo = GameInfo.BuildingClasses[buildingInfo.BuildingClass]
	if buildingClassInfo.MaxGlobalInstances ~= 1 then 
		return
	end
	
	print(player:GetName() .. ' is building ' .. Locale.ConvertTextKey(buildingInfo.Description))

	-- Tricky bit here. If there is no entry in the wonder table, or there is an entry but the turns left to 
	-- build it are greater than ours (the value stored along with the wonderID as key, value) then set it to
	-- the current players turn count. In the end we don't really care who is building it, just when it will be 
	-- built soonest. The racing table is needed because later we won't be able to tell our own entry in the wonder 
	-- table from others. The racing table will always hold the second to soonest time a wonder will be built.
	if gWonderTable[buildingInfo.Type] and gWonderTable[buildingInfo.Type] < city:GetProductionTurnsLeft() then 
	    if not gRacing[buildingInfo.Type] or gRacing[buildingInfo.Type] > city:GetProductionTurnsLeft() then
			gRacing[buildingInfo.Type] = city:GetProductionTurnsLeft()
			print('Wonder entered/updated in racing table')
		end
	end

	-- The easy part. If it's not in the wonder table or we have a lower turns left than the current entry in
	-- the wonder table, add/replace.
	if not gWonderTable[buildingInfo.Type] or gWonderTable[buildingInfo.Type] > city:GetProductionTurnsLeft() then 
		gWonderTable[buildingInfo.Type] = city:GetProductionTurnsLeft()
		gWonderWinner[buildingInfo.Type] = playerID
		print('Wonder entered/updated in wonder table')
	end
end

Events.SpecificCityInfoDirty.Add( DoDirty )

function DoTurn( playerID )
	local turns = 0
	local player = Players[playerID]
	local buildingInfo
	local wonder
	local calc = 0
		
	-- Are we not human
	if not player:IsHuman() then
		return
	end

	-- For every wonder this player is building, check to see if it's in the tables
	for city in player:Cities() do

		-- Get info on what we are building in this city
		buildingInfo = GameInfo.Buildings[city:GetProductionBuilding()]
		
		-- if we are building a wonder do our thing. This is a tricky little bit of coding where we
		-- calculate the turn difference between us and the current closest AI. The final piece that
		-- makes it all work is the wonder winner table that stores the name of a wonder and who is 
		-- currently winning the race. This allows us to know how to do the math. If we are winning then we
		-- want to subtract our turns from theirs, resulting in a positive number. Otherwise we subtract 
		-- their turns from ours, resulting in a negative number.
		local racing = false
		if buildingInfo then
			buildingClassInfo = GameInfo.BuildingClasses[buildingInfo.BuildingClass]
			if buildingClassInfo.MaxGlobalInstances == 1 then 
				if gRacing[buildingInfo.Type] then
					racing = true
					if gWonderWinner[buildingInfo.Type] == playerID then
						turns = gRacing[buildingInfo.Type] - gWonderTable[buildingInfo.Type]
					else
						turns = gWonderTable[buildingInfo.Type] - gRacing[buildingInfo.Type]
					end

					wonder = Locale.ConvertTextKey(buildingInfo.Description)

					cID = playerID .. '_' .. wonder
		
					-- Here we are just setting a flag to let us know when things have changed, so we don't spam notices
					if not gShowPlayer[cID] then
 						gShowPlayer[cID] = 0
					end

					if gShowPlayer[cID] == 1 and turns < 0 then
						gShowPlayer[cID] = 0	
					end

					if  gShowPlayer[cID] == 2 and turns > 0 then
						gShowPlayer[cID] = 0		
					end

					-- Hard work is all done. If the number is negative we're losing, positive we're winning, send a message
					if turns > 0 then
						if gShowPlayer[cID] == 0 then
							msg = Locale.ConvertTextKey("TXT_KEY_WONDER_RACE_WINNING")
							tip = Locale.ConvertTextKey("TXT_KEY_WONDER_RACE_WINNING_TIP", wonder)
							player:AddNotification(NotificationTypes.NOTIFICATION_WONDER_COMPLETED_ACTIVE_PLAYER, tip, msg) 
							gShowPlayer[cID] = 1		
						end
					elseif turns < 0 then
						if gShowPlayer[cID] == 0 then
							msg = Locale.ConvertTextKey("TXT_KEY_WONDER_RACE_LOSING")
							tip = Locale.ConvertTextKey("TXT_KEY_WONDER_RACE_LOSING_TIP", wonder)
							player:AddNotification(NotificationTypes.NOTIFICATION_WONDER_BEATEN, tip, msg) 
							gShowPlayer[cID] = 2		
						end
					elseif turns == 0 and racing then
						if gShowPlayer[cID] == 0 then
							msg = Locale.ConvertTextKey("TXT_KEY_WONDER_RACE_TIED")
							tip = Locale.ConvertTextKey("TXT_KEY_WONDER_RACE_TIED_TIP", wonder)
							player:AddNotification(NotificationTypes.NOTIFICATION_WONDER_BEATEN, tip, msg) 
							gShowPlayer[cID] = 2		
						end
					end
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add( DoTurn );
--Events.SpecificCityInfoDirty.Add( DoTurn )