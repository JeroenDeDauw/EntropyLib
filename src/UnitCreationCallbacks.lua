-- Service that allows for executing code upon all unit creation.
-- Warning: when an unit is captured it will be detected as a new unit
-- Forum thread: https://forums.faforever.com/viewtopic.php?f=53&t=16598
function newInstance(ScenarioInfo)
    local callbacks = {}
    local knownEntityIds = {}

    local function runCallbacks(unit)
        for _, callback in callbacks do
            callback(unit)
        end
    end

    local getAllUnits = function()
        return GetUnitsInRect({x0 = 0, x1 = ScenarioInfo.size[1], y0 = 0, y1 = ScenarioInfo.size[2]})
    end

    local function findNewUnits()
        for _, unit in getAllUnits() do
            if unit and not unit:IsBeingBuilt() and not unit:IsDead()and not knownEntityIds[unit:GetEntityId()] then
                knownEntityIds[unit:GetEntityId()] = true

                if unit.originalBuilder ~= nil then
                    runCallbacks(unit)
                end
            end
        end
    end

    local function cleanDeadEntityIds()
        local cleanedKnownEntityIds = {}

        for entityId in knownEntityIds do
            if GetEntityById(entityId) then
                cleanedKnownEntityIds[entityId] = true
            end
        end

        knownEntityIds = cleanedKnownEntityIds
    end

    ForkThread(function()
        while true do
            for i = 1, 50  do
                findNewUnits()
                WaitTicks(1)
            end

            cleanDeadEntityIds()
        end
    end)

    return {
        -- Add a callback function that gets called whenever a unit is created. It is called with the unit.
        addCallback = function(callback)
            table.insert(callbacks, callback)
        end
    }
end

--                    local keyset={}
--                    for k in pairs(unit.originalBuilder) do
--                        table.insert(keyset, k)
--                    end
--                    LOG(repr(keyset))
