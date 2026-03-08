# FiveM Brake Lights

Automatic brake lights for stopped vehicles - works for both player and NPC-driven vehicles, including modded (add-on) vehicles.

## Description

This standalone FiveM script ensures that brake lights automatically turn on when vehicles come to a stop, regardless of whether they are being driven by a player or an NPC. This creates more realistic lighting behaviour and improves visual feedback on your FiveM server.

Modded and add-on vehicles are fully supported. The script filters by vehicle class so that non-road vehicles (boats, helicopters, planes, trains) are skipped by default, and a per-model override list lets you force-include any modded vehicle regardless of its reported class.

## Features

- ✅ Automatic brake light activation when vehicles are stopped
- ✅ Works for player-driven vehicles
- ✅ Works for NPC-driven vehicles
- ✅ Works for modded / add-on vehicles
- ✅ Vehicle class filtering (boats, helicopters, planes, trains excluded by default)
- ✅ Per-model override list for modded vehicles with non-standard classes
- ✅ Lightweight and optimized
- ✅ Standalone resource (no dependencies)
- ✅ Easy to install

## Installation

1. Download or clone this repository
2. Copy the `CBK_BreakLights` folder to your FiveM server's `resources` directory
3. Add `ensure CBK_BreakLights` to your `server.cfg` file
4. Restart your server or start the resource using `start CBK_BreakLights`

## Configuration

All configuration lives in `config.lua`.

### Speed threshold

Brake lights activate when a vehicle's speed falls at or below this value (in m/s).

```lua
Config.BrakeLightSpeedThreshold = 0.5
```

### Nearby radius

Only vehicles within this distance (in metres) of the local player are processed, keeping CPU usage low.

```lua
Config.NearbyRadius = 80.0
```

### Vehicle class filters

Controls which GTA5/FiveM vehicle classes are processed. Set a class to `false` to skip it entirely.

```lua
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
```

### Modded vehicle overrides

If a modded (add-on) vehicle reports an unexpected vehicle class that would otherwise cause it to be skipped, add its spawn name here. The model will always be processed regardless of its class.

```lua
Config.ModdedVehicleOverrides = { 'myvehicle', 'anothervehicle' }
```

## How It Works

The script continuously monitors all vehicles in the game world and:
1. Skips vehicles outside the configured nearby radius (performance)
2. Skips vehicle classes that don't have road-going brake lights (boats, planes, helicopters, trains) — unless the model is listed in `ModdedVehicleOverrides`
3. Checks if each vehicle has a driver (player or NPC)
4. Measures the vehicle's current speed
5. Activates brake lights when the speed falls at or below the threshold

## Requirements

- FiveM server

## License

See [LICENSE](LICENSE) file for details.

## Support

If you encounter any issues or have suggestions, please open an issue on the GitHub repository.
