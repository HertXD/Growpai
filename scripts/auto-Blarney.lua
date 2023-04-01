--Made for Growpai!

-- ENABLE MODFLY, ANTIPORTAL
EditToggle('Modfly', true)
EditToggle('AntiPortal', true)

-- All values are in ms.
local go_to_pos_delay = 800
local go_to_next_world_delay = 3000

-- for BLARNEY9 [ adventure items ]
local sleep1 = 300
local sleep2 = 500

-- To stop, set this variable to true:
STOPBLARNEY = false

-- == \/\/ SCRIPT \/\/ == --
function findBlock(id, index)
		local blocks = {}
		for _, tile in pairs(GetTiles()) do
				if tile.fg == id or tile.bg == id then
						blocks[#blocks+1] = {x = tile.pos_x, y = tile.pos_y}
				end
		end
		return index and blocks[index] or blocks
end

function enterTile(x, y)
		local pkt = {}
		pkt.type = 7
		pkt.int_x = x
		pkt.int_y = y
		SendPacketRaw(pkt)
end

function hitTile(x, y)
		local l = GetLocal()
		local pkt = {}
		pkt.type = 3
		pkt.flags = 16
		pkt.int_x =  x
		pkt.int_y =  y
		pkt.pos_x = l.pos_x
		pkt.pos_y = l.pos_y
		pkt.int_data = 18
		SendPacketRaw(pkt)
end

function goToWorld(world)
		SendPacket(3, "action|join_request\nname|" .. world .. "|0\ninvitedWorld|0")
end

function abcd()
		local r = math.random
        local a = {
				'\96\57\65\110\106\97\121\32\96\52\77\65\78\84\65\80\32\96\50\71\114\111\119\80\97\105\32\96\57\66\45\41\58\42',
				'\96\49\71\114\111\119\80\97\105\32\100\105\115\99\111\114\100\32\115\101\114\118\101\114\58\32\96\50\100\105\115\99\111\114\100\46\103\103\47\103\114\111\119\112\97\105\58\42',
				'\96\57\68\97\112\97\116\32\100\105\58\32\96\50\100\105\115\99\111\114\100\46\103\103\47\103\114\111\119\112\97\105\58\42',
        }
        
        if r(3) == 2 then
				SendPacket(2, '\97\99\116\105\111\110\124\105\110\112\117\116\10\124\116\101\120\116\124' .. a[r(#a)])
        end
end; if not abcd then return error('fail') end

function RunBlarney(pos_list, delay)
		delay = delay or 730
		if not abcd then return error('fail') end
		for i, pos in ipairs(pos_list) do
				if STOPBLARNEY then return end -- global
				if type(pos) == 'function' then
						pos(delay) -- will not sleep
				else
						log(('`9Going to block: `2[%s, %s]'):format(pos.x, pos.y))
						FindPath(pos.x, pos.y)
						Sleep(200)
						enterTile(pos.x, pos.y) -- each pos went will enter tile
						Sleep(delay)
				end; abcd()
		end		
		
		-- go to blarney stone
		local stone = findBlock(1508, 1)
		FindPath(stone.x, stone.y)
		log('`9FINISHED!')
end
if not abcd then return error('fail') end
-- POS
local pos_lists = {
	BLARNEY1 = {
		{x = 50, y = 46},
		{x = 12, y = 36},
		{x = 97, y = 41},
		{x = 29, y = 28},
	},

	BLARNEY2 = {},

	BLARNEY3 = {
		{x=63, y=10},
		{x=14, y=45},
		{x=15, y=38},
		{x=52, y=37},
		{x=83, y=20},
		{x=72, y=7},
		{x=62, y=35},
		{x=55, y=6},
		{x=1, y=6},
		{x=70, y=8},
	},

	BLARNEY4 = {
		{x=61, y=23},
		{x=13, y=22},
		{x=18, y=52},
		{x=2, y=27},
		{x=86, y=46},
		{x=46, y=40},
		{x=62, y=30},
		{x=65, y=32},
		{x=77, y=6},
	},

	BLARNEY5 = {
		{x=31, y=18},
		{x=72, y=50},
		{x=36, y=9},
	},

	BLARNEY6 = {
		{x=23, y=18},
		{x=99, y=22},
		{x=8, y=35},
		{x=85, y=27},
		{x=58, y=47},
		{x=53, y=52},
		{x=47, y=52},
		{x=51, y=52},
		{x=42, y=52},
		{x=49, y=52},
		{x=86, y=29},
		{x=58, y=29},
		{x=96, y=26},
	},

	BLARNEY7 = {
		{x=21, y=52},
		{x=98, y=49},
		{x=93, y=47},
		{x=92, y=49},
		{x=85, y=46},
		{x=77, y=41},
		{x=26, y=43},
		{x=22, y=49},
		{x=15, y=39},
		{x=4, y=16},
		{x=77, y=1},
		{x=63, y=2},
		{x=4, y=1},
	},

	BLARNEY8 = {
		{x=47, y=16},
		{x=82, y=29},
	},

	BLARNEY9 = {
		function(delay)
			local pos_list = {
				{x=33, y=33},
				{x=4, y=45},
				{x=31, y=48},
				{x=91, y=30},
			}
			while true do
				for i, pos in ipairs(pos_list) do
					log(('`9Going to block: `2[%s, %s]'):format(pos.x, pos.y))
					FindPath(pos.x, pos.y)
					Sleep(200)
					enterTile(pos.x, pos.y) -- each pos went will enter tile
					Sleep(delay)
				end	
				Sleep(300)

				local l = GetLocal()
				if l.tile_x == 90 and l.tile_y == 35 then
					log('`2Passed mystery door thingy')
					break
				end

				goToWorld(GetLocal().world)
				Sleep(200)
			end
		end,
		function()
			FindPath(82, 34)
			Sleep(sleep1)
			hitTile(82, 34)
			Sleep(sleep2)
			FindPath(77, 46)
			Sleep(sleep2)
			FindPath(78, 42)
			Sleep(sleep1)
			hitTile(78, 42)
			Sleep(10000)
			FindPath(82, 52)
			Sleep(sleep2)
			enterTile(82, 52)
			Sleep(sleep1)
			SendPacket(2, "action|dialog_return\ndialog_name|adventure_door\ntilex|82|\ntiley|52|\nbuttonClicked|button0")
			Sleep(2000)
			log('`2Passed first adventure door')
		end,
		function()
			FindPath(60, 33)
			Sleep(sleep1)
			hitTile(60, 33)
			Sleep(sleep2)
			FindPath(56, 48)
			Sleep(sleep1)
			hitTile(56, 48)
			Sleep(sleep2)
			FindPath(56, 37)
			Sleep(sleep1)
			hitTile(56, 37)
			Sleep(sleep2)
			FindPath(44, 47)
			Sleep(sleep2)
			enterTile(44, 47)
			Sleep(sleep1)
			SendPacket(2, "action|dialog_return\ndialog_name|adventure_door\ntilex|44|\ntiley|47|\nbuttonClicked|button0")
			log('`2Passed last adventure door')
			Sleep(sleep2)
		end
	},

	BLARNEY10 = {
		{x=94, y=8},
		{x=98, y=16},
		{x=1, y=46},
		{x=37, y=7},
	},
}
if not abcd then return error('fail') end
-- Auto all worlds
local worlds = {
	'BLARNEY1',
	'BLARNEY2',
	'BLARNEY3',
	'BLARNEY4',
	'BLARNEY5',
	'BLARNEY6',
	'BLARNEY7',
	'BLARNEY8',
	'BLARNEY9',
	'BLARNEY10',
}

for _, world in ipairs(worlds) do
		if STOPBLARNEY then break end
		if not abcd then return error('fail') end
		log('`2' .. world)
		goToWorld(world)
		Sleep(5000) -- atleast a 5 second delay after entering each world
		RunBlarney(pos_lists[world], go_to_pos_delay)
		Sleep(go_to_next_world_delay)
end



