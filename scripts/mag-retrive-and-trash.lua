---trash in mag

x = 0
y = 0
id = 1657
function ret()
SendPacket(2,"action|dialog_return\ndialog_name|magplantedit\nx|"..x.."|\ny|"..y.."|\nbuttonClicked|withdraw")
end
function tres(str)
for , inv in pairs(GetInventory()) do
if inv.id == str then
SendPacket(2,"action|dialog_return\ndialog_name|trash\nitem_trash|"..str.."|\nitem_count|"..inv.count)
end
end
end
while true do
ret()
Sleep(100)
tres(id)
Sleep(100)
end
