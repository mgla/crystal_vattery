--@module = true
--@enable = true

print('cw main')

local eventful = require("plugins.eventful")
local modId = "crystal-vattery"

-- From https://github.com/DFHack/dfhack/blob/develop/plugins/lua/eventful.lua#L152C11-L152C22
eventful.enableEvent(eventful.eventType.ITEM_CREATED, 1)

eventful.onItemCreated[modId] = function(item_id)
    print('cw onItemCreated')
    print(item_id)
end

-- mod enables itself
function isEnabled()
    return true
end



-- enableEvent(evType,frequency)

-- Enable event checking for EventManager events. For event types use eventType table.
-- Note that different types of events require different frequencies to be effective.
-- The frequency is how many ticks EventManager will wait before checking if that type of event has happened.
-- If multiple scripts or plugins use the same event type, the smallest frequency is the one that is used, so you might get events triggered more often than the frequency you use here.
