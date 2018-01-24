defmodule Recursive do

def product(m, n) do
if m == 0 do

n

else

product(m - 1, n) + n

end
end

def exp(_, 0) do 1 end
def exp(x, n) do
  x * exp(x, n - 1)
end


end
