#!/usr/bin/env lua

active_network_interface = false

function conky_drawnetworks(max_ifaces)
    if not active_network_interface or tonumber(conky_parse("$updates")) % 2 == 0 then
        local active_ifaces = {}
        local ifaces = io.popen('ip link | grep -Po --regexp "(?<=[0-9]: ).*"')
        for line in ifaces:lines() do
            if string.find(line, "<BROADCAST") and string.find(line, ",UP") then
                local iface = string.gsub(string.match(line, "^.*:"), ":", "")
                table.insert(active_ifaces, iface)
            end
        end
        ifaces:close()
        if #active_ifaces >= 1 then
            local draw_other_ifaces = ''
            for i, iface in pairs(active_ifaces) do
                if i <= tonumber(max_ifaces) then
                    draw_other_ifaces = draw_other_ifaces
                            .. " ${color0}" .. iface .. "${alignr}${color1}${addrs " .. iface .. "}" .. "\n\n"
                            .. " ${color0}▼ ${color1}${downspeed " .. iface .. "}/s ${alignr}${color0}▲ ${color1}${upspeed " .. iface .. "}/s\n"
                            .. " ${color1}${downspeedgraph " .. iface .. " 50,100 00592f 00b386 -t -l}"
                            .. "${alignr}${upspeedgraph " .. iface .. " 50,100 00592f 00b386 -t -l}"
                            .. "\n"
                    if i < #active_ifaces and i ~= tonumber(max_ifaces) then
                        draw_other_ifaces = draw_other_ifaces .. " ${voffset -15}$color0${stippled_hr 2}\n"
                    end
                end
            end
            active_network_interface = draw_other_ifaces
        else
            active_network_interface = '${color2}No interfaces are connected'
        end
    end
    return active_network_interface
end
