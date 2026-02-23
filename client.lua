-- FiveM Brake Lights Script
-- Ensures brake lights come on when vehicles are stopped (for both NPCs and players)
-- Supports vanilla and modded (add-on) vehicles via configurable class filters

-- Build a fast hash-keyed lookup table from the modded vehicle override spawn names so
-- that per-frame checks are O(1) without iterating the config table every tick.
local moddedOverrides = {}
local moddedOverrideCount = 0
for _, name in ipairs(Config.ModdedVehicleOverrides) do
    moddedOverrides[GetHashKey(name)] = true
    moddedOverrideCount = moddedOverrideCount + 1
end

-- Returns true if brake lights should be processed for this vehicle.
-- Vehicles whose class is excluded in Config.IncludedVehicleClasses are skipped unless
-- their model is listed in Config.ModdedVehicleOverrides.
local function ShouldProcessVehicle(vehicle)
    local class = GetVehicleClass(vehicle)
    if Config.IncludedVehicleClasses[class] then
        return true
    end
    -- Always include vehicles explicitly listed in ModdedVehicleOverrides
    return moddedOverrides[GetEntityModel(vehicle)] == true
end

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
                if (dx * dx + dy * dy + dz * dz) > (Config.NearbyRadius * Config.NearbyRadius) then
                    goto next_vehicle
                end

                -- Skip vehicle classes that don't have road-going brake lights (boats, planes, etc.)
                if not ShouldProcessVehicle(vehicle) then goto next_vehicle end

                local driver = GetPedInVehicleSeat(vehicle, -1)
                if driver == 0 or not DoesEntityExist(driver) then goto next_vehicle end

                local speed = GetEntitySpeed(vehicle)
                if speed <= Config.BrakeLightSpeedThreshold then
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
        print(string.format('^2[Brake Lights]^7 Speed threshold: %.1f m/s | Radius: %.0f m | Modded overrides: %d',
            Config.BrakeLightSpeedThreshold, Config.NearbyRadius, moddedOverrideCount))
    end
end)
