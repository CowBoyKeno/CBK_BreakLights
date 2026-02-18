# FiveM Brake Lights

Automatic brake lights for stopped vehicles - works for both player and NPC-driven vehicles.

## Description

This standalone FiveM script ensures that brake lights automatically turn on when vehicles come to a stop, regardless of whether they are being driven by a player or an NPC. This creates more realistic lighting behavior and improves visual feedback in your FiveM server.

## Features

- ✅ Automatic brake light activation when vehicles are stopped
- ✅ Works for player-driven vehicles
- ✅ Works for NPC-driven vehicles
- ✅ Lightweight and optimized
- ✅ Standalone resource (no dependencies)
- ✅ Easy to install

## Installation

1. Download or clone this repository
2. Copy the `FiveM_Brake_lights` folder to your FiveM server's `resources` directory
3. Add `ensure FiveM_Brake_lights` to your `server.cfg` file
4. Restart your server or start the resource using `start FiveM_Brake_lights`

## Configuration

The script includes a configurable speed threshold that determines when brake lights should activate. By default, brake lights will turn on when a vehicle's speed is below 0.5 m/s.

You can modify this threshold in `client.lua`:
```lua
local BRAKE_LIGHT_SPEED_THRESHOLD = 0.5 -- Speed threshold in m/s
```

## How It Works

The script continuously monitors all vehicles in the game world and:
1. Checks if each vehicle has a driver (player or NPC)
2. Measures the vehicle's current speed
3. Activates brake lights when the speed falls below the threshold
4. Deactivates brake lights when the vehicle is moving above the threshold

## Requirements

- FiveM server

## License

See [LICENSE](LICENSE) file for details.

## Support

If you encounter any issues or have suggestions, please open an issue on the GitHub repository.
