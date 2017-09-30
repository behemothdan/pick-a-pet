SLASH_PICKAPET1, SLASH_PICKAPET2, SLASH_PICKAPET3 = '/pap', '/pickapet', '/qq';
function SlashCmdList.PICKAPET(msg, editbox)
	if PickAPetFrame:IsVisible() then
		PickAPetFrame:Hide()
	else
		PickAPetFrame:Show()
	end
end

function startUpMessage()
	ChatFrame1:AddMessage("<Drotara's Pick-A-Pet> Type /qq or /pickapet or /pap to use.");
end

haveBloodlust = false;
haveKings = false;
haveFort = false;
haveSunder = false;
haveRampage = false;
haveBloodFrenzy = false;
haveEbonPlague = false;
haveHornWinter = false;
haveMangle = false;

bloodlustRank = 10;
kingsRank = 9;
fortRank = 8;
sunderRank = 7;
rampageRank = 6;
bloodFrenzyRank = 5;
ebonPlagueRank = 4;
hornWinterRank = 3;
mangleRank = 2;
mostImportantBuff = 1;

function hunterSpec()
	playerSpec = "";
	bmTalentCount = GetNumTalents(1);
	mmTalentCount = GetNumTalents(2);
	survTalentCount = GetNumTalents(3);
	playerClass, englishClass = UnitClass("player");
	
	bmNameTalent, bmIcon, bmTier, bmColumn, bmCurrRank, bmMaxRank = GetTalentInfo(1,bmTalentCount);
	mmNameTalent, mmIcon, mmTier, mmColumn, mmCurrRank, mmMaxRank = GetTalentInfo(2,mmTalentCount);
	svNameTalent, svIcon, svTier, svColumn, svCurrRank, svMaxRank = GetTalentInfo(3,survTalentCount);
	
	if playerClass == "Hunter" then
		if bmCurrRank > 0 then
			playerSpec = "Beast Mastery";					
		elseif mmCurrRank > 0 then	
			playerSpec = "Marksmanship";	
		elseif svCurrTank > 0 then	
			playerSpec = "Survival";		
		end
	end	
end

function petRecommendation()
	local stableIndex = 1;
	while stableIndex <= 4 do
		petIcon, petName, petLevel, petType, petLoyalty = GetStablePetInfo(stableIndex);		
		if playerSpec == "Beast Mastery" then		
			if petType == "Core Hound" and haveBloodlust == false then
				if bloodlustRank > mostImportantBuff then
					bestRecommendedPet:SetNormalTexture(petIcon);
					mostImportantBuff = bloodlustRank;
				end
			elseif petType == "Shale Spider" and haveKings == false then
				if kingsRank > mostImportantBuff then
					bestRecommendedPet:SetNormalTexture(petIcon);
					mostImportantBuff = kingsRank;
				end				
			elseif petType == "Silithid" and haveFort == false then
				if fortRank > mostImportantBuff then
					bestRecommendedPet:SetNormalTexture(petIcon);
					mostImportantBuff = fortRank;
				end
			end			
		elseif playerSpec ~= "Beast Mastery" then
			if petType == "Raptor" or petType == "Serpent" and haveSunder == false then
				if sunderRank > mostImportantBuff then
					bestRecommendedPet:SetNormalTexture(petIcon);
					mostImportantBuff = sunderRank;
				end
			elseif petType == "Wolf" or petType == "Devilsaur" and haveRampage == false then
				if rampageRank > mostImportantBuff then
					bestRecommendedPet:SetNormalTexture(petIcon);
					mostImportantBuff = rampageRank;
				end
			elseif petType == "Ravager" and haveBloodFrenzy == false then	
				if bloodFrenzyRank > mostImportantBuff then
					bestRecommendedPet:SetNormalTexture(petIcon);
					mostImportantBuff = bloodFrenzyRank;
				end
			elseif petType == "Wind Serpent" or petType == "Dragonhawk" and haveEbonPlague == false then	
				if ebonPlagueRank > mostImportantBuff then
					bestRecommendedPet:SetNormalTexture(petIcon);
					mostImportantBuff = ebonPlagueRank;
				end
			elseif petType == "Cat" or petType == "Spirit Beast" and haveHornWinter == false then	
				if hornWinterRank > mostImportantBuff then
					bestRecommendedPet:SetNormalTexture(petIcon);
					mostImportantBuff = hornWinterRank;
				end
			elseif petType == "Hyena" and haveMangle == false then	
				if mangleRank > mostImportantBuff then
					bestRecommendedPet:SetNormalTexture(petIcon);
					mostImportantBuff = mangleRank;
				end		
			end
		end
		stableIndex = stableIndex + 1;
	end	
