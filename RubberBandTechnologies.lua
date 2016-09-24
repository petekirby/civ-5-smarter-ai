-- RubberBandTechnologies
-- Author: Peter
-- DateCreated: 5/3/2013 2:51:49 PM
--------------------------------------------------------------

local iEraMedieval = GameInfoTypes.ERA_MEDIEVAL;
local iResearchLab = GameInfoTypes.BUILDING_LABORATORY;

local iArchery = GameInfoTypes.TECH_ARCHERY;
local iTheWheel = GameInfoTypes.TECH_THE_WHEEL;
local iHorsbackRiding = GameInfoTypes.TECH_HORSEBACK_RIDING;
local iMathematics = GameInfoTypes.TECH_MATHEMATICS;
local iMasonry = GameInfoTypes.TECH_MASONRY;
local iConstruction = GameInfoTypes.TECH_CONSTRUCTION;
local iIronWorking = GameInfoTypes.TECH_IRON_WORKING;
local iPottery = GameInfoTypes.TECH_POTTERY;
local iWriting = GameInfoTypes.TECH_WRITING;

local iEngineering = GameInfoTypes.TECH_ENGINEERING;
local iGuilds = GameInfoTypes.TECH_GUILDS;
local iCalendar = GameInfoTypes.TECH_CALENDAR;
local iPhilosophy = GameInfoTypes.TECH_PHILOSOPHY;

local iAcoustics = GameInfoTypes.TECH_ACOUSTICS;
local iPrintingPress = GameInfoTypes.TECH_PRINTING_PRESS;
local iSteel = GameInfoTypes.TECH_STEEL;
local iTrapping = GameInfoTypes.TECH_TRAPPING;
local iHorsebackRiding = GameInfoTypes.TECH_HORSEBACK_RIDING;
local iCurrency = GameInfoTypes.TECH_CURRENCY;
local iDrama = GameInfoTypes.TECH_DRAMA;
local iCivilService = GameInfoTypes.TECH_CIVIL_SERVICE;
local iTheology = GameInfoTypes.TECH_THEOLOGY;
local iEducation = GameInfoTypes.TECH_EDUCATION;

local iCompass = GameInfoTypes.TECH_COMPASS;
local iMachinery = GameInfoTypes.TECH_MACHINERY;
local iChivalry = GameInfoTypes.TECH_CHIVALRY;
local iPhysics = GameInfoTypes.TECH_PHYSICS;
local iSteel = GameInfoTypes.TECH_STEEL;
local iGunpowder = GameInfoTypes.TECH_GUNPOWDER;

local iMilitaryScience = GameInfoTypes.TECH_MILITARY_SCIENCE;
local iEconomics = GameInfoTypes.TECH_ECONOMICS;
local iScientificTheory = GameInfoTypes.TECH_SCIENTIFIC_THEORY;

local iRefrigeration = GameInfoTypes.TECH_REFRIGERATION;
local iRailroad = GameInfoTypes.TECH_RAILROAD;
local iElectronics = GameInfoTypes.TECH_ELECTRONICS;
local iElectricity = GameInfoTypes.TECH_ELECTRICITY;
local iSteamPower = GameInfoTypes.TECH_STEAM_POWER;
local iReplaceableParts = GameInfoTypes.TECH_REPLACEABLE_PARTS;
local iRadio = GameInfoTypes.TECH_RADIO;
local iPlastic = GameInfoTypes.TECH_PLASTIC;

local iBiology = GameInfoTypes.TECH_BIOLOGY;
local iFlight = GameInfoTypes.TECH_FLIGHT;

local iBabylon = GameInfoTypes.CIVILIZATION_BABYLON;

local iInca = GameInfoTypes.CIVILIZATION_INCA;
local iGreece = GameInfoTypes.CIVILIZATION_GREECE;
local iRome = GameInfoTypes.CIVILIZATION_ROME;
local iByzantium = GameInfoTypes.CIVILIZATION_BYZANTIUM;
local iCarthage = GameInfoTypes.CIVILIZATION_CARTHAGE;
local iIroquois = GameInfoTypes.CIVILIZATION_IROQUOIS;
local iGermany = GameInfoTypes.CIVILIZATION_GERMANY;

