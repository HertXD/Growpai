RemoveCallbacks()
function Change(id, count)
    SendPacket (2,("action|mod_trade\nitemID|%d"):format(id))
    SendPacket (2,("action|dialog_return\ndialog_name|trade_item\nitemID|%d|\ncount|%d"):format(id, count))
    SendPacket (2,"action|trade_accept\nstatus|1")
    Sleep(1000)
    RemoveCallbacks()
end
AddCallback("OnVarlist", function(v)
    if v[0] == "OnDialogRequest" then
        return true
    end
    return false
end)
Sleep(100)
Change(2, 1)