end

function getPartyMembers()		
	local partyIndex = 1;
	local numberInParty = GetNumPartyMembers();
	local playerClassIndex;
	local playerSpot;
	
	if numberInParty > 0 then
		while partyIndex <= numberInParty do		
			playerSpot = "party"..partyIndex;
			playerClassIndex = UnitClass(playerSpot);				
			currentPlayerName = UnitName(playerSpot);			
			
			if CheckInteractDistance(currentPlayerName, 1) and CanInspect(currentPlayerName) then
				NotifyInspect(currentPlayerName);					
			end
			
			talentTab1 = GetNumTalents(1, true);
			talentTab2 = GetNumTalents(2, true);
			talentTab3 = GetNumTalents(3, true);
						
			if playerClassIndex == "Death Knight" then
				Cat:SetAlpha(".1");
				haveHornWinter = true;
				bloodNameTalent, bloodIcon, bloodTier, bloodColumn, bloodCurrRank, bloodMaxRank = GetTalentInfo(1,talentTab1,true);
				frostNameTalent, frostIcon, frostTier, frostColumn, frostCurrRank, frostMaxRank = GetTalentInfo(2,talentTab2,true);
				unholyNameTalent, unholyIcon, unholyTier, unholyColumn, unholyCurrRank, unholyMaxRank = GetTalentInfo(3,talentTab3,true);					
				if unholyCurrRank > 0 then
					WindSerpent:SetAlpha(".1");
					haveEbonPlague = true;
					ClearInspectPlayer();
				elseif frostCurrRank > 0 then
					Ravager:SetAlpha(".1");
					haveBloodFrenzy = true;
					ClearInspectPlayer();
				end
				
			elseif playerClassIndex == "Druid" then
				Kings:SetAlpha(".1");
				balanceNameTalent, balanceIcon, balanceTier, balanceColumn, balanceCurrRank, balanceMaxRank = GetTalentInfo(1,talentTab1,true);
				feralNameTalent, feralIcon, feralTier, feralColumn, feralCurrRank, feralMaxRank = GetTalentInfo(2,talentTab2,true);
				restoNameTalent, restoIcon, restoTier, restoColumn, restoCurrRank, restoMaxRank = GetTalentInfo(3,talentTab3,true);
				if balanceCurrRank > 0 then
					WindSerpent:SetAlpha(".1");
					ClearInspectPlayer();
				elseif feralCurrRank > 0 then
					haveRampage = true;
					haveMangle = true;
					Raptor:SetAlpha(".1");
					Wolf:SetAlpha(".1");
					Hyena:SetAlpha(".1");
					ClearInspectPlayer();
				end	
				
			elseif playerClassIndex == "Mage" then				
				ClearInspectPlayer();
				
			elseif playerClassIndex == "Paladin" then
				Kings:SetAlpha(".1");
				haveKings = true;
				ClearInspectPlayer();
				
			elseif playerClassIndex == "Priest" then
				Silithid:SetAlpha(".1");
				haveFort = true;
				ClearInspectPlayer();
				
			elseif playerClassIndex == "Rogue" then
				assNameTalent, assIcon, assTier, assColumn, assCurrRank, assMaxRank = GetTalentInfo(1,talentTab1,true);
				combatNameTalent, combatIcon, combatTier, combatColumn, combatCurrRank, combatMaxRank = GetTalentInfo(2,talentTab2,true);
				subNameTalent, subIcon, subTier, subColumn, subCurrRank, subMaxRank = GetTalentInfo(3,talentTab3,true);
				if subCurrRank > 0 then
					haveRampage = true;
					Wolf:SetAlpha(".1");
					Hyena:SetAlpha(".1");
					ClearInspectPlayer();
				elseif assCurrRank > 0 then
					WindSerpent:SetAlpha(".1");
					ClearInspectPlayer();
				elseif combatCurrRank > 0 then
					Ravager:SetAlpha(".1");
					ClearInspectPlayer();
				end		
				
			elseif playerClassIndex == "Shaman" then
				CoreHound:SetAlpha(".1");
				haveBloodlust = true;
				eleNameTalent, eleIcon, eleTier, eleColumn, eleCurrRank, eleMaxRank = GetTalentInfo(1,19,true);
				enhNameTalent, enhIcon, enhTier, enheColumn, enheCurrRank, enhMaxRank = GetTalentInfo(2,19,true);
				if eleCurrRank > 0 then
					Wolf:SetAlpha(".1");
					haveRampage = true;
					ClearInspectPlayer();
				elseif enhCurrRank > 0 then
					Cat:SetAlpha(".1");
					ClearInspectPlayer();
				end	
				
			elseif playerClassIndex == "Warlock" then
				destroNameTalent, destroIcon, destroTier, destroColumn, destroCurrRank, destroMaxRank = GetTalentInfo(3,talentTab3,true);
				if destoCurrRank > 0 then
					Silithid:SetAlpha(".1");
					haveFort = true;
					ClearInspectPlayer();
				end
				
			elseif playerClassIndex == "Warrior" then
				armsNameTalent, armsIcon, armsTier, armsColumn, armsCurrRank, armsMaxRank = GetTalentInfo(1,talentTab1,true);
				furyNameTalent, furyIcon, furyTier, furyColumn, furyCurrRank, furyMaxRank = GetTalentInfo(2,talentTab2,true);
				protwarrNameTalent, protwarrIcon, protwarrTier, protwarrColumn, protwarrCurrRank, protwarrMaxRank = GetTalentInfo(3,talentTab3,true);
				ClearInspectPlayer();
				if protwarrCurrRank > 0 then
					Raptor:SetAlpha(".1");	
					haveSunder = true;
					ClearInspectPlayer();
				elseif armsCurrRank > 0 then
					Hyena:SetAlpha(".1");
					Ravager:SetAlpha(".1");
					Cat:SetAlpha(".1");
					ClearInspectPlayer();
				elseif furyCurrRank > 0 then
					Wolf:SetAlpha(".1");
					Cat:SetAlpha(".1");
					haveRampage = true;
					haveHornWinter = true;
					ClearInspectPlayer();
				end			
			end
			partyIndex = partyIndex+1;	
		end			
		
	elseif numberInParty == 0 then
		Cat:SetAlpha("1");
		CoreHound:SetAlpha("1");
		Hyena:SetAlpha("1");
		Kings:SetAlpha("1");		
		Raptor:SetAlpha("1");			
		Ravager:SetAlpha("1");
		Silithid:SetAlpha("1");							
		WindSerpent:SetAlpha("1");
		Wolf:SetAlpha("1");	
	end	
