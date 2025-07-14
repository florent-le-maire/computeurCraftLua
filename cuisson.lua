local function take(fromX, toY)
    for i = fromX, toY do
        turtle.select(i)
        turtle.suck()
    end
end

local function filter(fromX, toY)
    for i = fromX, toY do
        turtle.select(i)
        local item = turtle.getItemDetail()
        if item then
            if item.name ~= "minecraft:potato" then
                -- rejeter immédiatement les carottes (ou tout autre item)
                turtle.drop()
            end
        end
    end
end
local function takeAndFilter()
    local fromX = 2
    local toY = 16
    take(fromX, toY)
    filter(fromX, toY)
end
local function countThisIndex(i)
    turtle.select(i)
    local item = turtle.getItemDetail()
    if item then
        return item.count
    end
    return 0
end

local function countForThisRange(fromX, toY)
    local count = 0
    for i = fromX, toY do
        count = count + countThisIndex(i)
    end
    return count
end

local function dropItemToSmelt(i, count)
    turtle.select(i)
    local item = turtle.getItemDetail()
    if item then
        return turtle.dropUp(count)
    end
    return false
end
local function dropCoal()
    turtle.select(1)
    return turtle.drop(1)
end

local function dropCoalAndSmelt(countItems)
    
end


-- Boucle principale
while true do
    turtle.turnRight()
    takeAndFilter()
    turtle.turnLeft()
    turtle.turnLeft()
    local countItems = countForThisRange(2, 16)
    dropCoalAndSmelt(countItems)
    turtle.turnRight()
    sleep(5)
end
