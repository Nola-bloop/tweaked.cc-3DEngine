--depencies
local Vector = require("libf3d.classes.vector")
local Pos = require("libf3d.classes.pos")

local face = {}
face.__index = face

---Constructor of a face
---@param ... Pos : the position of the vertices
---@return table
function face:new(...)
    local instance = setmetatable({}, self)
    instance.vertices = {}

    for _, v in pairs({...}) do
        if (not Pos.isPos(v)) then
            error("Invalid argument in face constructor: '"..v.."' Value must be a position (x=num,y=num,z=num).")
        end

        instance.vertices[#instance.vertices+1] = Vector(
            v.x,
            v.y,
            v.z
            --leave the composites empty for now
        )

        --redo previous vector
        if #instance.vertices > 1 then
            local i = #instance.vertices-1

            --obtenir la différence entre les deux vecteurs
            local diff = instance.vertices[i+1]:origin() - instance.vertices[i]:origin()

            instance.vertices[i] = Vector(
                instance.vertices[i].x,
                instance.vertices[i].y,
                instance.vertices[i].z,

                diff.x,
                diff.y,
                diff.z
            )
        end
    end

    instance:resetRoot()

    local diff = instance.vertices[1]:origin() - instance.vertices[#instance.vertices]:origin()
    instance.vertices[#instance.vertices] = Vector(
        instance.vertices[#instance.vertices].x,
        instance.vertices[#instance.vertices].y,
        instance.vertices[#instance.vertices].z,

        diff.x,
        diff.y,
        diff.z
    )

    return instance
end

---set the root of the face at the middle of all it's vertices
---@return Pos
function face:resetRoot()
    local moy = Pos(0,0,0)
    for i = 1, #self.vertices do
        moy = moy + self.vertices[i]:origin()
    end

    moy = moy/#self.vertices

    return moy
end

setmetatable(face, {
    ---call the constructor
    __call = function(cls, ...)
        return cls:new(...)
    end
})

return face