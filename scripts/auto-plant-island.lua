ItemId = 5640

function place(id,x, y)
    local pkt = {}
    pkt.type = 3
    pkt.int_data = id
    pkt.pos_x = GetLocal().pos_x
    pkt.pos_y = GetLocal().pos_y 
    pkt.int_x = math.floor(GetLocal().pos_x // 32 + x)
    pkt.int_y = math.floor(GetLocal().pos_y // 32 + y)
    pkt.flags = 2560
    SendPacketRaw(pkt)
    Sleep(40)
end

for y=0,199 do
    for x=0,199 do
        if GetTile(x,y).fg == 0 and GetTile(x,y+1) ~= 0 then
        FindPath(x,y)
        Sleep(200)
        place(ItemId,0,0)
        Sleep(55)
        place(ItemId,0,1)
        Sleep(50)
        place(ItemId,0,2)
        Sleep(250)
        end
    end
end
