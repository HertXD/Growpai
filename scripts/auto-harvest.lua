--AUTO HARVEST
local itemid = 4584

function Hit(x, y)
    local pkt = {
        type = 3,
        int_data = 18,
        flags = 16,
        int_x = GetLocal().pos_x // 32 + x,
        int_y = GetLocal().pos_y // 32 + y,
        pos_x = GetLocal().pos_x,
        pos_y = GetLocal().pos_y,
    }
    SendPacketRaw(pkt)
end

local function AntiMiss()
    for __, tile in pairs(GetTiles()) do
        if tile.fg == itemid then
            FindPath(tile.pos_x, tile.pos_y)
            Sleep(155)
            Hit(0, 0)
            Sleep(155)
            return true
        end
    end
    return false
end

MessageBox("Ingfo", "Auto harvest starting!")
while true do
    if not AntiMiss() then
        MessageBox("Ingfo", "Auto harvest done!")
        return
    end
end
