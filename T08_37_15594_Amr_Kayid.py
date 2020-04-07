# T08_37_15594_Amr_Kayid
__author__ = "Amr Kayid"

import random
from pprint import pformat
from collections import namedtuple, OrderedDict

rl = namedtuple('rule', ['left', 'right'])


class CFG:
  """
  For this task you will implement the context-free grammar (CFG)
  left-recursion elimination algorithm introduced in Lecture 3 of CSEN1003.
  Recall that a CFG is a quadruple (V, Σ, R, S) where
  V and Σ are disjoint alphabets (respectively, containing variables and terminals),
  R ⊆ V ×(V ∪Σ)∗ is a set of rules,
  and S∈V is the start variable.

  """

  def __init__(self, description: str = ""):
    self.start_variable = 'S'
    self.variables = set(filter(str.isupper, description))
    self.terminals = set(filter(str.islower, description))
    self.desc = description.strip().split(';')
    self.rules = OrderedDict({
        i: v for i, v in enumerate([
            rl(
                left=rule.split(',')[0],
                right=tuple(rule.split(',')[1:]),
            ) for rule in self.desc
        ])
    })

    # print(pformat(vars(self)))

  def step(self, rule):
    lhs, rhs = rule.left, rule.right
    alphas = (t[1:] for t in rhs if t[0] == lhs)
    betas = (t for t in rhs if not (t[0] == lhs))
    lhs_new = lhs + '\''
    old_rule = rl(lhs, right=tuple([b + lhs_new for b in betas]))
    new_rule = rl(lhs_new, right=tuple([a + lhs_new for a in alphas] + ['']))
    return old_rule, new_rule

  def is_left_rec(self, rule):
    return any(rule.left == t[0] for t in rule.right)

  def con_2(self, rule):
    return any(v == t[0] for t in rule.right for v in self.variables)

  def step2(self, rule):
    new_rule = None
    for r in self.rules.values():
      l = []
      for t in rule.right:
        if r.left == t[0]:
          l.append([rt + t[1:] for rt in r.right])
        else:
          l.append([t])
      if len(l) > 0:
        rule = rl(rule.left, tuple(sum(l, [])))
      if self.is_left_rec(rule):
        rule, new_rule = self.step(rule)
      # print(rule, new_rule)
    return rule, new_rule

  def _run(self):
    i, new_cfg = 0, OrderedDict()
    for index, rule in self.rules.items():
      if self.is_left_rec(rule):
        rule_, new_rule = self.step(rule)
        self.rules[index] = rule_
        new_cfg[i], new_cfg[i + 1], i = rule_, new_rule, i + 2
      elif self.con_2(rule) and not (index == 0):
        new_cfg[i], new_rule = self.step2(rule)
        i += 1
        if not new_rule == None:
          new_cfg[i] = new_rule
          i += 1
      else:
        new_cfg[i] = rule
        i += 1

    return new_cfg

  def lre(self):
    output = self._run()
    out_str = "".join([
        f'{rule.left},{",".join(t for t in rule.right)};'
        for rule in output.values()
    ])
    return out_str


if __name__ == '__main__':
  inputs = [
      "S,ScT,T;T,aSb,iaLb,i;L,SdL,S",
      "S,Sa,b",
      "S,Sab,cd",
      "S,SuS,SS,Ss,lSr,a",
      "S,SuT,T;T,TF,F;F,Fs,P;P,a,b",
      "S,z,To;T,o,Sz",
      "S,BC,C;B,Bb,b;C,SC,a",
  ]
  outputs = [
      "S,TS';S',cTS',;T,aSb,iaLb,i;L,aSbS'dL,iaLbS'dL,iS'dL,aSbS',iaLbS',iS';",
      "S,bS';S',aS',;",
      "S,cdS';S',abS',;",
      "S,lSrS',aS';S',uSS',SS',sS',;",
      "S,TS';S',uTS',;T,FT';T',FT',;F,PF';F',sF',;P,a,b;",
      "S,z,To;T,oT',zzT';T',ozT',;",
      "S,BC,C;B,bB';B',bB',;C,bB'CCC',aC';C',CC',;",
  ]
  for i, s in enumerate(inputs):
    cfg = CFG(s)
    out = cfg.lre()
    if (out == outputs[i]):
      print(f"[{True}] String: {s:>30} ==> Output: {out}")
    else:
      print(f"[!{True}] String: {s:>30} ==> Output: {out}")
