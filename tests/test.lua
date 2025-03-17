local Face = require("libf3d.classes.face")
local Pos = require("libf3d.classes.pos")

local face = Face(
    Pos(2,2,2),
    Pos(2,4,2),
    Pos(4,4,2)
)

for i = 1, #face.vertices do
    print("("..face.vertices[i].x..","..face.vertices[i].y..","..face.vertices[i].z..")")
    local x, y = term.getCursorPos()
    term.setCursorPos(1,y+1)
end