--SPAM ALL ROULETTE (EZ TROLL CASINO)
local function Hit(x, y)
    local p = {}
    p.type = 3
    p.int_data = 3704
    p.int_x = x
    p.int_y = y
    p.pos_x = GetLocal().pos_x
    p.pos_y = GetLocal().pos_y
    SendPacketRaw(p)
end
local nocrash = {};
for i, v in pairs(GetTiles()) do
    if v.fg == 758 then
        table.insert(nocrash, {x = v.pos_x, y = v.pos_y})
    end
end
local d = function()
    for __, pos in pairs(nocrash) do
        Hit(pos.x, pos.y)
        Sleep(200)
        if GetLocal().name == "NULL" then return end
    end
end
RunThread(function()
    d()
end)
