-- Slot 1 : Charbon
-- Slots 2 à 16 : Patates

local function getTotalInventoryCount()
    local total = 0
    for i = 2, 16 do
        total = total + turtle.getItemCount(i)
    end
    return total
end

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
        if item and item.name ~= "minecraft:potato" then
            turtle.drop() -- rejette tout sauf les patates
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

local function dropItemToSmelt(i, toDrop)
    turtle.select(i)
    local item = turtle.getItemDetail()
    if item and item.name == "minecraft:potato" then
        local amount = math.min(item.count, toDrop)
        if amount > 0 then
            if turtle.dropUp(amount) then
                return amount
            end
        end
    end
    return 0
end

local function dropCoal()
    turtle.select(1)
    return turtle.getItemCount() > 0 and turtle.drop(1)
end

local function dropCoalAndSmelt()
    local toDrop = 8
    for i = 2, 16 do
        if toDrop <= 0 then break end
        local dropped = dropItemToSmelt(i, toDrop)
        toDrop = toDrop - dropped
    end

    if toDrop == 0 then
        if not dropCoal() then
            print("Plus de charbon")
        end
    else
        print("Impossible de déposer 8 patates, arrêt du batch.")
        return
    end
end

local function findBlockAround(targetBlockName)
  for i = 1, 4 do
    local hasBlock, data = turtle.inspect()
    if hasBlock and data.name == targetBlockName then
      return true, i 
    end
    turtle.turnLeft()
  end
  return false, 4 
end

while true do
    if getTotalInventoryCount() < 897 then
		local found, turns = findBlockAround("minecraft:chest")
		if found then
		  print("Coffre trouvé après " .. (turns - 1) .. " rotation(s) !")
		else
		  print("Aucun coffre trouvé autour.")
		  break
		end
        takeAndFilter()
		found, turns = findBlockAround("minecraft:chest")
		if found then
		  print("Four trouvé après " .. (turns - 1) .. " rotation(s) !")
		else
		  print("Aucun four trouvé autour.")
		  break
		end
        local countItems = countForThisRange(2, 16)
        if countItems > 8 then
            dropCoalAndSmelt(countItems)
        end
        turtle.turnRight()
    else
        print("Trop d'objets dans l'inventaire, en attente...")
    end

    sleep(5)
end

detect()