local iMongol = GameInfoTypes.CIVILIZATION_MONGOL;
local iArabia = GameInfoTypes.CIVILIZATION_ARABIA;
local iSiam = GameInfoTypes.CIVILIZATION_SIAM;
local iChina = GameInfoTypes.CIVILIZATION_CHINA;
local iEngland = GameInfoTypes.CIVILIZATION_ENGLAND;
local iKorea = GameInfoTypes.CIVILIZATION_KOREA;
local iDenmark = GameInfoTypes.CIVILIZATION_DENMARK;
local iJapan = GameInfoTypes.CIVILIZATION_JAPAN;
local iAmerica = GameInfoTypes.CIVILIZATION_AMERICA;
local iFrance = GameInfoTypes.CIVILIZATION_FRANCE;
local iOttoman = GameInfoTypes.CIVILIZATION_OTTOMAN;
local iSpain = GameInfoTypes.CIVILIZATION_SPAIN;

local iRussia = GameInfoTypes.CIVILIZATION_RUSSIA;
local iAustria = GameInfoTypes.CIVILIZATION_AUSTRIA;
local iSweden = GameInfoTypes.CIVILIZATION_SWEDEN;

local CivClassicalTech = {}
local CivMedievalTech = {}
local CivIndustrialTech = {}

CivClassicalTech[ iInca ] = iConstruction;
CivClassicalTech[ iGreece ] = iHorsebackRiding;
CivClassicalTech[ iRome ] = iMathematics;
CivClassicalTech[ iByzantium ] = iHorsebackRiding;
CivClassicalTech[ iCarthage ] = iHorsebackRiding;
CivClassicalTech[ iIroquois ] = iIronWorking;
CivClassicalTech[ iGermany ] = iCivilService;

CivMedievalTech[ iMongol ] = iChivalry;
CivMedievalTech[ iArabia ] = iChivalry;
CivMedievalTech[ iSiam ] = iChivalry;
CivMedievalTech[ iChina ] = iMachinery;
CivMedievalTech[ iEngland ] = iMachinery;
CivMedievalTech[ iKorea ] = iPhysics;
CivMedievalTech[ iDenmark ] = iSteel;
CivMedievalTech[ iJapan ] = iSteel;
CivMedievalTech[ iAmerica ] = iGunpowder;
CivMedievalTech[ iFrance ] = iGunpowder;
CivMedievalTech[ iOttoman ] = iGunpowder;
CivMedievalTech[ iSpain ] = iGunpowder;

CivIndustrialTech[ iRussia ] = iMilitaryScience;
CivIndustrialTech[ iAustria ] = iMilitaryScience;
CivIndustrialTech[ iSweden ] = iRifling;

local function NeedsWriting(iPlayer)
	local pPlayer = Players[iPlayer];
	if ( ( pPlayer:CanResearch( iPottery ) or
	     pPlayer:CanResearch( iWriting ) ) and not
		 pPlayer:IsResearchingTech( iWriting ) ) then
		return true;
	end

	return false;
end

local function NeedsPhilosophy(iPlayer)
	local pPlayer = Players[iPlayer];
	if ( ( pPlayer:CanResearch( iCalendar ) or
	     pPlayer:CanResearch( iPhilosophy ) ) and not
		 pPlayer:IsResearchingTech( iPhilosophy ) ) then
		return true;
	end

	return false;
end

