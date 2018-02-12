#pattern = atom,variabel,dont care, {patter, pattern}
#same Recursive idé


defmodule Eager do
#returns an atom with the id
#an atom just has an id, no datastructure
  def eval_expr({:atm, id},_, prg) do
  {:ok, id}
  end

#returns datastructure if the variable is found in the enviroment
  def eval_expr({:var, id}, env, prg) do
  case Env.lookup(id, env) do
  nil -> :error
  {_, str} -> {:ok, str}#only rturn the datastructure
  end
  end

#cound be variable - variabel
#cound be atom - atom or
#cound be variable - atom
  def eval_expr({:cons,head , tail}, env, prg) do
  case eval_expr(head, env, prg) do #send the first element to var- or atomfunction
  :error -> :error
  {:ok, hstr} -> #if the elemt is found from var or atm, check the next element
  case eval_expr(tail, env, prg) do
  :error -> :error
  {:ok, tstr} ->
  {hstr, tstr} #returns the datastructure of the elements
  end
  end
  end

#A case expression consists of an expression and a list of clauses where each
#clause is a pattern and a sequence
  def eval_expr({:case, expr, clauseList}, env, prg) do
  case (expr, env, prg) do
  :error -> :error
  {:ok, str} ->
  eval_caluse(clauseList, str, env)
  end
  end

  def eval_clause([],_ , _, prg) do
  :error
  end
  def eval_clause( [{:clause, pattern, seq} | cls], str, env, prg) do
  vars = extract_vars(pattern)
  env = Env.remove(vars, env)

  case eval_match(pattern, str, env) do
  :fail ->
  eval_clause(clause, str, env, prg)
  {:ok, env} ->
  eval_seq(seq, env)
  end
  end

#pattern match
  def eval_match({:atm, id}, id, env)do
    {:ok, env}
  end

  #we can ignnore the case where the atoms do not match for now
  def eval_match(:ignore,_,env) do
    {:ok, env}
  end

  def eval_match({:var, id}, str, env) do
  case Env.lookup(id,env) do
    nil -> {:ok, Env.add(id,str,env)}
    {_, ^str}->#if the datastructure is the same that's been send to the funct.
      {:ok, env}#return ok and the enviroment
    {_,_}->#if it's not matched, fail
      :fail
    end
    end

#cons --> eval match({:cons, {:var, :x} {:var, :x}}, {:cons, {:atm, :a} {:atm, :b}}, []) : returns :fail
def eval_match({:cons,headPattern,tailPattern},[headStr | tailStr], env) do
case eval_match(headPattern,headStr,env) do #match headPattern with headPattern
  :fail -> :fail
  {:ok, env}->
  eval_match(tailPattern,tailStr, env)
  end
  end


#evaluates the given expression ex, x = :a; y = {x,:b}; {_,z} = y; z
#a match has a pattern on one side and an expression on the other side.
def eval_seq([exp], env, prg) do
eval_expr(exp, env)
end
def eval_seq([{:match,ptrn, exp |rest], env, prg) do
case eval_expr(exp,env) do
:error -> :error
#if expression exist in the environment
{ok, str} ->
vars = extract_vars(pattern)#gets the variabel from the pattern
env = Env.remove(vars, env)#remove all variabel bindings
case eval_match(pattern,str,env) do
:fail ->
:error
{:ok, env} ->
eval_seq(rest,env, prg)
end
end
end

#get the variabel from the pattern
def extract_vars(pattern) do
  extract_vars(pattern, [])
end
def extract_vars({:atm,_}, vars) do
vars
end
def extract_vars(:ignore,vars) do
  vars
end
def extract_vars({:var, var}, vars) do
  [var | vars]
end
def extract_vars({:cons, head, tail}, vars) do
  extract_vars(tail, extract_vars(head,vars))
end


end
