--depencies
local Vector = require("libf3d.classes.vector")
local Face = require("libf3d.classes.face")

--class
local mesh = {}
mesh.__index = mesh

function mesh:new(...)
    local instance = setmetatable({}, self)

    instance.faces = {}
    local faces = instance.faces --

    for k, v in pairs({...}) do
        --sanity check
        if not Face.isFace(v) then
            error("You cannot send non-face elements in the mesh constructor")
        end

        faces[#faces+1] = v
    end

    return instance
end

---check if the vector would end up touching the mesh
---@param v Vector : a unitary vector going (hopefully) towards the mesh
---@return boolean, number :true if it touches, then sends the distance in the second param
function mesh:raycast(v)
    local dist = 0
    local res = false

    for i = 1, #self.faces do
        
    end

    return res, dist
end

return mesh