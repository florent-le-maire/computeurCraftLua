TurtleF = {data={}}

function TurtleF.__init__ (x,fuel)
  local self = {
    x=x,
    fuel=fuel
  }
  setmetatable (self, {__index=TurtleF})
  return self
end

function TurtleF:refuel ()
  local fuelUser = self.fuel;
  if turtle.getFuelLimit() < fuelUser then
    fuelUser = turtle.getFuelLimit()
  end
  for i=1,16 do
    local dataItem = turtle.getItemDetail(i)
    if dataItem then
      local nameItem = dataItem.name
      print(nameItem,i)
      --A mettre dans une liste de carburant autorisé et pas en dur
      if nameItem == "minecraft:coal" then
        turtle.select(i)
        --ça marche pas çaaaaaaaa
        while turtle.getFuelLevel() <= fuelUser and turtle.getItemCount() > 0 do
          turtle.refuel(1)
        end
      end
    end
    if turtle.getFuelLevel() >= fuelUser then break end
  end
end

function TurtleF:printData ()
  print (self.x,self.fuel)   
end

local turtleTest = TurtleF.__init__ (10,320)
turtleTest:printData()
turtleTest:refuel()
turtleTest:printData()