local function NeedsEducation(iPlayer)
	local pPlayer = Players[iPlayer];
	if ( ( pPlayer:CanResearch( iTrapping ) or
	     pPlayer:CanResearch( iHorsebackRiding ) or
		 pPlayer:CanResearch( iCurrency ) or
		 pPlayer:CanResearch( iDrama ) or
		 pPlayer:CanResearch( iCivilService ) or
		 pPlayer:CanResearch( iTheology ) or
		 pPlayer:CanResearch( iEducation ) ) and not
		 pPlayer:IsResearchingTech( iEducation ) ) then
		return true;
	end

	return false;
end

local function NeedsPlastic(iPlayer)
	local pPlayer = Players[iPlayer];
	if ( ( pPlayer:CanResearch( iElectricity ) or
	     pPlayer:CanResearch( iSteamPower ) or
		 pPlayer:CanResearch( iReplaceableParts ) or
		 pPlayer:CanResearch( iRadio ) or
		 pPlayer:CanResearch( iPlastic ) ) and not
		 pPlayer:IsResearchingTech( iPlastic ) ) then
		return true;
	end

	if ( not pPlayer:CanConstruct( iResearchLab, 1 )
	     and not pPlayer:GetCapitalCity():IsHasBuilding( iResearchLab ) ) then
		return true;
	end

	return false;
end

local function TechForBabylon(iPlayer)
	local pPlayer = Players[iPlayer];

	if ( pPlayer:IsResearchingTech( iEducation ) or
	     pPlayer:CanResearch( iAcoustics ) ) then
		return false;
	end

	if ( pPlayer:CanResearch( iArchery ) ) then
		pPlayer:PushResearch( iWriting, 1 );
		pPlayer:PushResearch( iArchery );
		return false;
	end

	if ( pPlayer:CanResearch( iIronWorking ) or
	     pPlayer:CanResearch( iEngineering ) or
		 pPlayer:CanResearch( iGuilds ) ) then
		pPlayer:PushResearch( iMasonry, 1 );
		pPlayer:PushResearch( iTheWheel );
		pPlayer:PushResearch( iPhilosophy );
		pPlayer:PushResearch( iHorsebackRiding );
		pPlayer:PushResearch( iCurrency );
		pPlayer:PushResearch( iCivilService );
		pPlayer:PushResearch( iEducation );
	end
end

local function TechToWriting(iPlayer)
	local pPlayer = Players[iPlayer];
	local rand1 = math.random(2);
	local rand2 = math.random(4);
	local iClassicalTech;
	local iPredefinedClassicalTech = CivClassicalTech[ pPlayer:GetCivilizationType() ];
	
	if ( rand2 == 1 ) then iClassicalTech = iHorsebackRiding end;
	if ( rand2 == 2 ) then iClassicalTech = iMathematics end;
	if ( rand2 >= 3 ) then iClassicalTech = iConstruction end;
	
	if ( iPredefinedClassicalTech ~= nil ) then
		iClassicalTech = iPredefinedClassicalTech;
	end
	
	if ( rand1 == 1 ) then
		pPlayer:PushResearch( iClassicalTech, 1 );
		pPlayer:PushResearch( iWriting );
	else
		pPlayer:PushResearch( iWriting, 1 );
		pPlayer:PushResearch( iClassicalTech );
	end
end

local function TechToPhilosophy(iPlayer)
	local pPlayer = Players[iPlayer];

	if ( pPlayer:CanResearch( iMasonry ) or
	     pPlayer:CanResearch( iConstruction ) ) then
		pPlayer:PushResearch( iConstruction, 1 );
		pPlayer:PushResearch( iPhilosophy );
	else
		pPlayer:PushResearch( iPhilosophy );
	end
end

