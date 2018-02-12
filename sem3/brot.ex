defmodule Brot do

  # mandelbrot(c, m): calculate the mandelbrot value of
  # complex value c with a maximum iteration of m. Returns
  # 0..(m - 1).

def mandelbrot(c, m) do
z0 = Cmplx.new(0,0)
i = 0
test(i, z0, c, m)
end

#the definition of mandelbrot :
#z0=0
# zn+1=zn^2 + c
#c is a complex number a+bi
#z is the sequence 
def test(m,z,c,m) do
  0
end
def test(i,z,c,m) do
  z_abs = Cmplx.abs(z)

#
  if z_abs < 2.0 do
    z_new = Cmplx.add(Cmplx.sqr(z), c)
    test(i+1, z_new, c, m)
  else
    i
  end
end
end
