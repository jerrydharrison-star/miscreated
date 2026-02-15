# Miscreated Server Configuration Guide (Version 3.2)

## GitHub Repository
**URL**: [https://github.com/jerrydharrison-star/miscreated](https://github.com/jerrydharrison-star/miscreated)

## Goal
Successfully configure and launch a Miscreated dedicated server with proper Steam Authentication and network connectivity.

## Critical Fixes Applied

### 1. Configuration Location
**Problem**: Server was ignoring `hosting.cfg` settings.
**Solution**: Moved `hosting.cfg` from root to `Bin64_dedicated/` directory where the server actually reads it.

### 2. Steam AppID Standardization
**Problem**: Mismatched AppIDs causing Steam Auth failures.
**Solution**: Updated both `steam_appid.txt` files (root and `Bin64_dedicated/`) to `299740` (Miscreated Game AppID).

### 3. Port Configuration
**Problem**: Manual port assignments (`sv_steamport`, `sv_queryport`) were causing binding conflicts.
**Solution**: Removed manual port overrides and let the engine auto-assign ports sequentially from base port 64090.

### 4. IP Binding Issue
**Problem**: Added `-sv_bind 192.168.0.228` parameter which blocked connections by limiting server to specific IP.
**Solution**: Removed `-sv_bind` parameter to allow server to listen on all interfaces (`0.0.0.0`).

## Final Working Configuration

### Port Binding (Verified via netstat)
- **64090** (UDP): Game Port
- **64092** (UDP): Query Port  
- **64093** (UDP): VoIP Port
- All bound to `0.0.0.0` (all network interfaces)

### Key Files

#### `Bin64_dedicated/hosting.cfg`
```ini
sv_servername="wafflehome"
sv_maxplayers=5
sv_password="waffle"
sv_region=0
sv_port=64090
sv_steamaccount=<HIDDEN>
g_pinglimit=0
g_pingLimitTimer=999999
http_startserver=1
http_password="waffle"
mis_gameserverid=1
;steam_ugc=... (commented out for vanilla server)
map islands
```

#### `Bin64_dedicated/start_server.bat`
```batch
start /affinity F /wait MiscreatedServer.exe -dedicated -sv_port 64090 -sv_steamaccount <HIDDEN> +map islands
```

#### `Bin64_dedicated/steam_appid.txt`
```
299740
```

## Connection Instructions

### Local Network
```
+connect 192.168.0.228:64090 +sv_password waffle
```

### Public/Internet
```
+connect 24.237.168.175:64090 +sv_password waffle
```

### Via Steam Favorites
Server appears as "wafflehome" after 15-30 minutes of propagation.

## Verification Results

✅ Server starts successfully with 18 high-quality mods
✅ Final UGC CRC calculated and enforced (`4095867549`)
✅ NodeTypeID limit resolved by removing high-complexity mods
✅ Environmental Customization: 2x Day, 0.5x Night
✅ Loot Customization: 1.5x Density and Max Items
✅ Quality of Life: Halved Hunger and Thirst decay rates
✅ Client connection verified successful (no kicks)

## Final Mod Configuration (v3.0)
The server is running a curated list of 18 mods, documented in [MOD_LIST.md](file:///c:/Games/MiscreatedServer/MOD_LIST.md). The `Ultra Vehicle Pack` was removed to maintain engine stability.

**Commit (v1.0)**: Initialized v1.0 configuration (Vanilla)
**Commit (v2.0)**: `485cbef` - Modded Stable (18 mods)
**Commit (v3.0)**: `2e8e644` - Perfect Morning and Instant Respawn
**Commit (v3.1)**: `57ac5d5` - Full server config directory sync
**Commit (v3.2)**: `7a71a67` - Redacted sensitive Steam tokens

**Tracked Files on GitHub**:
- `hosting.cfg` (Main configuration)
- `system.cfg` (Engine startup settings)
- `MOD_LIST.md` (Curated list of 18 mods)
- `Bin64_dedicated/start_server.bat` (Server launch script)
- `Bin64_dedicated/steam_appid.txt` (AppID 299740)

## Next Steps: Adding Mods

Automatic `steam_ugc` downloads are not working on this server version. To add mods:

1. **Subscribe** to mods on your PC via Steam Workshop
2. **Locate** mod files: `C:\Program Files (x86)\Steam\steamapps\workshop\content\299740\`
3. **Copy** numbered folders (e.g., `2444612166`) to server's `c:\Games\MiscreatedServer\Mods\`
4. **Uncomment** `steam_ugc` line in `hosting.cfg`
5. **Restart** server
6. **Commit** as v2.0 with mods enabled

## Common Issues

### "Yellow Warnings" in Logs
Lines like `[Warning] Vegetation object... has no render mesh` are **completely normal**. The dedicated server skips rendering vegetation to save resources.

### Connection Failures
- Ensure client uses correct connect string: `+connect IP:64090 +sv_password waffle`
- Verify server is listening on `0.0.0.0` (not specific IP)
- Check firewall rules allow UDP ports 64090-64094
- Restart Miscreated client to clear cached server data
