-- Slot 1 : Charbon
-- Slots 2 à 16 : Patates et carottes

while true do
    turtle.turnRight()
    -- 1. Tente de prendre un item à la fois pour filtrer immédiatement
    for i = 2, 16 do
        turtle.select(i)
        turtle.suck()
    end
    for i = 2, 16 do
        turtle.select(i)
        local item = turtle.getItemDetail()
        if item then
            if item.name ~= "minecraft:potato" then
                -- rejeter immédiatement les carottes (ou tout autre item)
                turtle.drop()
            end
        end
    end
    turtle.turnLeft()
    turtle.turnLeft()

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
        local coal = 0
        for i = 2, 16 do
            if deposited >= 8 then break end
            turtle.select(i)
            local item = turtle.getItemDetail()
            if item then
                turtle.dropUp(8)
                deposited = deposited + 8
                potatoCount = potatoCount - 8
            end
        end

        -- Mettre 1 charbon
        turtle.select(1)
        if turtle.getItemCount() > 0 and deposited % 8 > coal then
            turtle.drop(1)
            coal = coal + 1
        else
            print("⚠️ Plus de charbon !")
        end

        sleep(1)
    end

    sleep(5)
end
