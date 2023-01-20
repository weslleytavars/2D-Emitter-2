```
                                           ___  _____  ______             _   _            
                                          |__ \|  __ \|  ____|         (_) | | |           
                                             ) | |  | | |__   _ __ ___  _| |_| |_ ___ _ __ 
                                            / /| |  | |  __| | '_ ` _ \| | __| __/ _ \ '__|
                                           / /_| |__| | |____| | | | | | | |_| ||  __/ |   
                                          |____|_____/|______|_| |_| |_|_|\__|\__\___|_|   
                
                                                   Create beautiful ui particles!
  
                                                             By @Synitx     

```

Click [here](https://www.roblox.com/library/12215556043/2D-Emitter-V2) to get the module\n
Click [here](https://create.roblox.com/marketplace/asset/12214425910/2DEmitter)to get the plugin.

Lets start by requiring the module.
  
  ```lua
  local Module = require(path.to.module)
  ```
  
  Create the emitter
  
  ```lua
  local Emitter = Module.new(position:UDim2) -- Starting position of the particle in UDim2
   ```

  Setting a property
  Available properties: { Size, Speed, Amount, LifeTime, Color, Acceleration, Texture, Position, Rotation }
 
  
  You can also use Emitter:Set{PropertyName} or Emitter:Set<Property>
  
  ```lua
  Emitter:Set({options}) -- options must be a table
  ```
  ```lua
  Emitter:Set({
     Size = 3,
     LifeTime = Vector2.new(5,15),
     Speed = 0.3,
     Spread = false,
     Color = { Color3.new(255,255,255), Color3.new(0,255,0) },
     Amount = 15,
     Corner = UDim.new(0,0),
     SetParticleType = Emitter.SetParticleType.Default
  })
  ```
  
  • Size : number
    Size of the particle, default is 1 
        size must be a number.

```lua
     Emitter:SetSize(2)
 ```
    
  • LifeTime : Vector2
    Lifetime of the particle, lifetime is the end time of the particle
       lifetime must be a vector2.

```lua
    Emitter:SetLifeTime(Vector2.new(5,10))
```
    
  • Speed : number
    Speed of the particle, it changes the speed of the particle
       speed must be a number.

```lua
    Emitter:SetSpeed(0.3)
```
   
  • Color : table
    List of colors for the particle, it picks random color from the table and set it to the color of the particle
      In table colors must be Color3 values.

```lua
   Emitter:SetColor( { Color3.fromRGB(255,255,255) , Color3.fromRGB(255,0,0) } )
```
   
   • Amount : number
     The default amount of the particles
       must be a number

```lua
   Emitter:SetAmount(value : number)
```
   
  • Rotation : number
     The rotation of the particles
       must be a number
  
```lua
Emitter:SetRotation(360)
```
  
  • Texture : number
     The texture of the particle
       must be a number (image/decal id)
  
```lua
  Emitter:SetTexture(00000)
 ```
  
  • Acceleration : UDim2
    The Acceleration of the particle
    must be udim2
  
```lua
 Emitter:SetAcceleration(UDim2.fromOffset(0,30))
```
   
### How to emit a particle?
   
   ```lua
   Emitter:Emit() or Emitter:Emit(amount : number)
   ```
