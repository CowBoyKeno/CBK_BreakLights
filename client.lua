-- FiveM Brake Lights Script
-- Ensures brake lights come on when vehicles are stopped (for both NPCs and players)

local BRAKE_LIGHT_SPEED_THRESHOLD = 0.5 -- Speed threshold in m/s to consider vehicle as stopped
local NEARBY_RADIUS = 80.0 -- Only process vehicles within this many metres of the player (performance)

-- Function to activate brake lights on a vehicle
local function SetBrakeLights(vehicle, state)
    if DoesEntityExist(vehicle) then
        SetVehicleBrakeLights(vehicle, state)
    end
end

-- Main thread: apply brake light state every frame for stopped vehicles so the game doesn't override it
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0) -- Run every frame so we continuously hold brake lights on (prevents flicker)

        local playerPed = PlayerPedId()
        if not DoesEntityExist(playerPed) then goto continue end

        local playerCoords = GetEntityCoords(playerPed)
        local vehicles = GetGamePool('CVehicle')

        for _, vehicle in ipairs(vehicles) do
            if DoesEntityExist(vehicle) then
                -- Only process vehicles near the player
                local vehCoords = GetEntityCoords(vehicle)
                local dx = vehCoords.x - playerCoords.x
                local dy = vehCoords.y - playerCoords.y
                local dz = vehCoords.z - playerCoords.z
                if (dx * dx + dy * dy + dz * dz) > (NEARBY_RADIUS * NEARBY_RADIUS) then
                    goto next_vehicle
                end

                local driver = GetPedInVehicleSeat(vehicle, -1)
                if driver == 0 or not DoesEntityExist(driver) then goto next_vehicle end

                local speed = GetEntitySpeed(vehicle)
                if speed <= BRAKE_LIGHT_SPEED_THRESHOLD then
                    SetBrakeLights(vehicle, true)
                end

                ::next_vehicle::
            end
        end

        ::continue::
    end
end)

-- Information print on resource start
AddEventHandler('onClientResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        print('^2[Brake Lights]^7 Script started successfully!')
        print('^2[Brake Lights]^7 Brake lights will automatically turn on for stopped vehicles.')
    end
end)
