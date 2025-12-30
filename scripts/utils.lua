-- from https://stackoverflow.com/questions/9168058/how-to-dump-a-table-to-console
-- dumps a table in a readable string
function dump_table(o, depth)
    if depth == nil then
        depth = 0
    end
    if type(o) == 'table' then
        local tabs = ('\t'):rep(depth)
        local tabs2 = ('\t'):rep(depth + 1)
        local s = '{\n'
        for k, v in pairs(o) do
            local kc = k
            if type(k) ~= 'number' then
                kc = '"' .. k .. '"'
            end
            s = s .. tabs2 .. '[' .. kc .. '] = ' .. dump_table(v, depth + 1) .. ',\n'
        end
        return s .. tabs .. '}'
    else
        return tostring(o)
    end
end

-- Enable/Disable a linked item's partner
function LinkSouls(item_code)
    local code_obj = Tracker:FindObjectForCode(item_code)
    for item_soul, soul_entry in pairs(LINKED_SOULS) do
        if item_code == item_soul then
            local link_obj = Tracker:FindObjectForCode(soul_entry)
            link_obj.Active = code_obj.Active
        elseif item_code == soulentry then
            local link_obj = Tracker:FindObjectForCode(item_soul)
            link_obj.Active = code_obj.Active
        end
    end
end
