-- NationalWondersInCapital
-- Author: Peter
-- DateCreated: 5/2/2013 4:37:03 PM
--------------------------------------------------------------

local iNationalCollege = GameInfoTypes.BUILDING_NATIONAL_COLLEGE
local iHermitage = GameInfoTypes.BUILDING_HERMITAGE

GameEvents.CityCanConstruct.Add( function( iPlayer, iCity, iBuilding )
	-- Let human players make their own decisions
	local pPlayer = Players[iPlayer];
	if ( pPlayer:IsHuman()  or pPlayer:IsMinorCiv() or pPlayer:IsBarbarian() ) then
		return true;
	end

	-- AI non-capital cities may never build the National College or the Hermitage
	local pCity = pPlayer:GetCityByID( iCity );
	if ( not pCity:IsCapital() ) then
		return not ( iBuilding == iNationalCollege or iBuilding == iHermitage );
	end
  
	-- The AI can build anything it likes in the capital
	return true;
end);

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	local pPlayer = Players[iPlayer];

	if ( pPlayer:IsHuman() or pPlayer:IsMinorCiv() or pPlayer:IsBarbarian() ) then
		return false;
	end

	-- the 1 flag means that under construction still returns true
	if ( not pPlayer:CanConstruct( iNationalCollege, 1 ) and
	     not pPlayer:CanConstruct( iHermitage, 1 ) ) then
		return false;
	end

	local pCapital = pPlayer:GetCapitalCity();

	if ( pPlayer:CanConstruct( iNationalCollege, 1 ) ) then
		pCapital:PushOrder( OrderTypes.ORDER_CONSTRUCT, iNationalCollege, 0, 1, 1);
		return false;
	end

	if ( pPlayer:CanConstruct( iHermitage, 1 ) ) then
		pCapital:PushOrder( OrderTypes.ORDER_CONSTRUCT, iHermitage, 0, 1, 1);
		return false;
	end
end);