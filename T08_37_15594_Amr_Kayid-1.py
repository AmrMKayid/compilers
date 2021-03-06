# T08_37_15594_Amr_Kayid
__author__ = "Amr Kayid"

import random
from pprint import pformat
from collections import namedtuple

tfns = namedtuple('transition_fns', ['state', 'zero', 'one', 'action'])


class FDFA:
  """[summary]
  Recall that an FDFA is a sextuple (Q, Σ, δ, q0, F, A): 
    - Q is a non- empty, finite set of states; 
    - Σ is non-empty, finite set of symbols (an alphabet); 
    - δ : Q×Σ −→ Q is the transition function; 
    - q0 ∈ Q is the start state; F ⊆ Q is the set of accept states; 
    - and A is function that maps every state in Q to an action.
    
  Refer to the slides of Lecture 2 of CSEN1003 for more details about the operation of FDFA.
  >>> Given a description of an FDFA, 
  >>> you need to implement a fallback deterministic finite automaton with actions (FDFA).
  """

  def __init__(self, description: str = ""):
    self.alphabet = {0, 1}
    self.initial_state = '0'
    self.current_state = self.initial_state
    self.desc = description.strip().split('#')
    self.accepted_states = set((self.desc[-1].split(',')))
    self.transition_fns = [
        tfns(*state_ts.split(',')) for state_ts in self.desc[0].split(';')
    ]
    self.stack = []
    self.l_ptr = 0

    print(pformat(vars(self)))

  def reset(self):
    self.stack = []
    self.l_ptr = 0
    self.current_state = self.initial_state

  def step(self, c):
    index = int(self.current_state)
    transition_state = self.transition_fns[index]
    self.stack.append(transition_state)
    self.l_ptr += 1
    self.current_state = transition_state.zero if c == '0' else transition_state.one

  def _run(self, string: str = ""):
    if len(string) <= 0:
      return ""

    self.reset()
    for c in string:
      self.step(c)

    top_stack = self.transition_fns[int(self.current_state)]
    if top_stack.state in self.accepted_states:
      return top_stack.action

    while (len(self.stack) > 0):
      top_state = self.stack.pop()
      self.l_ptr -= 1

      if (self.l_ptr >= 0 and len(self.stack) > 0 and
          top_state.state in self.accepted_states):
        return top_state.action + self._run(string[self.l_ptr:])

    return top_stack.action

  def run(self, string: str = ""):
    output = self._run(string)
    self.reset()
    return f"String: {string:>10} => Action: {output}"


if __name__ == '__main__':
  print("\n\nFirst FallBack DFA\n\n")
  fdfa = FDFA("0,4,1,000;1,1,2,001;2,3,2,010;3,1,4,011;4,4,0,100#2,4")
  # print(fdfa.run("1011100"))

  strings_list = [
      "000",
      "101",
      "1110",
      "11000",
      "0110",
  ]
  for string in strings_list:
    print(fdfa.run(string))

  print("\n\nSecond FallBack DFA\n\n")
  fdfa = FDFA("0,1,1,000;1,4,2,001;2,2,3,010;3,4,0,011;4,2,4,100#4")

  strings_list = [
      "0101",
      "1001",
      "0011",
      "11100",
      "00",
  ]
  for string in strings_list:
    print(fdfa.run(string))

  strings_list = [
      ''.join(random.choice("01")
              for i in range(random.randint(1, 10)))
      for j in range(10)
  ]
  for string in strings_list:
    print(fdfa.run(string))
