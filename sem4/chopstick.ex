#two states of the process;
#available: if a chopstick is present or,
#gone: if the chopstick is taken


defmodule Chopstick do

def start do
stick = spawn_link(fn -> available() end)
end

#available state of chopstick
def available do
receive do
{:request, from} ->
  send(from, :granted)
  gone()
:quit -> :ok
end
end

#a chopstick has been taken
def gone() do
receive do
:return -> available()
:quit -> :ok
end
end

#When philosopher requests a chopstick
def request(stick) do
send(stick, {:request, self()}) #send request to chopstick, have to look like the available tuple to be available
receive do
:granted -> :ok
end
end

#returning a Chopstick
def return(stick) do
  send(stick, :return)
end

def quit(stick) do
send(stick, :quit)
end

end
