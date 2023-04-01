# Functions
* [SendPacket](#sendpacket)
* [SendPacketRaw](#sendpacketraw)
* [SendPacketRawClient](#sendpacketrawclient)
* [SendVarlist](#sendvarlist)
* [log](#log)
* [FindPath](#findpath)
* [GetLocal](#getlocal)
* [GetInventory](#getinventory)
* [GetPlayers](#getplayers)
* [GetObjects](#getobjects)
* [GetTile](#gettile)
* [GetTiles](#gettiles)
* [GetPing](#getping)
* [AddCallback](#addcallback)
* [RunThread](#runthread)
* [Sleep](#sleep)
* [GetAccesslist](#getaccesslist)
* [GetGhost](#getghost)
* [MessageBox](#messagebox)
* [RemoveCallbacks](#removecallbacks)
* [RemoveCallback](#removecallback)
* [Timer](#timer)
* [IsSolid](#issolid)
* [SendWebhook](#sendwebhook)
* [CheckPath](#checkpath)
* [EditToggle](#edittoggle)
* [GetItemCount](#getitemcount)
* [GetIteminfo](#GetIteminfo)


## SendPacket
`SendPacket(int type, string packet)`

Sends text packet with selected type to server.

Example:
```lua
-- Sends respawn packet to server
SendPacket(2, "action|respawn")
```

## SendPacketRaw
`SendPacketRaw(GamePacket packet)`

Sends [GamePacket](#gamepacket) to server.

Example:
```lua
-- Sends wear clothing packet to server
local packet = {}
packet.type = 10 
packet.int_data = 48 -- Clothing ID (Jeans)
SendPacketRaw(packet)
```

## SendPacketRawClient
`SendPacketRawClient(GamePacket packet)`

Sends [GamePacket](#gamepacket) to client.

Example:
```lua
-- Sends packet_state flag to client
local packet = {}
packet.type = 0 
packet.flags = 48 -- flags
SendPacketRaw(packet)
```

## SendVarlist
`SendVarlist(table varlist)`

Example:
```lua
local var = {} --make table
var[0] = "OnConsoleMessage"
var[1] = "Dababy!"
var.netid = -1 --need to put netid or it doesn't work

SendVarlist(var)
```

## log
`log(string message)`

Logs message to Growtopias console (only client side)

Example:
```lua
-- Logs "Hello!" to Growtopias console
log("Hello!")
```

## FindPath
`FindPath(int x, int y)`

Finds path to selected x,y

Example:
```lua
-- Finds path to top left corner of the world
FindPath(0, 0)
```

## GetLocal
`GetLocal()`

Returns local [NetAvatar](##netavatar) struct

Example:
```lua
-- Logs local players name
local me = GetLocal()
log(me.name)

--changing name
local Player = GetLocal()
Player.name = "`wkontol``"
```

## GetInventory
`GetInventory()`

Returns table of [InventoryItems](#inventoryitem)

Example:
```lua
-- Logs all item ids in your inventory
for _,cur in pairs(GetInventory()) do
	log(cur.id)
end
```

## GetPlayers
`GetPlayers()`

Returns table of [NetAvatars](#netavatar)

Example:
```lua
-- Logs current worlds players names
for _,player in pairs(GetPlayers()) do
	log(player.name)
end
```

## getObjects
`GetObjects()`

Returns table of [WorldObjects](#worldobject)

Example:
```lua
-- Logs current worlds objects item id's
for _,object in pairs(GetObjects()) do
	log(object.id)
end
```

## GetTile
`GetTile(int x, int y)`

Returns world [Tile](#tile) in selected position

Example:
```lua
-- Logs top left corners foreground block id
local tile = GetTile(0, 0)
log(tile.fg)
```

## GetTiles
`GetTiles()`

Returns table of [Tiles](S#tile)

Example:
```lua
-- Logs current worlds all foreground block id's
for _,tile in pairs(GetTiles()) do
	log(tile.fg)
end
```

## RunThread
`RunThread(function)`
Run a function in a different thread

Example
```lua
RunThread(function()
	log("Hello")
	Sleep(1000)
	log("World!")
end)
```

## Sleep
`Sleep(int ms)`
put a delay inside a [Thread](#runthread)

Example:
```lua
local function wow(a, b)
	log(a)
	Sleep(1000)
	log(b)
end
RunThread(function()
	wow("Hello", "World")
end)
```

## AddCallback
`AddCallback(string name, void* function)`
Add a callback Hook to a selected function

Example:
```lua
-- Blocks all dialogs
function hook(varlist, packet)
	if varlist[0]:find("OnDialogRequest") then
		return true
	end
end

AddCallback("Hook", "OnVarlist", hook)

-- Blocks your chat
function hook(type, packet)
	if packet:find("actiont|input\n|text") then
		return true
	end
end

AddCallback("Hook", "OnPacket", hook)

-- Blocks your packet_state
function hook(packet)
	if packet.type == 0 then
		return true
	end
end

AddCallback("Hook", "OnRawPacket", hook)

-- Blocks people packet_state
function hook(packet)
	if packet.type == 0 then
		return true
	end
end

AddCallback("Hook", "OnIncomingRawPacket", hook)

----------------------------------------
-- Override your packet_state
function hook(packet)
	if packet.type == 0 then
		packet.flags = 0 --remove all localplayer state flags
	end
end

AddCallback("Hook", "OnRawPacket", hook)

-- Override people packet_state
function hook(packet)
	if packet.type == 0 then
		packet.flags = 0 --remove all people state flags
	end
end

AddCallback("Hook", "OnIncomingRawPacket", hook)

--Update timer
AddCallback("timer", "OnUpdate", function(deltatime)
	timer.update(deltatime)
end)
```

## GetPing
`GetPing()`
Get ping ms from your peer

Example:
```lua
log("My ping is : "..tostring(GetPing()))
```

## GetAccesslist
`GetAccesslist(int x, int y)`
Get lock's access userid list

Example:
```lua
for __,v in pairs(GetAccesslist(0,0)) do
	log(v.uid)
end
```


## GetGhost
`GetGhost()`
Get all ghost npc id and pos

Example:
```lua
for __,v in pairs(GetGhost()) do
	log(string.format("%d : %d, %d",v.id, v.pos_x, v.pos_y))
end
```

## MessageBox
`MessageBox(string title, string content)`
Send a messagebox to your client!

Example:
```lua
MessageBox("This is title", "This is content")
```

## RemoveCallbacks
`RemoveCallbacks()`
Remove all callbacks

## RemoveCallback
`RemoveCallback(string name)`
Remove spesific name on callback

Example:
```lua
function hook(varlist, packet)
	if varlist[0]:find("OnDialogRequest") then
		return true
	end
end
AddCallback("Hook", "OnVarlist", hook)

RemoveCallback("Hook") --remove that callback
```

## Timer
Timer library by https://github.com/EntranceJew/timer
the docs: https://wiki.facepunch.com/gmod/timer

Example:
```lua
--Create a timer update callback
AddCallback("timer", "OnUpdate", function(deltatime)
	timer.update(deltatime)
end)

timer.Create("timer name", 5, 0, function()
	print("me nem kontol")
	--this will print in 5 second
end)

timer.Destroy("timer name")-- destroy timer
```

## IsSolid
`IsSolid(int x, int y)`
Check if the block is solid or no

## SendWebhook
`SendWebhook(string webhook, string json)`

Example:
```lua
local payload = [[{
    "content": "",
    "embeds": [{
        "title": "ytta",
        "description": "ytta :flushed:",
        "url": "https://avatarfiles.alphacoders.com/334/334449.png",
        "color": 5814783,
        "fields": [{
            "name": "Introduction",
            "value": "My name is Walter Hartwell White. I live at 308 Negra Arroyo Lane Albuquerque New Mexico 87104. This is my confession."
        }],
        "author": {
            "name": "kontol",
            "url": "https://avatarfiles.alphacoders.com/334/334449.png",
            "icon_url": "https://avatarfiles.alphacoders.com/334/334449.png"
        },
        "footer": {
            "text": "sended from growpai",
            "icon_url": "https://copypastatext.com/wp-content/uploads/2021/12/index-14.jpg"
        },
        "timestamp": "2023-02-14T17:00:00.000Z"
    }]
}]]
local webhook = ""
SendWebhook(webhook, payload)
```


## CheckPath
`CheckPath(int x, int y)`

Example:
```lua
	CheckPath(0, 0) -- return bool (true == found path)
```

## EditToggle
`EditToggle(string module, bool toggle)`

Example:
```lua
	EditToggle("antibounce", true)-- active antibounce
```
## Module list:
* MenuToggle
* Execute Luascript
* Stop Luascript
* Antiportal
* ModFly
* Autocollect
* Antibounce

## GetItemCount
`GetItemCount(int id)`

Example:
```lua
log(GetItemCount(2))--return dirt count 
```
## GetIteminfo
`GetIteminfo(int id)`

Returns table of [ItemInfo](#ItemInfo)

Example:
```lua
log(GetIteminfo(2).name)--return name of id block 2
```


# Structs

* [NetAvatar](#netavatar)
* [WorldObject](#worldobject)
* [InventoryItem](#inventoryitem)
* [Tile](#tile)
* [GamePacket](#gamepacket)
* [VariantList](#variantlist)
* [ItemInfo](#iteminfo)

## NetAvatar
| Type | Name | Description|
|:-----|:----:|:-----------|
| String | `name` | Player's name |
| String | `world` | Player's world(only local) |
| String | `country` | Player's flag id |
| Number | `pos_x`  | Player's x position |
| Number | `pos_y`  | Player's y position |
| Number | `tile_x` | Player's x tile position |
| Number | `tile_y` | Player's y tile position |
| Number | `size_x` | Player's x size |
| Number | `size_y` | Player's x size |
| Number | `netid` | Player's netID |
| Number | `userid` | Player's userID |
| Number | `gems` | Player's gems |
| Bool | `facing_left` | Is player facing left |
| Number | `flags` | Player's flags |
| Number | `flags2` | Player's flags2 |

## WorldObject
| Type | Name | Description|
|:-----|:----:|:-----------|
| Number | `id` | Object's item ID |
| Number | `oid` | Object's index |
| Number | `pos_x` | Object's x position |
| Number | `pos_y` | Object's y position |
| Number | `count` | Object's item count |
| Number | `flags` | Object's flags |

## InventoryItem
| Type | Name | Description|
|:-----|:----:|:-----------|
| Number | `id` | Item's ID |
| Number | `count` | Item count |

## Tile
| Type | Name | Description|
|:-----|:----:|:-----------|
| Number | `fg` | Foreground block's ID |
| Number | `bg` | Background block's ID |
| Number | `pos_x` |Tile's x position |
| Number | `pos_y` |Tile's y position |
| Number | `flags` | Tile's flags |
| bool | `water` | Tile's water |
| bool | `fire` | Tile's fire |
| bool | `ready` | Tile's ready to harvest |

## GamePacket
| Type | Name | Description|
|:-----|:----:|:-----------|
| Number | `type` | Packet type |
| Number | ` objtype` |  |
| Number | `count1 ` |  |
| Number | `count2 ` |  |
| Number | `netid ` | Packet netID |
| Number | `item ` |  |
| Number | `flags ` | Packet flags |
| Number | `float1` |  |
| Number | `int_data` |  |
| Number | `pos_x` |  |
| Number | `pos_y` |  |
| Number | `pos2_x` |  |
| Number | `pos2_y` |  |
| Number | `float2` |  |
| Number | `int_x` |  |
| Number | `int_y` |  |

## VariantList
| Type | Name | Description|
|:-----|:----:|:-----------|
| Number | `netid` | NetID |
| Number | `delay` | Delay |
| String | `[0]` | Variant function name |
| Any | `[1]` | Param 1 |
| Any | `[2]` | Param 2 |
| Any | `[3]` | Param 3 |
| Any | `[4]` | Param 4 |
| Any | `[5]` | Param 5 |

## ItemInfo
| Type | Name | Description|
|:-----|:----:|:-----------|
| String | `name` | item's name |
| Number | `item_type` | Item's type |
| Number | `growth` | Item's growth |
| Number | `rarity` | Item's rarity |
| Number | `size` | Items list size |
