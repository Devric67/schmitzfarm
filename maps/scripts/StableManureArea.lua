 local metadata = {
"## Interface:FS17 1.3.1.0 1.3.1RC10",
"## Title: StableManureArea",
"## Notes: flacher ManureHeap für Stall ausmisten.",
"## Author: Marhu",
"## Version: 1.0.0-15",
"## Date: 24.12.2016",
"## Web: http://marhu.net"
}

local function getmdata(v) v="## "..v..": "; for i=1,table.getn(metadata) do local _,n=string.find(metadata[i],v);if n then return (string.sub (metadata[i], n+1)); end;end;end;
local function LP(t) print((getmdata("Title")).." ("..netGetTime().."): "..tostring(t)); end;
local function L(name) return g_i18n:hasText((getmdata("Title")).."_"..name) and g_i18n:getText((getmdata("Title")).."_"..name) or name; end;

StableManureArea = {};
StableManureArea.modDir = g_currentModDirectory;

function StableManureArea:loadMap(name)
	local startPos, _ = string.find(name,self.modDir)
	if startPos then
		AnimalHusbandry.updateManure = StableManureArea.updateManure
		print("Script "..(getmdata("Title")).." v"..(getmdata("Version")).." by "..(getmdata("Author")).." hook AnimalHusbandry.updateManure! Support on "..(getmdata("Web")));
	end
end;

function StableManureArea:deleteMap()
end;

function StableManureArea:keyEvent(unicode, sym, modifier, isDown)
end;

function StableManureArea:mouseEvent(posX, posY, isDown, isUp, button)
end;

function StableManureArea:update(dt)
end;

function StableManureArea:draw()	
end;

function StableManureArea:updateManure(manureIncrease)
	
	if self.manureArea == nil then
        return;
    end

    local manureDropped = 0;
    local fillType = FillUtil.FILLTYPE_MANURE;
    local manureArea = self.manureArea;

    if manureIncrease > TipUtil.getMinValidLiterValue(fillType) then
        local xs,_,zs = getWorldTranslation(manureArea.start);
        local xw,_,zw = getWorldTranslation(manureArea.width);
        local xh,_,zh = getWorldTranslation(manureArea.height);

        local ux, uz = xw-xs, zw-zs;
        local vx, vz = xh-xs, zh-zs;

        local vLength = Utils.vector2Length(vx,vz);

        local sx = xs + (math.random()*ux) + (math.random()*vx);
        local sz = zs + (math.random()*uz) + (math.random()*vz);

        local ex = xs + (math.random()*ux) + (math.random()*vx);
        local ez = zs + (math.random()*uz) + (math.random()*vz);

        local sy = getTerrainHeightAtWorldPos(g_currentMission.terrainRootNode, sx,0,sz);
        local ey = getTerrainHeightAtWorldPos(g_currentMission.terrainRootNode, ex,0,ez);
		
		local dropped, lineOffset = TipUtil.tipToGroundAroundLine(nil, manureIncrease, fillType, sx,sy,sz, ex,ey,ez, 0, vLength, self.lineOffsetManure, false, nil)
        manureDropped = dropped;
        self.lineOffsetManure = lineOffset;
    end
	
	return manureDropped;
end

addModEventListener(StableManureArea);