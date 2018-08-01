ModMap = {}
local ModMap_mt = Class(ModMap, Mission00)

function ModMap:new(baseDirectory, customMt)
    local mt = customMt
    if mt == nil then
        mt = ModMap_mt
    end
    local self = ModMap:superClass():new(baseDirectory, mt)

    -- Number of additional channels that are used compared to the original setting (2)
    local numAdditionalAngleChannels = 3;

    self.terrainDetailAngleNumChannels = self.terrainDetailAngleNumChannels + numAdditionalAngleChannels;
    self.terrainDetailAngleMaxValue = (2^self.terrainDetailAngleNumChannels) - 1;

    self.sprayLevelFirstChannel = self.sprayLevelFirstChannel + numAdditionalAngleChannels;

    self.ploughCounterFirstChannel = self.ploughCounterFirstChannel + numAdditionalAngleChannels;

    return self
end