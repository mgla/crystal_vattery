--@module = true

local debug = false

if debug then print('cv replace-items') end

local eventful = require("plugins.eventful")
local modId = "crystal-vattery"

--[[
Replacement material dictionary. This will only replace items created that are
plants, which usually means harvested plants or logs from trees (or entities
using pretending to be trees, like in this mod.

Usage

  [PLANT_ID] = {                   -- the id of your plant, contains an array of replacement instructions
    {
      ['item'] = 'BAR:NONE'        -- MANDATORY item definition string
      ['mat']  = 'INORGANIC:IRON'  -- MANDATORY item material string
      ['quantity'] = 1             -- OPTIONAL number of items to be created. Defaults to 1, if not defined
      ['probability'] = 0.5        -- OPTIONAL The percentage chance the new item will be created. Defaults to 1.0.
                                      Values over 1.0 will be treated the same as 1.0
    }
  }  

--]]
local replacement_materials = {
    ['CV_AUSTENITE_CRYSTAL'] = {
        {
            ['item'] = 'BAR:NONE',
            ['mat']  = 'INORGANIC:CV_AUSTENITE',
        },
        {
            ['item'] = 'BAR:NONE',
            ['mat']  = 'INORGANIC:IRON',  -- placeholder
            ['quantity'] = 1,
            ['probability'] = 0.01
        },
    }
}

eventful.enableEvent(eventful.eventType.ITEM_CREATED, 1)
eventful.onItemCreated[modId] = function(item_id)
    if debug then print('cv: onItemCreated' .. 'id: ' .. item_id) end

    -- get item reference from id
    local item = df.item.find(item_id)
    -- check if material is in the list for this mod, if yes, replace
    local mat_info = dfhack.matinfo.decode(item)
    if mat_info.mode == 'plant' then
        if mat_info.material.id == "STRUCTURAL" and mat_info.plant and replacement_materials[mat_info.plant.id] then
            local key = mat_info.plant.id
            local x, y, z = dfhack.items.getPosition(item)
            for _, rep in ipairs(replacement_materials[key]) do
                if debug then print("cv:   replace item: " .. key .. ' with ' .. rep['item'] .. ',' .. rep['mat']) end
                local count = rep['quantity'] or 1
                if not rep['probability'] or (rep['probability'] < 1.0 and (math.random() - rep['probability']) < 0.0) then
                    dfhack.run_script("modtools/create-item", "-i", rep['item'], "-m", rep['mat'], "-p", x .. ',' ..  y .. ',' .. z, "-c", count)
                end
            end
            dfhack.items.remove(item)
        end
    end

end