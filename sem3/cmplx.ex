defmodule Cmplx do

#returns the complex nr with the real value r and imaginaty i
def new(r,i) do
{:cmp, r, i}
end

#add tow complex numbers
def add({:cmp, real1,img1}, {:cmp, real2,img2}) do

{:cmp, real1+real2, img1+img2}

end

def sqr({:cmp, r, i}) do
  {:cmp, r*r - i*i , 2*r*i}
end

def abs({:cmp, r, i}) do
  :math.sqrt(r*r + i*i)
end
end
