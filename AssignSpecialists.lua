-- AssignSpecialists
-- Author: Peter
-- DateCreated: 5/5/2013 2:45:54 AM
--------------------------------------------------------------

include("SmarterAI.lua");

local iSlackerType = GameDefines.DEFAULT_SPECIALIST;
local iDefaultFocusType = CityAIFocusTypes.NO_CITY_AI_FOCUS_TYPE;

local iAddSpecialist = TaskTypes.TASK_ADD_SPECIALIST;
local iRemoveSpecialist = TaskTypes.TASK_REMOVE_SPECIALIST;
local iNoAutoAssign = TaskTypes.TASK_NO_AUTO_ASSIGN_SPECIALISTS;

local iPiety = GameInfoTypes.POLICY_PIETY;
local iFreedom = GameInfoTypes.POLICY_FREEDOM;
local iEraMedieval = GameInfoTypes.ERA_MEDIEVAL;

local iScienceSpecialist = GameInfoTypes.SPECIALIST_SCIENTIST;
local iCultureSpecialist = GameInfoTypes.SPECIALIST_ARTIST;
local iProductionSpecialist = GameInfoTypes.SPECIALIST_ENGINEER;
local iGoldSpecialist = GameInfoTypes.SPECIALIST_MERCHANT;

local iClassLibrary = GameInfoTypes.BUILDINGCLASS_LIBRARY;
local iClassUniversity = GameInfoTypes.BUILDINGCLASS_UNIVERSITY;
local iClassPublicSchool = GameInfoTypes.BUILDINGCLASS_PUBLIC_SCHOOL;
local iClassResearchLab = GameInfoTypes.BUILDINGCLASS_LABORATORY;
local iClassAmphitheater = GameInfoTypes.BUILDINGCLASS_AMPHITHEATER;
local iClassOperaHouse = GameInfoTypes.BUILDINGCLASS_OPERA_HOUSE;
local iClassMuseum = GameInfoTypes.BUILDINGCLASS_MUSEUM;
local iClassCathedral = GameInfoTypes.BUILDINGCLASS_CATHEDRAL;
local iWorkshop = GameInfoTypes.BUILDINGCLASS_WORKSHOP;
local iWindmill = GameInfoTypes.BUILDINGCLASS_WINDMILL;
local iFactory = GameInfoTypes.BUILDINGCLASS_FACTORY;
local iMarket = GameInfoTypes.BUILDINGCLASS_MARKET;
local iBank = GameInfoTypes.BUILDINGCLASS_BANK;
local iStockExchange = GameInfoTypes.BUILDINGCLASS_STOCK_EXCHANGE;

local ScienceBuildings = {
	CreateBuildingClassTable( iClassLibrary ),
	CreateBuildingClassTable( iClassUniversity ),
	CreateBuildingClassTable( iClassPublicSchool ),
	CreateBuildingClassTable( iClassResearchLab )
};

local CultureBuildings = {
	CreateBuildingClassTable( iClassAmphitheater ),
	CreateBuildingClassTable( iClassOperaHouse ),
	CreateBuildingClassTable( iClassMuseum ),
	CreateBuildingClassTable( iClassCathedral )
};

local ProductionBuildings = {
	CreateBuildingClassTable( iWorkshop ),
	CreateBuildingClassTable( iWindmill ),
	CreateBuildingClassTable( iFactory )
};

local GoldBuildings = {
	CreateBuildingClassTable( iMarket ),
	CreateBuildingClassTable( iBank ),
	CreateBuildingClassTable( iStockExchange )
};

local numScienceBuildings = #ScienceBuildings;
local numCultureBuildings = #CultureBuildings;
local numProductionBuildings = #ProductionBuildings;
local numGoldBuildings = #GoldBuildings;

local function IncrementSpecialist( iPlayer, iCity, iBuilding, iSpecialist )
	local pPlayer = Players[iPlayer];
	local pCity = pPlayer:GetCityByID(iCity);
	local iNumAssignedSpecialists, iNumSpecialists, iSpecialistLimit;

	if ( pCity:IsHasBuilding( iBuilding ) and
	     pCity:IsCanAddSpecialistToBuilding( iBuilding ) ) then
		iNumAssignedSpecialists = pCity:GetNumSpecialistsInBuilding( iBuilding );
		iNumSpecialists = pCity:GetNumSpecialistsAllowedByBuilding( iBuilding );
		if ( iNumAssignedSpecialists < iNumSpecialists ) then
			for i = 1, iNumSpecialists - iNumAssignedSpecialists do
				iFoodPerTurn = pCity:FoodDifference();
				if ( iFoodPerTurn >= 3 ) then
					Network.SendDoTask( iCity, iNoAutoAssign, -1, -1, true );
					Network.SendDoTask( iCity, iAddSpecialist, iSpecialist, iBuilding, false, false, false );
					print( "Added specialist for ", pPlayer:GetName(), "in building #", iBuilding, " in ", pCity:GetName() );
				end
			end
		end
	end
end

