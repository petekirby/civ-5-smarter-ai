-- LibrariesEverywhere
-- Author: Peter
-- DateCreated: 5/3/2013 12:38:12 AM
--------------------------------------------------------------

include("SmarterAI.lua");

local iClassLibrary = GameInfoTypes.BUILDINGCLASS_LIBRARY;
local iNationalCollege = GameInfoTypes.BUILDING_NATIONAL_COLLEGE;
local iLibrary = CreateBuildingClassTable( iClassLibrary );

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	local pPlayer = Players[iPlayer];

	if ( pPlayer:IsHuman() or pPlayer:IsMinorCiv() or pPlayer:IsBarbarian() ) then
		return false;
	end
	
	local pCapital = pPlayer:GetCapitalCity();

	if ( pCapital:IsHasBuilding( iNationalCollege ) or
	     pCapital:CanConstruct( iNationalCollege, 1 ) ) then
		return false;
	end
	
	local playerLibrary = iLibrary[ pPlayer:GetCivilizationType() ];

	if ( pCapital:IsHasBuilding( playerLibrary ) or
	     pCapital:CanConstruct( playerLibrary, 1 ) ) then
		for pCity in pPlayer:Cities() do
			if ( pCity:CanConstruct( playerLibrary ) and not
			     ( pCity:IsCapital() -- don't interrupt capital
			       or pCity:IsPuppet() ) ) then
				pCity:PushOrder( OrderTypes.ORDER_CONSTRUCT, playerLibrary, 0, 1, 1);
			end
		end
	end
end);