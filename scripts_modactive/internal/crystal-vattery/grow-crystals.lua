--@module = true


local eventful = require("plugins.eventful")
local modId = "crystal-vattery"

local debug = true
if debug then print('cv grow-crystals') end


-- create hook, like, monthly
    -- get all obelisk buildings
      -- check building materials for type, which crystal heart
    -- for each obelisk, create overlay
      --  for each tile, check conditions
        -- magma, underground
        -- if conditions met, add counter up
        -- count makes crystals older = bigger and more yield

