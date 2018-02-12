#a module for the enviroment
#can represent an environment as a list of key-value tuples
#ex {x/foo, y/bar} -> [{:x, :foo}, {:y, :bar}]
#variabels represents as atoms
#match=pattern=expression, x(pattern)=foo(expression)
#expression matches with the pattern and are binded
#expression = atom or variabel or {expression, expression}
#:bar = atom, foo=variabel, {:bar, pew}=expression,expression=atom, variabel

#enviroment contains variabel bindings, initially empty, immutable x/foo y/:nil ex..
#if new binding, return a new envoroment with the new binding

#---------------------------------------------------------------------------------------

defmodule Env do

  #return an empty environment
  def new() do
    []
  end

  #return an environment where the binding of the
  #variable id to the structure str has been added to the environment env.
  def add(id, str, env) do
    [{id, str} | env]
  end


#return either {id, str}, if the variable id was bound, or nil
  def lookup(id, []) do
    nil
  end
  def lookup(id, [{id, str} | rest]) do
  {id, str}
  end
  def lookup(id, [{other, str} | rest])do
  lookup(id, rest)
  end

#return an environmant where all bindings for
#variabels in the list ids have been removed
#ex [:x,:y] [{:x, :foo}, {:y, :bar}, {:z, :zoot}] --> [{:z, :zoot}]
  def remove([], env) do
    env
  end
  def remove([id | rest], env) do
    newEnv = List.keydelete(env, id, 0) #remove the tuple containing id matched with env
    remove(rest, newEnv)
  end

#creates a new environment from a list of variable identifiers
#and an existing environment.
  def closure([], env) do
    env
  end
  def closure([], )


end
