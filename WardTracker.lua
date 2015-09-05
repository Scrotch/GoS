require("DLib")

local root = menu.addItem(SubMenu.new("Ward Tracker"))
local trackWards = root.addItem(MenuBool.new("Enabled",true))


wards = {}
traps = {}

OnCreateObj(function(Object)
	if trackWards.getValue() then
		local objName = GetObjectBaseName(Object)
		if Object ~= nil then
			if  objName:lower():find("ward") and not objName:lower():find("idle") and not objName:lower():find("death") then
					table.insert(wards,Object)
			end
			--[[if (objName:lower():find("caitlynyordletrap") or objName:lower():find("noxious") or objName:lower():find("jackinthebox") or objName:lower():find("bushwhack")) and not objName:lower():find("idle") and not objName:lower():find("death") then
				table.insert(traps,Object)
			end]]--
		end
	end
	end)


OnDeleteObj(function(Object)
	if trackWards.getValue() then
		local objName =  GetObjectBaseName(Object)
		local objOrigin = GetOrigin(Object)
		if Object ~= nil then
			if  objName:lower():find("ward") and not objName:lower():find("idle") then
			for index, ward in pairs(wards) do
				if GetOrigin(ward) == GetOrigin(Object) then
					table.remove(wards, index)
				end
			end
			end
		--[[if (objName:lower():find("caitlynyordletrap") or objName:lower():find("teemomushroom") or objName:lower():find("jackinthebox") or objName:lower():find("bushwhack")) and not objName:lower():find("idle") then
				table.remove(traps,index)
			end]]--
		end
	end
	end)
OnObjectLoop(function(Object, myHero)

	-- THE FPS EATER
	--[[local objName = GetObjectBaseName(Object)
	if Object ~= nil then
		if  objName:lower():find("ward") and not objName:lower():find("idle") and not objName:lower():find("death") then
			if not inTable(wards,Object)then
				table.insert(wards,Object)
			end
		end
	end]]--
	end)
OnLoop(function(myHero)
	if trackWards.getValue() then
		for index, ward in pairs(wards) do
			if (GetCurrentMana(ward) <= 1) and GetObjectBaseName(ward):lower():find("sight") then
				table.remove(wards, index)
			end
			if GetObjectBaseName(ward):lower():find("sight") then
				DrawCircle(GetOrigin(ward), 150, 1, 200, ARGB(255, 0, 255, 0))

				local w2sWard = WorldToScreen(1, GetOrigin(ward))
				DrawText(GetCurrentMana(ward), 20, w2sWard.x,w2sWard.y, ARGB(255, 255, 255, 255))
		end
			if GetObjectBaseName(ward):lower():find("vision") then
				DrawCircle(GetOrigin(ward), 150, 1, 200, ARGB(255,255,0,255))
			end
		end
		--[[for index, trap in pairs(traps) do
			DrawCircle(GetOrigin(trap), GetHitBox(trap)+25, 1, 200, ARGB(255,255,0,0))
		end]]--
	end
	end)

--[[function inTable(tbl, item)
    for key, value in pairs(tbl) do
        if value == item then return true end
    end
    return false
end]]--