local function RemoveSpecialists( iPlayer, iCity, iExceptionType )
	local pPlayer = Players[iPlayer];
	local pCity = pPlayer:GetCityByID(iCity);
	local iNumAssignedSpecialists, iBuilding;

	Network.SendDoTask( iCity, iNoAutoAssign, -1, -1, true );

	if ( iExceptionType ~= iCultureSpecialist ) then
		for table = 1, numCultureBuildings do
			iBuilding = (CultureBuildings[ table ])[ iPlayer ];
			if ( pCity:IsHasBuilding( iBuilding ) ) then
				iNumAssignedSpecialists = pCity:GetNumSpecialistsInBuilding( iBuilding );
				if ( iNumAssignedSpecialists > 0 ) then
					for i = 1, iNumAssignedSpecialists do
						Network.SendDoTask( iCity, iRemoveSpecialist, iSpecialist, iBuilding, false, false, false );
						print( "Removed specialist for ", pPlayer:GetName(), "in building #", iBuilding, " in ", pCity:GetName() );
					end
				end
			end
		end
	end

	if ( iExceptionType ~= iScienceSpecialist ) then
		for table = 1, numScienceBuildings do
			iBuilding = (ScienceBuildings[ table ])[ iPlayer ];
			if ( pCity:IsHasBuilding( iBuilding ) ) then
				iNumAssignedSpecialists = pCity:GetNumSpecialistsInBuilding( iBuilding );
				if ( iNumAssignedSpecialists > 0 ) then
					for i = 1, iNumAssignedSpecialists do
						Network.SendDoTask( iCity, iRemoveSpecialist, iSpecialist, iBuilding, false, false, false );
						print( "Removed specialist for ", pPlayer:GetName(), "in building #", iBuilding, " in ", pCity:GetName() );
					end
				end
			end
		end
	end

	if ( iExceptionType ~= iProductionSpecialist ) then
		for table = 1, numProductionBuildings do
			iBuilding = (ProductionBuildings[ table ])[ iPlayer ];
			if ( pCity:IsHasBuilding( iBuilding ) ) then
				iNumAssignedSpecialists = pCity:GetNumSpecialistsInBuilding( iBuilding );
				if ( iNumAssignedSpecialists > 0 ) then
					for i = 1, iNumAssignedSpecialists do
						Network.SendDoTask( iCity, iRemoveSpecialist, iSpecialist, iBuilding, false, false, false );
						print( "Removed specialist for ", pPlayer:GetName(), "in building #", iBuilding, " in ", pCity:GetName() );
					end
				end
			end
		end
	end

	if ( iExceptionType ~= iGoldSpecialist ) then
		for table = 1, numGoldBuildings do
			iBuilding = (GoldBuildings[ table ])[ iPlayer ];
			if ( pCity:IsHasBuilding( iBuilding ) ) then
				iNumAssignedSpecialists = pCity:GetNumSpecialistsInBuilding( iBuilding );
				if ( iNumAssignedSpecialists > 0 ) then
					for i = 1, iNumAssignedSpecialists do
						Network.SendDoTask( iCity, iRemoveSpecialist, iSpecialist, iBuilding, false, false, false );
						print( "Removed specialist for ", pPlayer:GetName(), "in building #", iBuilding, " in ", pCity:GetName() );
					end
				end
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	local pPlayer = Players[iPlayer];

	if ( pPlayer:IsHuman() or pPlayer:IsMinorCiv() or pPlayer:IsBarbarian() ) then
		return false;
	end

	local iCity;
	local isCulturePlayer =
	  ( pPlayer:HasPolicy(iPiety) and not pPlayer:IsPolicyBlocked(iPiety) ) or
	  ( pPlayer:HasPolicy(iFreedom) and not pPlayer:IsPolicyBlocked(iFreedom) ) or
	  ( pPlayer:GetNumPolicies() >= 10 and pPlayer:GetCurrentEra() <= iEraMedieval ) or
	  ( pPlayer:GetTotalJONSCulturePerTurn() > pPlayer:GetScience() );
	
	for pCity in pPlayer:Cities() do
		if ( not pCity:IsPuppet() ) then
			if ( math.floor(pCity:GetPopulation()) >= 5 ) then
				iCity = pCity:GetID();

				if ( isCulturePlayer ) then
					print("Wow! a culture player! ", pPlayer:GetName(), " in city ", pCity:GetName());
					if ( pCity:GetSpecialistCount( iScienceSpecialist ) > 0 ) then
						RemoveSpecialists( iPlayer, iCity, iCultureSpecialist );
					end
					for table = 1, numCultureBuildings do
						 IncrementSpecialist( iPlayer, pCity:GetID(), (CultureBuildings[ table ])[ iPlayer ], iCultureSpecialist );
					end
				else
					print("Wow! a science player! ", pPlayer:GetName(), " in city ", pCity:GetName());
					if ( pCity:GetSpecialistCount( iCultureSpecialist ) > 0 ) then
						RemoveSpecialists( iPlayer, iCity, iScienceSpecialist );
					end
					for table = 1, numScienceBuildings do
						IncrementSpecialist( iPlayer, pCity:GetID(), (ScienceBuildings[ table ])[ iPlayer ], iScienceSpecialist );
					end
				end

				if ( pCity:GetSpecialistCount( slackerType ) > 0 ) then
					if ( pCity:GetFocusType() == iDefaultFocusType ) then
						Network.SendDoTask( iCity, iNoAutoAssign, -1, -1, false );
					else
						Network.SendSetCityAIFocus( iCity, iDefaultFocusType );
						if ( pCity:GetSpecialistCount( slackerType ) > 0 ) then
							Network.SendDoTask( iCity, iNoAutoAssign, -1, -1, false );
						end
					end

					local numSlackers = pCity:GetSpecialistCount( slackerType );
					for lazySlacker = 1, numSlackers do
						Network.SendDoTask( iCity, TaskTypes.TASK_CHANGE_WORKING_PLOT, 0, -1, false, false, false, false);
					end
				end
			end
		end
	end
end);