end

function ShowCoreHoundTooltip()
	GameTooltip_SetDefaultAnchor( GameTooltip, UIParent );
	GameTooltip:AddLine("30% Haste", 0, 1, 0);
	GameTooltip:AddLine( "Pet Families:");
	GameTooltip:AddDoubleLine( "Corehounds", "Pet requires Beast Mastery", 1,1,1,1,0,0 );	
	if playerSpec == "Beast Mastery" then
		GameTooltip:AddLine( "You can provide this buff.",0,1,0);
	elseif playerSpec == "Marksmanship" then
		GameTooltip:AddLine( "You cannot provide this buff as Marksmanship.",1,0,0);
	elseif playerSpec == "Survival" then
		GameTooltip:AddLine( "You cannot provide this buff as Survival.",1,0,0);
	end
	GameTooltip:Show();
end

function ShowKingsTooltip()
	GameTooltip_SetDefaultAnchor( GameTooltip, UIParent );
	GameTooltip:AddLine("5% Stats", 0, 1, 0);
	GameTooltip:AddLine( "Pet Families:");
	GameTooltip:AddDoubleLine( "Shale Spiders", "Pet requires Beast Mastery", 1,1,1,1,0,0 );
		if playerSpec == "Beast Mastery" then
		GameTooltip:AddLine( "You can provide this buff.",0,1,0);
	elseif playerSpec == "Marksmanship" then
		GameTooltip:AddLine( "You cannot provide this buff as Marksmanship.",1,0,0);
	elseif playerSpec == "Survival" then
		GameTooltip:AddLine( "You cannot provide this buff as Survival.",1,0,0);
	end
	GameTooltip:Show();
end

function ShowSilithidTooltip()
	GameTooltip_SetDefaultAnchor( GameTooltip, UIParent );
	GameTooltip:AddLine("Bonus Health", 0, 1, 0);
	GameTooltip:AddLine( "Pet Families:");
	GameTooltip:AddDoubleLine( "Silithids", "Pet requires Beast Mastery", 1,1,1,1,0,0 );	
	if playerSpec == "Beast Mastery" then
		GameTooltip:AddLine( "You can provide this buff.",0,1,0);
	elseif playerSpec == "Marksmanship" then
		GameTooltip:AddLine( "You cannot provide this buff as Marksmanship.",1,0,0);
	elseif playerSpec == "Survival" then
		GameTooltip:AddLine( "You cannot provide this buff as Survival.",1,0,0);
	end	
	GameTooltip:Show();
end

