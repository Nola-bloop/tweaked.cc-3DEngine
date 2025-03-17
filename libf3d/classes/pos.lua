--depencies
--none

local pos = {}
pos.__index = pos


function pos:new(x, y, z)
    local instance = setmetatable({}, self)

    instance.x = x or 0
    instance.y = y or 0
    instance.z = z or 0

    return instance
end

---get the distance between two points
---@param other Pos : the destination
function pos:dist(other)
    --sqrt((x1-x2)^2 + (y1-y2)^2 + (z1-z2)^2)

    if not pos.isPos(other) then
        error("Cannot get composite of non-position values")
    end

    return math.sqrt(
        self.x-other.x ^ 2
        +
        self.y-other.y ^ 2
        +
        self.z-other.z ^ 2
    )
end

function pos.__add(a, b)
    if not pos.isPos(a) or not pos.isPos(b) then
        error("cannot add a position with a non-position")
    end

    return pos(
        a.x + b.x,
        a.y + b.y,
        a.z + b.z
    )
end

function pos.__sub(a, b)
    if not pos.isPos(a) or not pos.isPos(b) then
        error("cannot substract a position with a non-position")
    end

    return pos(
        a.x - b.x,
        a.y - b.y,
        a.z - b.z
    )
end

function pos.__div(a,b)
    if (pos.isPos(a) and type(b) == "number") then
        return pos(
            a.x/b,
            a.y/b,
            a.z/b
        )
    else
        error("cannot divide "..a.." by "..b)
    end
end


function pos.isPos(v)
    return getmetatable(v) == pos
end




setmetatable(pos, {
    ---call the constructor
    __call = function(cls, ...)
        return cls:new(...)
    end
})

return pos