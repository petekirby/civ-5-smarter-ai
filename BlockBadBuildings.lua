-- BlockBadBuildings
-- Author: Peter
-- DateCreated: 5/4/2013 11:54:36 PM
--------------------------------------------------------------

include("SmarterAI.lua");

local classPriorityList = {
	GameInfoTypes.BUILDINGCLASS_GRANARY,
	GameInfoTypes.BUILDINGCLASS_WATERMILL,
	GameInfoTypes.BUILDINGCLASS_AQUEDUCT;
	GameInfoTypes.BUILDINGCLASS_HOSPITAL,
	GameInfoTypes.BUILDINGCLASS_LIGHTHOUSE,
	GameInfoTypes.BUILDINGCLASS_LIBRARY,
	GameInfoTypes.BUILDINGCLASS_SHRINE,
	GameInfoTypes.BUILDINGCLASS_MONUMENT,
	GameInfoTypes.BUILDINGCLASS_AMPHITHEATER,
	GameInfoTypes.BUILDINGCLASS_OPERA_HOUSE,
	GameInfoTypes.BUILDINGCLASS_BROADCAST_TOWER,
	GameInfoTypes.BUILDINGCLASS_WORKSHOP,
	GameInfoTypes.BUILDINGCLASS_FACTORY,
	GameInfoTypes.BUILDINGCLASS_UNIVERSITY,
	GameInfoTypes.BUILDINGCLASS_PUBLIC_SCHOOL,
	GameInfoTypes.BUILDINGCLASS_LABORATORY,
	GameInfoTypes.BUILDINGCLASS_STONE_WORKS,
	GameInfoTypes.BUILDINGCLASS_COLOSSEUM,
	GameInfoTypes.BUILDINGCLASS_MARKET,
	GameInfoTypes.BUILDINGCLASS_CIRCUS,
	GameInfoTypes.BUILDINGCLASS_OBSERVATORY,
	GameInfoTypes.BUILDINGCLASS_TEMPLE,
	GameInfoTypes.BUILDINGCLASS_THEATRE,
	GameInfoTypes.BUILDINGCLASS_HARBOR,
	GameInfoTypes.BUILDINGCLASS_STADIUM,
	GameInfoTypes.BUILDINGCLASS_COURTHOUSE
};

-- not putting unique buildings on the list
local buildingLowerPriorityList = {
	GameInfoTypes.BUILDING_WALLS,
	GameInfoTypes.BUILDING_CASTLE,
	GameInfoTypes.BUILDING_BARRACKS,
	GameInfoTypes.BUILDING_BANK,
	GameInfoTypes.BUILDING_SEAPORT,
	GameInfoTypes.BUILDING_STABLE,
	GameInfoTypes.BUILDING_FORGE,
	GameInfoTypes.BUILDING_HYDRO_PLANT,
	GameInfoTypes.BUILDING_SOLAR_PLANT,
	GameInfoTypes.BUILDING_MINT,
	GameInfoTypes.BUILDING_GARDEN,
	GameInfoTypes.BUILDING_ARMORY,
	GameInfoTypes.BUILDING_MILITARY_ACADEMY,
	GameInfoTypes.BUILDING_ARSENAL,
	GameInfoTypes.BUILDING_MEDICAL_LAB,
	GameInfoTypes.BUILDING_NUCLEAR_PLANT,
	GameInfoTypes.BUILDING_SPACESHIP_FACTORY,
	GameInfoTypes.BUILDING_CONSTABLE,
	GameInfoTypes.BUILDING_POLICE_STATION,
	GameInfoTypes.BUILDING_RECYCLING_CENTER,
	GameInfoTypes.BUILDING_BOMB_SHELTER
};

local buildingPriorityList =
	CreateBuildingTableFromClassTable( classPriorityList );

local lengthBuildingPriorityList = #buildingPriorityList;

local lengthBuildingLowerPriorityList = #buildingLowerPriorityList;

GameEvents.CityCanConstruct.Add( function( iPlayer, iCity, iBuilding )
	-- Let human players or minor civs make their own decisions
	local pPlayer = Players[iPlayer];
	if ( pPlayer:IsHuman()  or pPlayer:IsMinorCiv() or pPlayer:IsBarbarian() ) then
		return true;
	end

	-- AI capital cities and puppets can build whatever they want
	local pCity = pPlayer:GetCityByID( iCity );
	if ( pCity:IsCapital() or pCity:IsPuppet() ) then
		return true;
	end
  
	-- don't block anything on the priority list
	for i = 1, lengthBuildingPriorityList do
		if ( iBuilding == buildingPriorityList[ i ] ) then
			return true;
		end
	end

	-- if this building is on the lower priority list
	for i = 1, lengthBuildingLowerPriorityList do
		if ( iBuilding == buildingLowerPriorityList[ i ] ) then
			-- don't allow it if buildings from the higher list are up
			for j = 1, lengthBuildingPriorityList do
				if ( pCity:CanConstruct( buildingPriorityList[ j ] ) ) then
					return false;
				end
			end
		end
	end

	-- anything else goes, so far as we care
	return true;
end);