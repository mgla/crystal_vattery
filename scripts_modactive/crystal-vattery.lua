--@module = true
--@enable = true

print('cv main')

local replace = reqscript('internal/crystal-vattery/replace-plant-yield')
local modId = "crystal-vattery"

-- mod enables itself
function isEnabled()
    return true
end

dfhack.run_script("modtools/create-item", "-i", "BAR:NONE", "-m", "INORGANIC:CV_AUSTENITE")