Config = {}

-- Speed threshold in m/s; vehicles at or below this speed will have brake lights activated
Config.BrakeLightSpeedThreshold = 0.5

-- Radius in metres around the player within which vehicles are processed (performance tuning)
Config.NearbyRadius = 80.0

-- Vehicle classes to process. Set a class to false to exclude it.
-- Vehicles that have no road-going brake lights (boats, helicopters, planes, trains) are
-- disabled by default so they are never processed unnecessarily.
--
-- GTA5 / FiveM vehicle class IDs:
--   0  = Compacts        8  = Motorcycles    16 = Planes
--   1  = Sedans          9  = Off-road       17 = Service
--   2  = SUVs           10  = Industrial     18 = Emergency
--   3  = Coupes         11  = Utility        19 = Military
--   4  = Muscle         12  = Vans           20 = Commercial
--   5  = Sports Classic 13  = Cycles         21 = Trains
--   6  = Sports         14  = Boats          22 = Open Wheel
--   7  = Super          15  = Helicopters
Config.IncludedVehicleClasses = {
    [0]  = true,  -- Compacts
    [1]  = true,  -- Sedans
    [2]  = true,  -- SUVs
    [3]  = true,  -- Coupes
    [4]  = true,  -- Muscle
    [5]  = true,  -- Sports Classics
    [6]  = true,  -- Sports
    [7]  = true,  -- Super
    [8]  = true,  -- Motorcycles
    [9]  = true,  -- Off-road
    [10] = true,  -- Industrial
    [11] = true,  -- Utility
    [12] = true,  -- Vans
    [13] = false, -- Cycles (bicycles – no brake lights)
    [14] = false, -- Boats
    [15] = false, -- Helicopters
    [16] = false, -- Planes
    [17] = true,  -- Service
    [18] = true,  -- Emergency
    [19] = true,  -- Military
    [20] = true,  -- Commercial
    [21] = false, -- Trains
    [22] = true,  -- Open Wheel
}

-- Modded (add-on) vehicle spawn names to always include, even if their reported vehicle class
-- is in the excluded list above. Add the spawn name (model name) of each modded vehicle.
-- Example: Config.ModdedVehicleOverrides = { 'myvehicle', 'anothervehicle' }
Config.ModdedVehicleOverrides = {}
