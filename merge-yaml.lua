local lyaml = require('lyaml')

local function deepMerge(base, override)
    if type(override) ~= 'table' then
        return override
    end
    if type(base) ~= 'table' then
        return override
    end
    local result = {}
    for k, v in pairs(base) do
        result[k] = v
    end
    for k, v in pairs(override) do
        if result[k] == nil then
            result[k] = v
        elseif type(result[k]) == 'table' and type(v) == 'table' then
            result[k] = deepMerge(result[k], v)
        end
    end
    return result
end

local args = {...}
if #args < 1 then
    io.stderr:write("Usage: lua merge-yaml.lua file1.yml file2.yml ...\n")
    os.exit(1)
end

local merged = nil
for _, filepath in ipairs(args) do
    local f = io.open(filepath, 'r')
    if not f then
        io.stderr:write("Cannot open file: " .. filepath .. "\n")
        os.exit(1)
    end
    local content = f:read('*a')
    f:close()

    local ok, data = pcall(lyaml.load, content)
    if not ok then
        io.stderr:write("Failed to parse YAML: " .. filepath .. "\n" .. data .. "\n")
        os.exit(1)
    end

    if merged == nil then
        merged = data
    else
        merged = deepMerge(merged, data)
    end
end

local ok, output = pcall(lyaml.dump, {merged})
if not ok then
    io.stderr:write("Failed to dump YAML\n")
    os.exit(1)
end

print(output)
