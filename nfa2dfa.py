import random
from pprint import pformat
from collections import namedtuple

tfns = namedtuple('transition_fns', ['zeros', 'ones', 'eps'])
ts = namedtuple('transition_state', ['zero', 'one'])

int_ = (lambda list: [int(num) for num in list])
tuples = (
    lambda list:
    [tuple(int_(transition_state.split(','))) for transition_state in list])


class NFA2DFA:
  """[summary]
  Recall that an NFA is a quintuple (Q, Σ, δ, q0, F ): 
    - Q is a non-empty, finite set of states; 
    - Σ is non-empty, finite set of symbols (an alphabet); 
    - δ : Q × (Σ ∪ {ε}) −→ P(Q) is the transition function; 
    - q0 ∈ Q is the start state; 
    - and F ⊆ Q is the set of accept states.
    
  >>> Given a description of an NFA, you need to construct an equivalent DFA.
  """

  def __init__(self, description: str = ""):
    self.alphabet = {0, 1}
    self.initial_state = (0,)
    self.current_state = self.initial_state
    self.desc = description.strip().split('#')
    self.accepted_states = set(int_(self.desc[-1].split(',')))
    self.transition_fns = tfns(
        zeros=tuples(self.desc[0].split(';')),
        ones=tuples(self.desc[1].split(';')),
        eps=tuples(self.desc[2].split(';')),
    )

    self.processing_queue = [
        self.eps_closure(self.current_state),
    ]

    self.transition_states = {}

    self.convert()

    print(pformat(vars(self)))

  def eps_closure(self, state_tuple):
    new_state = set()
    for state in state_tuple:
      new_state.update(set([state]))
      new_state.update(
          set([
              state_trans[1]
              for state_trans in self.transition_fns.eps
              if state == state_trans[0]
          ]))

    return new_state

  def trans_fn(self, state_set):
    to_zero, to_one = set(), set()
    for state in state_set:
      to_zero.update(
          set([
              state_trans[1]
              for state_trans in self.transition_fns.zeros
              if state == state_trans[0]
          ]))
      to_one.update(
          set([
              state_trans[1]
              for state_trans in self.transition_fns.ones
              if state == state_trans[0]
          ]))
    return to_zero, to_one

  def convert(self):
    while len(self.processing_queue) > 0:
      state = self.processing_queue.pop()
      to_zero, to_one = self.trans_fn(state)
      to_zero_state = self.eps_closure(to_zero)
      to_one_state = self.eps_closure(to_one)

      if tuple(to_zero_state) not in self.transition_states:
        self.processing_queue.append(to_zero_state)
      if tuple(to_one_state) not in self.transition_states:
        self.processing_queue.append(to_one_state)

      self.transition_states[tuple(state)] = ts(
          zero=to_zero_state,
          one=to_one_state,
      )

  def reset(self):
    """[summary]
    reset the current state to the initial state
    """
    self.current_state = self.initial_state

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
    index = tuple(self.current_state)
    transition_state = self.transition_states[index]
    self.current_state = transition_state.zero if c == '0' else transition_state.one

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
    is_accepted = len(self.current_state & self.accepted_states) > 0
    self.reset()
    return f"String: {string:>10} => {is_accepted}"


if __name__ == '__main__':
  nfa2dfa = NFA2DFA("0,0;1,2;3,3#0,0;0,1;2,3;3,3#1,2#3")

  strings_list = [
      ''.join(random.choice("01")
              for i in range(random.randint(1, 10)))
      for j in range(10)
  ]
  for string in strings_list:
    print(nfa2dfa.run(string))