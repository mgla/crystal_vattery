--@module = true
--@enable = true

print('cv main')

local eventful = require("plugins.eventful")
local modId = "crystal-vattery"
local replacement_materials = {
    ["CV_AUSTENITE_CRYSTAL"] = "CV_AUSTENITE_CRYSTAL"
}

-- From https://github.com/DFHack/dfhack/blob/develop/plugins/lua/eventful.lua#L152C11-L152C22
eventful.enableEvent(eventful.eventType.ITEM_CREATED, 1)

eventful.onItemCreated[modId] = function(item_id)
    print('cv: onItemCreated' + 'id: ' + item_id)

    -- get item reference from id
    local item = df.item.find(item_id)
    -- check if material is in the list for this mod, if yes, replace
    local material = (dfhack.matinfo.decode(item.mat_type,item.mat_index).plant.id)
    print("cv: material: " + material)
    if replacement_materials[material] then
        local pos = dfhack.items.getPosition(item)
        dfhack.items.remove(item)
        -- see https://github.com/DFHack/scripts/blob/master/modtools/create-item.lua
        -- and https://github.com/DFHack/scripts/blob/master/gui/create-item.lua
        -- script.start(createitem.hackWish, default_accessors, opts) or something  
        -- modtools/create-item -i BAR:NONE -m INORGANIC:CV_AUSTENITE
        print('will replace item')
    end
end

-- mod enables itself
function isEnabled()
    return true
end