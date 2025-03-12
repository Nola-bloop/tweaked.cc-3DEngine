local path = (...):match("[%a]*libf3d$").."."

--depencies
--local utils = require(path.."utils")

local vector = {}
vector.__index = vector

--- Create a vector with an origin, a normal and an orientation
---@param x number : x position of the root
---@param y number : y position of the root
---@param z number : z position of the root
---@param a number : x composite
---@param b number : y composite
---@param c number : c composite
function vector:new(x,y,z,a,b,c)
    local instance = setmetatable({}, self)

    instance.x = x or 0
    instance.y = y or 0
    instance.a = a or 0
    instance.b = b or 0
    return instance
end

--- Adds two vectors together. if two vectors, add them to get a resultant vector. If adding a position to a vector, then apply it to the composite. If scalar, add it to both composite axis
---@param a any
---@param b any
vector.__add = function (a, b) 
    -- Ensure 'a' is a vector; swap if 'b' is a vector and 'a' is not
    if not vector.isVector(a) then
        if vector.isVector(b) then
            a, b = b, a
        else
            error("Cannot add non-vector and non-scalar")
        end
    end

    --add vectors if they're both vectors
    if vector.isVector(b) then
        local v = vector:new(
            a.x,      --x
            a.y,      --y
            a.a + b.a,--a
            a.b + b.b --b
        )
        return v
    elseif vector.isPos(b) then --add position to vector (don't change the vector's root, just it's composite elements)
        local v = vector:new(
            a.x,      --x
            a.y,      --y
            a.a + b.x,--a
            a.b + b.y --b
        )
        return v
    elseif type(b) == "number" then --add scalar
        local v = vector:new(
            a.x,      --x
            a.y,      --y
            a.a + b,  --a
            a.b + b   --b
        )
        return v
    else
        error("Invalid type for addition with vector : " .. type(b) .. ". Only Vectors, positions and scalars(numbers) are allowed")
    end
end

--- Checks if the argument is a vector
---@param v any
---@return boolean
function vector.isVector(v)
    return getmetatable(v) == vector
end

--- Checks if the argument is a position (has x and y number fields)
---@param c any
---@return boolean
function vector.isPos(c)
    return type(c) == "table" and type(c.x) == "number" and type(c.y) == "number"
end





--statics
setmetatable(vector, {
    ---call the constructor
    __call = function(cls, ...)
        return cls:new(...)
    end
})

return vector