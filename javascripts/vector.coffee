# Vector's manage X and Y values.  The `v()` function serves as a shortcut for
# Vector creation, since it's a common operation

class @Vector
  constructor: (@x = 0, @y = 0) ->
  
  # Return a new vector with identical values
  clone: ->
    new Vector(@x, @y)
  
  #### Transformations
  
  # Add another vector to this one
  add: (other) ->
    @x += other.x
    @y += other.y
    this
  
  # Subtract another vector to this one
  subtract: (other) ->
    @x -= other.x
    @y -= other.y
    this
  
  # Scale this vector by a scalar value
  scale: (scalar) ->
    @x *= scalar
    @y *= scalar
    this
  
  # Make the vector length one
  normalize: ->
    @scale 1/@length
  
  toString: ->
    "<Vector: #{@x} #{@y}>"
  
  #### Comparisons
  
  # Return true if the other vector hs the same values
  equal: (other) ->
    @x == other.x && @y == other.y
  
  # Return the distance to another vector
  distance: (other) ->
    @clone().subtract(other).length
  


#### Properties

# Return the angle of this vector
@Vector::__defineGetter__ 'angle', ->
  result = Math.atan2(@y, @x) * 180/Math.PI
  result += 360 if result < 0
  result

# Set the angle of this vector, keeping its current length
@Vector::__defineSetter__ 'angle', (newAngle) ->
  oldLength = @length
  @x = Math.cos(newAngle * Math.PI/180)
  @y = Math.sin(newAngle * Math.PI/180)
  @length = oldLength

# Return the length of this vector
@Vector::__defineGetter__ 'length', ->
  Math.sqrt @x*@x + @y*@y

# Set the length of this vector, keeping its curent angle
@Vector::__defineSetter__ 'length', (newLength) ->
  if newLength == 0
    @scale 0
    return
  
  else if @length == 0
    @x = 1
  
  @scale newLength/@length

  
#### Vector shortcuts

@Vector.zero   = -> new Vector()      
@Vector.up     = -> new Vector( 0,  1)
@Vector.down   = -> new Vector( 0, -1)
@Vector.left   = -> new Vector(-1,  0)
@Vector.right  = -> new Vector( 1,  0)

# Convenience constructor shortcut
@v = (x, y)-> new Vector(x, y)