local function TechToEducation(iPlayer)
	local pPlayer = Players[iPlayer];
	local rand1 = math.random(2);
	local rand2 = math.random(3);
	local rand3 = math.random(3);
	local iMedievalTech;
	local iPredefinedMedievalTech = CivMedievalTech[ pPlayer:GetCivilizationType() ];
	local iPredefinedIndustrialTech = CivIndustrialTech[ pPlayer:GetCivilizationType() ];

	if ( rand2 == 1 ) then iMedievalTech = iChivalry end;
	if ( rand2 == 2 ) then iMedievalTech = iPhysics end;
	if ( rand2 == 3 ) then iMedievalTech = iMachinery end;

	if ( iPredefinedMedievalTech ~= nil ) then
		iMedievalTech = iPredefinedMedievalTech;
	end
	
	if ( rand1 == 1 ) then
		pPlayer:PushResearch( iMedievalTech, 1 );
		if ( rand3 == 1 ) then pPlayer:PushResearch( iTheology ) end;
		if ( rand3 >= 2 ) then pPlayer:PushResearch( iCivilService ) end;
		pPlayer:PushResearch( iEducation );
	else
		if ( rand3 == 1 ) then pPlayer:PushResearch( iTheology, 1 ) end;
		if ( rand3 >= 2 ) then pPlayer:PushResearch( iCivilService, 1 ) end;
		pPlayer:PushResearch( iEducation );
		pPlayer:PushResearch( iMedievalTech );
	end

	if ( iPredefinedIndustrialTech ~= nil ) then
		if ( rand1 == 1 ) then
			pPlayer:PushResearch( iEconomics );
			pPlayer:PushResearch( iScientificTheory );
			pPlayer:PushResearch( iMachinery );
			pPlayer:PushResearch( iPredefinedIndustrialTech );
		else
			pPlayer:PushResearch( iMachinery );
			pPlayer:PushResearch( iPredefinedIndustrialTech );
			pPlayer:PushResearch( iEconomics );
			pPlayer:PushResearch( iScientificTheory );
		end
	end
end

local function TechToPlastic(iPlayer)
	local pPlayer = Players[iPlayer];
	local rand1 = math.random(2);

	if ( pPlayer:CanResearch( iRefrigeration ) ) then
		pPlayer:PushResearch( iRadio, 1 )
	elseif ( rand1 == 1 ) then
		pPlayer:PushResearch( iRadio, 1 )
	else
		pPlayer:PushResearch( iReplaceableParts, 1 )
	end

	if ( pPlayer:CanResearch( iBiology ) or
	     pPlayer:CanResearch( iFlight ) ) then
		if ( pPlayer:CanResearch( iBiology ) ) then
			pPlayer:PushResearch( iBiology, 1 );
			pPlayer:PushResearch( iFlight );
		else
			pPlayer:PushResearch( iFlight );
		end
	end
	
	pPlayer:PushResearch( iPlastic );
end

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	local pPlayer = Players[iPlayer];

	if ( pPlayer:IsHuman() or pPlayer:IsMinorCiv() or pPlayer:IsBarbarian() ) then
		return false;
	end

	if ( pPlayer:GetCurrentEra() <= iEraMedieval ) then
		if ( pPlayer:GetCivilizationType() == iBabylon ) then
			TechForBabylon( iPlayer );
		end

		if ( pPlayer:CanResearch( iMathematics )
		     or pPlayer:CanResearch( iIronWorking ) ) then
			if ( NeedsWriting( iPlayer ) ) then
				TechToWriting( iPlayer );
			end
		end

		if ( pPlayer:CanResearch( iGuilds )
		     or pPlayer:CanResearch( iEngineering ) ) then
			 if ( NeedsPhilosophy( iPlayer ) ) then
				TechToPhilosophy( iPlayer );
			end
		end

		if ( pPlayer:CanResearch( iPhysics ) or
		     pPlayer:CanResearch( iChivalry ) or
			 pPlayer:CanResearch( iCompass ) ) then
			if ( NeedsEducation( iPlayer ) ) then
				TechToEducation( iPlayer );
			end
		end
	else
		if ( pPlayer:CanResearch( iRefrigeration ) or
		     pPlayer:CanResearch( iRailroad ) or
			 pPlayer:CanResearch( iElectronics ) ) then
			if ( NeedsPlastic( iPlayer ) ) then
				TechToPlastic( iPlayer );
			end
		end
	end

	return false;
end);