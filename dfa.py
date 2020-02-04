import random


class DFA:
  """[summary]
  Recall that a DFA is a quintuple (Q, Σ, δ, q0, F ): 
    - Q is a non-empty, finite set of states; 
    - Σ is non-empty, finite set of symbols (an alphabet); 
    - δ : Q × Σ −→ Q is the transition function; 
    - q0 ∈ Q is the start state; 
    - and F ⊆ Q is the set of accept states. 
    
  A DFA accepts a string w = w1w2 ···wn ∈ Σ∗ 
  if there is a sequence r0,r1,...,rn of states such that 
    - (i) r0 = q0, 
    - (ii) rn ∈ F, and 
    - (iii) δ(ri,wi+1) = ri+1, for every 0 ≤ i < n.
    
  We make the following assumptions for simplicity.
    a) The alphabet Σ is always the binary alphabet {0,1}.
    b) The set of states Q is always of the form {0,...,n}, for some n ∈ N.
    c) The start state is always state 0.

  """

  def __init__(self, description: str = "0,0,1;1,2,1;2,0,3;3,3,3#1,3"):
    """[summary]
    
    Keyword Arguments:
        description {str} -- [A string describing a DFA is of the form P#S, where P is a prefix representing the transition function δ and S is a suffix representing the set F of accept state.] (default: {"0,0,1;1,2,1;2,0,3;3,3,3#1,3"})
    """
    self.alphabet = {0, 1}
    self.initial_state = 0
    self.current_state = self.initial_state
    self.desc = description.strip().split('#')
    self.transition_states = self.desc[0].split(';')
    self.accepted_states = set(self.desc[1].split(','))

  def step(self, c):
    """[summary]
    • self.transition_states (P) is a semicolon-separated sequence of triples of states;
     each triple is a comma-separated sequence of states. 
     A triple i,j,k means that 
      - δ(i,0) = j and 
      - δ(i,1) = k.
    Arguments:
        c {[char]} -- [the current character in the string]
    """
    index = int(self.current_state)
    state = self.transition_states[index].split(',')
    if c == '0':
      self.current_state = state[1]
    else:
      self.current_state = state[2]

  def reset(self):
    """[summary]
    reset the current state to the initial state
    """
    self.current_state = self.initial_state

  def run(self, string: str = ""):
    """[summary]
    run simulates the operation of the constructed DFA on a given binary string. It returns true if the string is accepted by the DFA and false otherwise.
    
    Keyword Arguments:
        string {str} -- [the testing string] (default: {""})
    
    Returns:
        [Boolean] -- [true if the string is accepted by the DFA and false otherwise.]
    """
    for c in string:
      self.step(c)
    is_accepted = self.current_state in self.accepted_states
    self.reset()
    return f"String: {string} => {is_accepted}"


if __name__ == '__main__':
  dfa = DFA("0,0,1;1,2,1;2,0,3;3,3,3;4,0,0#0,2")
  strings_list = [
      ''.join(random.choice("01")
              for i in range(random.randint(1, 10)))
      for j in range(10)
  ]
  for string in strings_list:
    print(dfa.run(string))
