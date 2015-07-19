local enemies = {}
require("Inspired")
require("IWalk")
local eOn = false
local KillableEnemiesWithUlt = 0
local RDamage = 0
local RBaseDmg = {0,250,400,550}
function AfterObjectLoopEvent(myHero)
	local origin = GetOrigin(myHero)
    if not inserted then
        for k,v in pairs(GetEnemyHeroes()) do
            table.insert(enemies, v)
        end
        if #enemies > 0 then inserted = true end
    end
	
		if KeyIsDown(0x20) then
			local unit = GetTarget(2500)
				if ValidTarget(unit, 2500) then 
				local QPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),500,250,875,160,false,true)
				local WPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),math.huge,500,1000,100,false,true)
				
				if CanUseSpell(myHero, _E) and IsInDistance(unit,425) and not eOn then
				CastTargetSpell(myHero,_E)
				eOn = true
				end
				if not IsInDistance(unit,425) and eOn then
				CastTargetSpell(myHero,_E)
				eOn = false
				end
				if CanUseSpell(myHero, _Q) == READY and IsInDistance(unit, 875) and QPred.HitChance == 1 then
				CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
				end
				if CanUseSpell(myHero, _W) == READY and IsInDistance(unit, 1000) and QPred.HitChance == 1 then
				CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
				end
				IWalk()
				end
	end
	RDamage = (RBaseDmg[GetCastLevel(myHero,_R)+1]+(GetBonusAP(myHero)/100)*60)
	if CanUseSpell(myHero, _R) == READY then
	KillableEnemiesWithUlt = 0
	if GetCurrentHP(enemies[1]) < CalcDamage(myHero,enemies[1],0,RDamage) and ValidTarget(enemies[1])then
	KillableEnemiesWithUlt = KillableEnemiesWithUlt +1
	end
		if GetCurrentHP(enemies[2]) < CalcDamage(myHero,enemies[2],0,RDamage)and ValidTarget(enemies[2])then
	KillableEnemiesWithUlt = KillableEnemiesWithUlt +1
	end
		if GetCurrentHP(enemies[3]) < CalcDamage(myHero,enemies[3],0,RDamage)and ValidTarget(enemies[3])then
	KillableEnemiesWithUlt = KillableEnemiesWithUlt +1
	end
		if GetCurrentHP(enemies[4]) < CalcDamage(myHero,enemies[4],0,RDamage)and ValidTarget(enemies[4])then
	KillableEnemiesWithUlt = KillableEnemiesWithUlt +1
	end
		if GetCurrentHP(enemies[5]) < CalcDamage(myHero,enemies[5],0,RDamage)and ValidTarget(enemies[5])then
	KillableEnemiesWithUlt = KillableEnemiesWithUlt +1
	end
	local myscreenpos = WorldToScreen(1,origin.x,origin.y,origin.z)
	DrawText(string.format("KillableEnemiesWithUlt = %f",KillableEnemiesWithUlt),24,myscreenpos.x,myscreenpos.y,0xff00ff00)
end
end