function ShowRaptorTooltip()
	GameTooltip_SetDefaultAnchor( GameTooltip, UIParent );
	GameTooltip:AddLine( "12% Armor Debuff", 0,1,0 );
	GameTooltip:AddLine( "Pet Families:");
	GameTooltip:AddLine( "Raptor",1,1,1 );
	GameTooltip:AddLine( "Serpent",1,1,1 );
	GameTooltip:Show();
end

function ShowWolfTooltip()
	GameTooltip_SetDefaultAnchor( GameTooltip, UIParent );
	GameTooltip:AddLine( "5% Crit", 0,1,0 );
	GameTooltip:AddLine( "Pet Families:");
	GameTooltip:AddLine( "Wolf",1,1,1);
	GameTooltip:AddDoubleLine( "Devilsaur", "Pet requires Beast Mastery", 1,1,1,1,0,0 );
	GameTooltip:Show();
end

function ShowRavagerTooltip()
	GameTooltip_SetDefaultAnchor( GameTooltip, UIParent );
	GameTooltip:AddLine( "4% Increased Physical Damage", 0,1,0 );
	GameTooltip:AddLine( "Pet Families:");
	GameTooltip:AddLine( "Ravager", 1,1,1 );
	GameTooltip:Show();
end

function ShowWindSerpentTooltip()
	GameTooltip_SetDefaultAnchor( GameTooltip, UIParent );
	GameTooltip:AddLine( "8% Increased Spell Damage", 0,1,0 );
	GameTooltip:AddLine( "Pet Families:");
	GameTooltip:AddLine( "Dragonhawk",1,1,1 );
	GameTooltip:AddLine( "Wind Serpent",1,1,1 );
	GameTooltip:Show();
end

function ShowCatTooltip()
	GameTooltip_SetDefaultAnchor( GameTooltip, UIParent );
	GameTooltip:AddLine( "Bonus Strength and Agility", 0,1,0 );
	GameTooltip:AddLine( "Pet Families:");
	GameTooltip:AddLine( "Cat", 1,1,1 );
	GameTooltip:AddDoubleLine( "Spirit Beast", "Pet requires Beast Mastery", 1,1,1,1,0,0 );
	GameTooltip:Show();
end

function ShowHyenaTooltip()
	GameTooltip_SetDefaultAnchor( GameTooltip, UIParent );
	GameTooltip:AddLine( "30% Bleed Debuff", 0,1,0 );
	GameTooltip:AddLine( "Pet Families:");
	GameTooltip:AddLine( "Hyena", 1,1,1 );
	GameTooltip:Show();
end

function HideGameTooltip()
	GameTooltip:Hide();
end

function getHunterPetInfo()
	petIcon1, petName1, petLevel1, petType1, petLoyalty1 = GetStablePetInfo(1);
	petIcon2, petName2, petLevel2, petType2, petLoyalty2 = GetStablePetInfo(2);
	petIcon3, petName3, petLevel3, petType3, petLoyalty3 = GetStablePetInfo(3);
	petIcon4, petName4, petLevel4, petType4, petLoyalty4 = GetStablePetInfo(4);	
	
	Stable1Button:SetNormalTexture(petIcon1);
	Stable2Button:SetNormalTexture(petIcon2);
	Stable3Button:SetNormalTexture(petIcon3);
	Stable4Button:SetNormalTexture(petIcon4);
	
	Stable1Button:SetPushedTexture(petIcon1);
	Stable2Button:SetPushedTexture(petIcon2);
	Stable3Button:SetPushedTexture(petIcon3);
	Stable4Button:SetPushedTexture(petIcon4);	
end

function ShowStable1Tooltip()
	GameTooltip_SetDefaultAnchor( GameTooltip, UIParent );
	GameTooltip:AddLine( petName1, 0,1,0 );
	GameTooltip:AddLine( petType1..", Level "..petLevel1 );
	GameTooltip:Show();
end

function ShowStable2Tooltip()
	GameTooltip_SetDefaultAnchor( GameTooltip, UIParent );
	GameTooltip:AddLine( petName2, 0,1,0 );
	GameTooltip:AddLine( petType2..", Level "..petLevel2 );
	GameTooltip:Show();
end

function ShowStable3Tooltip()
	GameTooltip_SetDefaultAnchor( GameTooltip, UIParent );
	GameTooltip:AddLine( petName3, 0,1,0 );
	GameTooltip:AddLine( petType3..", Level "..petLevel3 );
	GameTooltip:Show();
end
	
function ShowStable4Tooltip()
	GameTooltip_SetDefaultAnchor( GameTooltip, UIParent );
	GameTooltip:AddLine( petName4, 0,1,0 );
	GameTooltip:AddLine( petType4..", Level "..petLevel4 );
	GameTooltip:Show();
end	