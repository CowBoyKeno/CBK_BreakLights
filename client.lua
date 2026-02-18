-- FiveM Brake Lights Script
-- Ensures brake lights come on when vehicles are stopped (for both NPCs and players)

local BRAKE_LIGHT_SPEED_THRESHOLD = 0.5 -- Speed threshold in m/s to consider vehicle as stopped

-- Function to activate brake lights on a vehicle
local function SetBrakeLights(vehicle, state)
    if DoesEntityExist(vehicle) then
        SetVehicleBrakeLights(vehicle, state)
    end
end

-- Main thread to handle brake lights for all vehicles
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100) -- Check every 100ms for better performance
        
        -- Get all vehicles in the game world
        local vehicles = GetGamePool('CVehicle')
        
        for _, vehicle in ipairs(vehicles) do
            if DoesEntityExist(vehicle) then
                -- Check if vehicle has a driver (player or NPC)
                local driver = GetPedInVehicleSeat(vehicle, -1)
                
                if driver ~= 0 and DoesEntityExist(driver) then
                    -- Get vehicle speed
                    local speed = GetEntitySpeed(vehicle)
                    
                    -- Activate brake lights if vehicle is stopped or nearly stopped
                    -- Only activate, don't deactivate to allow normal brake behavior
                    if speed <= BRAKE_LIGHT_SPEED_THRESHOLD then
                        SetBrakeLights(vehicle, true)
                    end
                end
            end
        end
    end
end)

-- Information print on resource start
AddEventHandler('onClientResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        print('^2[Brake Lights]^7 Script started successfully!')
        print('^2[Brake Lights]^7 Brake lights will automatically turn on for stopped vehicles.')
    end
end)
