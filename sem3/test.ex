defmodule Test do
def double(n) do

n*2

end

# convert är ett funktionsnamn som tar emot en variabel f och konverterar till celsius
def convert(f) do

  c = (f - 32) / 1.8

end

def area(b,h) do

  b*h

end

def square(x) do

  area(x,x)

end

def circle(r) do

3.14*(r*r)

end

end
