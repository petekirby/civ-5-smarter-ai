-- UseGreatPeople
-- Author: Peter
-- DateCreated: 5/4/2013 11:47:37 PM
--------------------------------------------------------------

 -- Hex Adjustment tables. These tables direct plot by plot scans in a radius 
-- around a center hex, starting to Northeast, moving clockwise.
--[[
local firstRingYIsEven = {{0, 1}, {1, 0}, {0, -1}, {-1, -1}, {-1, 0}, {-1, 1}};
local secondRingYIsEven = {
		{1, 2}, {1, 1}, {2, 0}, {1, -1}, {1, -2}, {0, -2},
		{-1, -2}, {-2, -1}, {-2, 0}, {-2, 1}, {-1, 2}, {0, 2}
		};
local thirdRingYIsEven = {
		{1, 3}, {2, 2}, {2, 1}, {3, 0}, {2, -1}, {2, -2},
		{1, -3}, {0, -3}, {-1, -3}, {-2, -3}, {-2, -2}, {-3, -1},
		{-3, 0}, {-3, 1}, {-2, 2}, {-2, 3}, {-1, 3}, {0, 3}
		};
local firstRingYIsOdd = {{1, 1}, {1, 0}, {1, -1}, {0, -1}, {-1, 0}, {0, 1}};
local secondRingYIsOdd = {		
		{1, 2}, {2, 1}, {2, 0}, {2, -1}, {1, -2}, {0, -2},
		{-1, -2}, {-1, -1}, {-2, 0}, {-1, 1}, {-1, 2}, {0, 2}
		};
local thirdRingYIsOdd = {
		{2, 3}, {2, 2}, {3, 1}, {3, 0}, {3, -1}, {2, -2},
		{2, -3}, {1, -3}, {0, -3}, {-1, -3}, {-2, -2}, {-2, -1},
		{-3, 0}, {-2, 1}, {-2, 2}, {-1, 3}, {0, 3}, {1, 3}
		};

GameEvents.PlayerDoTurn.Add(function(iPlayer)

	for unit in pPlayer:Units()
end);

	local isEvenY = true;
	if y / 2 > math.floor(y / 2) then
		isEvenY = false;
	end



UNITCLASS_ARTIST
UNITCLASS_SCIENTIST
UNITCLASS_ENGINEER

if plot:IsRiver() or plot:IsFreshWater() then

12		RESOURCE_STONE
13		RESOURCE_WHALE

"MISSION_BUILD

Plot City:Plot()

20		BUILD_LANDMARK
21		BUILD_ACADEMY

"YIELD_FOOD"		0

iYieldChange = pPlot:GetYieldWithBuild(iBuildID, iYield, false, iActivePlayer);

 pCity:CanWork( plot )

 function MoveUnitTo (unit, plot)
	local unitPlot = unit:GetPlot()
	local movesBefore = unit:MovesLeft()

	if movesBefore == 0 then
		Dprint ("Trying to move unit without move left, returning true as the destination may be in fact reachable... ", g_bAIDebug)
		return true
	end

	local x = plot:GetX()
	local y = plot:GetY()
	Dprint ("Trying to move unit to " .. x .."," ..y, g_bAIDebug)


	local player = Players[unit:GetOwner()]
	if player:GetID() == Game:GetActivePlayer() and SHOW_FORCED_MOVE then
		UI.LookAt(unit:GetPlot(), 0)
	end

	unit:PopMission()
	unit:PushMission(MissionTypes.MISSION_MOVE_TO, x, y, 0, 0, 1, MissionTypes.MISSION_MOVE_TO, unitPlot, unit)
	
	local movesAfter = unit:MovesLeft()

	if movesAfter < movesBefore then
		Dprint ("  - returning move done !")
		return true
	else
		Dprint ("  - returning move failed, try close plots !")
		local plotList = GetCloseDestinationList(unit, plot)
		for i, destination in ipairs(plotList) do
			local x = destination.Plot:GetX()
			local y = destination.Plot:GetY()
			Dprint ("    - Trying to move unit to " .. x .."," ..y, g_bAIDebug)
			unit:PopMission()
			unit:PushMission(MissionTypes.MISSION_MOVE_TO, x, y, 0, 0, 1, MissionTypes.MISSION_MOVE_TO, unitPlot, unit)
			movesAfter = unit:MovesLeft()
			if movesAfter < movesBefore then
				Dprint ("    - returning move done !")
				return true
			end
		end
	end
	Dprint ("  - returning move failed !")
	return false
end
--]]