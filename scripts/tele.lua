local clotheslist = {2636, 48} --put ur clothes id lmao


local istelerunning = false;
local function WearClothes(id)
	local pkt = {
		type = 10,
		int_data = id,
	}
	SendPacketRaw(pkt)
end

local function FakeRes()
	local pkt = {
		type = 0,
		flags = 2356,
		pos_x = GetLocal().pos_x,
		pos_y = GetLocal().pos_y
	}
	SendPacketRaw(pkt)
end

local function DoTele()
	istelerunning = true;
	FakeRes()
	Sleep(150)
	for __, id in pairs(clotheslist) do
		WearClothes(id)
		Sleep(230)
	end
	Sleep(250) -- for baris nub, change this if u want accept request delay
	SendPacket(2, ("action|wrench\n|netid|%d"):format(GetLocal().netid));
end

local function HookChat(type, packet)
	if(type == 2 and packet:find("!tele")) then
		RunThread(DoTele)
		return true
	end
	return false
end
local function HookDialog(v, packet)
	if(v[0] == "OnDialogRequest" and istelerunning) then
		if v[1]:find("acceptguildinvite") then
			SendPacket(2, ("action|dialog_return\ndialog_name|popup\nnetID|%d|\nguildid|%d|\nbuttonClicked|acceptguildinvite"):format(
				v[1]:match("embed_data|netID|(%d+)"),
				v[1]:match("embed_data|guildid|(%d+)")
			))
			istelerunning = false
			return true
		end
	end
	return false
end
AddCallback("Kontol", "OnVarlist", HookDialog)
AddCallback("Kontol1", "OnPacket", HookChat)
