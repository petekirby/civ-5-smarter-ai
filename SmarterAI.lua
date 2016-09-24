-- Common
-- Author: Peter
-- DateCreated: 5/5/2013 5:15:14 AM
--------------------------------------------------------------

function CreateBuildingClassTable( iBuildingClass )
	local buildingClassTable = {};
	local iDefaultBuilding = GameInfoTypes[
		GameInfo.BuildingClasses[iBuildingClass].DefaultBuilding ];

	for pCiv in GameInfo.Civilizations() do --loop through all civs
		buildingClassTable[pCiv.ID] = iDefaultBuilding;
		-- add any unique buildings
		for pOverride in GameInfo.Civilization_BuildingClassOverrides() do
 			if ( GameInfoTypes[pOverride.CivilizationType] == pCiv.ID and
				 GameInfoTypes[pOverride.BuildingClassType] == iBuildingClass ) then
				buildingClassTable[ pCiv.ID ] = GameInfoTypes[pOverride.BuildingType];
 			end
		end
	end

	return buildingClassTable;
end

local function CreateShortList( iBuildingClass )
	local buildingTableShortList = {};
	local iDefaultBuilding = GameInfoTypes[
		GameInfo.BuildingClasses[iBuildingClass].DefaultBuilding ];
	local i = 1;

	buildingTableShortList[ i ] = iDefaultBuilding;

	for pOverride in GameInfo.Civilization_BuildingClassOverrides() do
 		if ( GameInfoTypes[pOverride.BuildingClassType] == iBuildingClass ) then
			i = i + 1;
			buildingTableShortList[ i ] = GameInfoTypes[pOverride.BuildingType];
 		end
	end

	return buildingTableShortList;
end

function CreateBuildingTableFromClassTable( classTable )
	local buildingTable = {};
	local i = 1;
				
	for classIndex = 1, #classTable do
		local shortList = CreateShortList( classTable[ classIndex ] );
		for buildingIndex = 1, #shortList do
			buildingTable[ i ] = shortList[ buildingIndex ];
			i = i + 1;
		end
	end

	return buildingTable;
end