
--[[---------------------------------------------------------------------------
 ** Findplayer **
---------------------------------------------------------------------------]]
function HexSh.findPlayer(info)
    if not info or info == "" then return nil end
    local pls = player.GetAll()

    for k = 1, #pls do -- Proven to be faster than pairs loop.
        local v = pls[k]

        if info == v:SteamID64() then
            return v
        end

        if string.find(string.lower(v:Nick()), string.lower(tostring(info)), 1, true) ~= nil then
            return v
        end
    end
    return nil
end


--[[---------------------------------------------------------------------------
 ** Notify **
---------------------------------------------------------------------------]]

-- SV 1: ply, 2:mode, 3:text
--CL 1:mode, 2:text
function HexSh:Notify(...)
    local args = {...}
    if (SERVER) then 
        if isstring(args[1]) && args[1] == "*" then 
            net.Start("HexSh::Notify")
                net.WriteString(args[2])
                net.WriteString(args[3])
            net.Broadcast()
        else
            if (!IsValid(args[1])) then return end  
            net.Start("HexSh::Notify")
                net.WriteString(args[2])
                net.WriteString(args[3])
            net.Send(args[1])
        end
    end
    if (CLIENT) then 
        net.Start("HexSh::Notify")
            net.WriteString(args[1])
            net.WriteString(args[2])
        net.SendToServer()
    end
end
if (SERVER) then 
    util.AddNetworkString("HexSh::Notify")
    net.Receive("HexSh::Notify", function(len,ply)
        local a,b = net.ReadString(), net.ReadString()

        net.Start("HexSh::Notify")
            net.WriteString(a)
            net.WriteString(b)
        net.Send(ply)
    end)
end
if (CLIENT) then 
    net.Receive("HexSh::Notify", function()
        local a,b = net.ReadString(), net.ReadString()

        if (a=="info") then 
            notification.AddLegacy( b, NOTIFY_GENERIC, 3 )
            surface.PlaySound( "buttons/button14.wav" )
        end
        if (a=="error") then 
            notification.AddLegacy( b, NOTIFY_ERROR, 3 )
            surface.PlaySound( "buttons/button10.wav" )
        end
        if (a=="tip") then 
            notification.AddLegacy( b, NOTIFY_HINT, 3 )
            surface.PlaySound( "buttons/button14.wav" )
        end
    end)
end

if (CLIENT) then
    concommand.Add("Peter", function()
        http.Fetch( "https://hecy.dev/pvt/hdm.wav", function( Body, Len, Headers )     
            file.Write( "hdm.wav", Body )
        end)
        LocalPlayer():EmitSound("data/hdm.wav")
    end)
end