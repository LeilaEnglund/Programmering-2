defmodule Mandel do

#the depth of the mandelbrot is dependig on x -> (x+k)+yi etc.
#the hight if the mandelbrot depends on y
  def mandelbrot(width, height, x, y, k, depth) do
  trans = fn(w, h) ->
  Cmplx.new(x + k * (w - 1), y - k * (h - 1))
  end
  rows(width, height, trans, depth, [])
  end

#returns a list of rows where each row is a list of colors
#Each item in a row corresponds to a pixel at (w,h)
#goes throuh the height
  def rows(_, 0, _,_ , rowList) do
    rowList
  end
def rows(width, height, trans, depth, rowList) do
  row = row(width, height, trans, depth, [])
  rows(width, height-1, trans, depth,[row | rowList])
end

def row(0, _, _,_ , rowList) do
  rowList
end

def row(width,height,trans,depth, rowList) do
  cmplx=trans.(width,height)  #transform to a complex number
  cmplx_depth = Brot.mandelbrot(cmplx,depth)  #calculate the depth of the complex value
  color=Color.convert(cmplx_depth, depth) #convert the depth to a colour
  new_rowlist = [color | rowList] #add the colour to the list
  row(width-1, height, trans, depth, new_rowlist)
end

end
