-- Slot 1 : Charbon
-- Slots 2 à 16 : Patates et carottes

local INPUT_SIDE = "right"   -- coffre d'entrée
local OUTPUT_SIDE = "left"  -- four
local TRASH_SIDE = "right"    -- là où on balance les carottes

while true do
  -- 1. Tente de prendre un item à la fois pour filtrer immédiatement
  for i = 2, 16 do
    turtle.select(i)
    if turtle.suck() then
      local item = turtle.getItemDetail()
      if item then
        if item.name ~= "minecraft:potato" then
          -- rejeter immédiatement les carottes (ou tout autre item)
          turtle.drop(TRASH_SIDE)
        end
      end
    end
  end

  -- 2. Compter le nombre de patates
  local potatoCount = 0
  for i = 2, 16 do
    turtle.select(i)
    local item = turtle.getItemDetail()
    if item and item.name == "minecraft:potato" then
      potatoCount = potatoCount + item.count
    end
  end

  -- 3. Si on a au moins 8 patates, les déposer + 1 charbon
  while potatoCount >= 8 do
    local deposited = 0
    for i = 2, 16 do
      if deposited >= 8 then break end
      turtle.select(i)
      local item = turtle.getItemDetail()
      if item and item.name == "minecraft:potato" then
        local toDrop = math.min(item.count, 8 - deposited)
        turtle.dropRight(toDrop)
        deposited = deposited + toDrop
        potatoCount = potatoCount - toDrop
      end
    end

    -- Mettre 1 charbon
    turtle.select(1)
    if turtle.getItemCount() > 0 then
      turtle.dropRight(1)
    else
      print("⚠️ Plus de charbon !")
    end

    sleep(1)
  end

  sleep(5)
end
