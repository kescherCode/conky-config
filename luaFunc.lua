active_network_interface = false

--${if_match "${addr eno1}"!="No Address"} ${color0}Ethernet${alignr}${color1}${addr eno1}
--
-- ${color0}Down: ${color1}${downspeed eno1}/s ${alignr}${color0}Up: ${color1}${upspeed eno1}/s
-- ${color1}${downspeedgraph eno1 50,100 00592f 00b386 -t -l} ${alignr}${upspeedgraph eno1 50,100 00592f 00b386 -t -l}
-- ${endif}${if_match "${addr enp0s20u1}"!="No Address"}\
-- ${color0}USB${alignr}${color1}${addr enp0s20u1}
--
-- ${color0}Down: ${color1}${downspeed enp0s20u1}/s ${alignr}${color0}Up: ${color1}${upspeed enp0s20u1}/s
-- ${color1}${downspeedgraph enp0s20u1 50,100 00592f 00b386 -t -l} ${alignr}${upspeedgraph enp0s20u1 50,100 00592f 00b386 -t -l}${endif}

function conky_drawnetworks(max_ifaces)
    local active_ifaces = {}
    if active_network_interface == false or tonumber(conky_parse("$updates")) % 2 == 0 then
        local ifaces = io.popen('ip link | grep -Po --regexp "(?<=[0-9]: ).*"')
        for line in ifaces:lines() do
            if string.find(line, "<BROADCAST") then
                local iface = string.gsub(string.match(line, "^.*:"), ":", "")
                table.insert(active_ifaces, iface)
            end
        end
        ifaces:close()
        if table.maxn(active_ifaces) >= 1 then
            local draw_other_ifaces = ''
            for i, iface in pairs(active_ifaces) do
                if i <= tonumber(max_ifaces) then
                    draw_other_ifaces = draw_other_ifaces
                            .. " ${color0}" .. iface .. "${alignr}${color1}${addrs " .. iface .. "}" .. "\n\n"
                            .. " ${color0}▼ ${color1}${downspeed " .. iface .. "}/s ${alignr}${color0}▲ ${color1}${upspeed " .. iface .. "}/s\n"
                            .. " ${color1}${downspeedgraph " .. iface .. " 50,100 00592f 00b386 -t -l} ${alignr}${upspeedgraph " .. iface .. " 50,100 00592f 00b386 -t -l}"
                            .. "\n"
                    if i < table.maxn(active_ifaces) and i ~= tonumber(max_ifaces) then
                        draw_other_ifaces = draw_other_ifaces .. " ${voffset -15}$color0${stippled_hr 2}\n"
                    end
                end
            end
            active_network_interface = draw_other_ifaces
            return active_network_interface
        else
            active_network_interface = '${goto 10}${font FontAwesome}${font} ${color #00FF00}Network Interfaces $color \n${goto 50} Device not connected.\n'
        end
    end
    return active_network_interface
end
