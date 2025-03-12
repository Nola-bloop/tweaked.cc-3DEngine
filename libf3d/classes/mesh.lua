local path = (...):match("[%a]*libf3d$").."."

--depencies
local Vector = require(path.."classes.vector")

--private
local _mesh = setmetatable ({}, {
    --metatables for private class
})

_mesh.vertices = {
    Vector(0,0,2,0),
    Vector(0,0,0,2),
    Vector(0,0,2,0),
    Vector(0,0,2,0),
    Vector(0,0,2,0),
    Vector(0,0,2,0),
}



--------------------------------------------------------------------------------
--Public

local mesh = setmetatable({},{
    --metatables for public table
    __index = function()
        
    end
})

function mesh:new()

end

return mesh