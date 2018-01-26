defmodule Huffman do

  def sample()do
    'the quick brown fox jumps over the lazy dog
     this is a sample text that we will use when we build
     up a table we will only handle lower case letters and
     no punctuation symbols the frequency will of course not
     represent english but it is probably not that far off'
  end

   def text, do: 'this is something that we should encode'

   def test do
     sample = sample()
     tree = tree(sample)
     encode = encode_table(tree)
     decode = decode_table(tree)
     text = text()
     seq = encode(text, encode)
     decode(seq, decode)
   end

#create a Huffman tree given a sample text.
#sample is a list of characters
def tree(sample) do
freq = freq(sample)
huffman(freq)
end

#build the huffmantree
def huffman([]) do
[]
end
def huffman(freq) do
sorted = List.keysort(freq, 1) #takes the 2nd element in the tuple and sort the list
huffmanTree(sorted)
end


def huffmanTree([{tree, _}]) do tree end #top node
def huffmanTree([{t1, f1}, {t2, f2} | t]) do
huffmanTree(insert({{t1, t2}, f1 + f2}, t)) #bygger trädet här mha rekursiv funktion
end

def insert({t1, f1}, []) do [{t1, f1}] end   #the last entry in the tree, at the top
def insert({t1, f1}, [{t2, f2} | rest]) when f1 < f2 do
  [{t1, f1}, {t2, f2} | rest]
end
def insert({t1, f1}, [{t2, f2} | rest]) do
  [{t2, f2} | insert({t1, f1}, rest)]
end

#return the frequency of each cahr in sample
#för att skicka med två parametrar
def freq(sample)do
  freq(sample,[])
end
#basfallet, när listan är tom och vi gått igenom alla karaktärer
def freq([], freq) do
  freq
end
#anropa update
def freq([char | rest], freq)do
  freq(rest, update(char, freq))
end

#update calculates the frequency in a list
#return a list of frequencies
def update(char,[]) do
  [{char, 1}]
end
#om matchar char med char, plussa på tupeln
def update(char, [{char, f} | freq])do
  [{char, f + 1} | freq]
end
def update(char, [elem | freq])do
  [elem | update(char, freq)]
end

#create an encoding table containing the mapping from characters to codes given a Huffman tree.
 def encode_table(tree) do
   codes(tree, [])
 end

 # Traverse the Huffman tree and build a binary encoding for each character.
 def codes({left, right}, path) do
   l = codes(left, [0 | path])
   r = codes(right, [1 | path])
   l ++ r
 end

#prints out the character for the given sequence
#since we begin on the top we have to reverse
 def codes(left, code) do
   [{left, Enum.reverse(code)}]
 end

#create an decoding table containing the mapping from codes to characters given a Huffman tree.
def decode_table(tree) do
codes(tree, [])
end
# Parse a string of text and encode it with the
# previously generated encoding table.
  def encode([], _), do: []
  def encode([char | rest], table) do
    {_, code} = List.keyfind(table, char, 0)
    code ++ encode(rest, table)
  end

#decode the bit sequence using the mapping in table, return a text.
def decode([], _) do
  []
end
def decode(seq, table) do
{char, rest} = decode_char(seq, 1, table)
[char | decode(rest, table)]
end

def decode_char(seq, n, table) do
{code, rest} = Enum.split(seq, n)

case List.keyfind(table, code, 1) do
  {char, _} ->
          {char, rest}
  nil ->
  decode_char(seq, n+1 , table)
end
end
end
