% Test Cases

% ?- s(T, [The, young, boy, who, worked, for, the, old, man, pushed, and, stored, a, big, box, in, the, large, empty, room, after, school], []).

% ?- s(T, [The, old, woman, and, the, old, man, gave, the, poor, young, man, whom, they, liked, a, white, envelope, in, the, shed, behind, the, building], []).

% ?- s(T, [Every, boy, quickly, climbed, some, big, tree, while, every, girl, secretly, watched, some, boy], []).

% ?- s(T, [Some, brilliant, students, and, many, professors, watched, and, admired, talented, lecturers, and, appreciated, bright, scientists, and, researchers], []).

%%%%%%%%%%%%%%%%%%%%%%%%

% Sentence
s(s(NP, VP, S0)) -->
  noun_phrase(NP),
  verb_phrase(VP),
  claus(S0).

s(s(NP, VP, R, S0)) -->
  noun_phrase(NP),
  relative(R),
  verb_phrase(VP),
  claus(S0).

s(s(NP0, VP, S0, NP1)) -->
  noun_phrase(NP0),
  verb_phrase(VP),
  claus(S0),
  noun_phrase(NP1).

s(s(NP0, VP, S0, R, NP1)) -->
  noun_phrase(NP0),
  relative(R),
  verb_phrase(VP),
  claus(S0),
  noun_phrase(NP1).

s(s(NP0, VP0, S0, R, NP1, VP1, S1)) -->
  noun_phrase(NP0),
  verb_phrase(VP0),
  claus(S0),
  relative(R),
  noun_phrase(NP1),
  verb_phrase(VP1),
  claus(S1).

claus(claus(NP)) -->
  noun_phrase(NP).

claus(claus(NP, S0)) -->
  noun_phrase(NP),
  claus(S0).

claus(claus(NP, VP, S0)) -->
  noun_phrase(NP),
  verb_phrase(VP),
  claus(S0).

claus(claus(NP, C, VP)) -->
  noun_phrase(NP),
  conjunction(C),
  verb_phrase(VP).


%%%%%%%%%%%%%%

% Noun Phrase 
noun_phrase(np(N)) -->
  noun(N).

noun_phrase(np(N)) -->
  pronoun(N).

noun_phrase(np(D, NP)) -->
  determiner(D),
  noun_phrase(NP).

noun_phrase(np(P, NP)) -->
  preposition(P),
  noun_phrase(NP). 

noun_phrase(np(D, A, NP)) -->
  determiner(D),
  adjective(A),
  noun_phrase(NP).

noun_phrase(np(A, NP)) -->
  adjective(A),
  noun_phrase(NP). 

noun_phrase(np(NP0, C, NP)) -->
  noun_phrase0(NP0),
  conjunction(C),
  noun_phrase(NP). 

noun_phrase0(np0(N)) -->
  noun(N).

noun_phrase0(np0(D, NP0)) -->
  determiner(D),
  noun_phrase0(NP0).

noun_phrase0(np0(P, NP0)) -->
  preposition(P),
  noun_phrase0(NP0). 

noun_phrase0(np0(D, A, NP0)) -->
  determiner(D),
  adjective(A),
  noun_phrase0(NP0). 

noun_phrase0(np0(A, NP0)) -->
  adjective(A),
  noun_phrase0(NP0). 


%%%%%%%%%%%%%%

% Verb Phrase
verb_phrase(vp(V)) -->
  verb(V).

verb_phrase(vp(AV, VP)) -->
  adverb(AV),
  verb_phrase(VP).

verb_phrase(vp(V, C, VP)) -->
  verb(V),
  conjunction(C),
  verb_phrase(VP).


%%%%%%%%%%%%%%

%determiners
determiner(det(a)) -->
  [a].
determiner(det(an)) -->
  [an].

determiner(det(the)) -->
  [the].

determiner(det(this)) -->
  [this].
determiner(det(that)) -->
  [that].

determiner(det(my)) -->
  [my].
determiner(det(your)) -->
  [your].
determiner(det(his)) -->
  [his].
determiner(det(her)) -->
  [her].
determiner(det(our)) -->
  [our].
determiner(det(their)) -->
  [their].

determiner(det(these)) -->
  [these].
determiner(det(those)) -->
  [those].

determiner(det(some)) -->
  [some].
determiner(det(every)) -->
  [every].
determiner(det(many)) -->
  [many].
determiner(det(more)) -->
  [more].
determiner(det(much)) -->
  [much].
determiner(det(few)) -->
  [few].

determiner(det(any)) -->
  [any].
determiner(det(each)) -->
  [each].
determiner(det(all)) -->
  [all].


%%%%%%%%%%%%%%

%Pronouns
pronoun(pnoun(i)) -->
  [i].
pronoun(pnoun(we)) -->
  [we].
pronoun(pnoun(you)) -->
  [you].
pronoun(pnoun(he)) -->
  [he].
pronoun(pnoun(she)) -->
  [she].
pronoun(pnoun(it)) -->
  [it].
pronoun(pnoun(they)) -->
  [they].

%%%%%%%%%%%%%%

%nouns
noun(noun(boy)) -->
  [boy].
noun(noun(girl)) -->
  [girl].

noun(noun(man)) -->
  [man].
noun(noun(woman)) -->
  [woman].
noun(noun(lady)) -->
  [lady].

noun(noun(person)) -->
  [person].
noun(noun(people)) -->
  [people].

noun(noun(students)) -->
  [students].
noun(noun(professors)) -->
  [professors].
noun(noun(lecturers)) -->
  [lecturers].
noun(noun(scientists)) -->
  [scientists].
noun(noun(researchers)) -->
  [researchers].

noun(noun(building)) -->
  [building].
noun(noun(apartment)) -->
  [apartment].
noun(noun(room)) -->
  [room].
noun(noun(school)) -->
  [school].

noun(noun(box)) -->
  [box].
noun(noun(envelope)) -->
  [envelope].
noun(noun(shed)) -->
  [shed].
noun(noun(tree)) -->
  [tree].
noun(n(flowers)) -->
  [flowers].

noun(n(car)) -->
  [car].

noun(n(cat)) -->
  [cat].
noun(n(dog)) -->
  [dog].

noun(n(boy)) -->
  [boy].
noun(n(who)) -->
  [who].
noun(n(boys)) -->
  [boys].
noun(n(box)) -->
  [box].
noun(n(boxes)) -->
  [boxes].
noun(n(room)) -->
  [room].
noun(n(rooms)) -->
  [rooms].
noun(n(school)) -->
  [school].
noun(n(schools)) -->
  [schools].
noun(n(envelope)) -->
  [envelope].
noun(n(envelopes)) -->
  [envelopes].
noun(n(shed)) -->
  [shed].
noun(n(sheds)) -->
  [sheds].
noun(n(building)) -->
  [building].
noun(n(buildings)) -->
  [buildings].
noun(n(tree)) -->
  [tree].
noun(n(trees)) -->
  [trees].
noun(n(girl)) -->
  [girl].
noun(n(girls)) -->
  [girls].
noun(n(student)) -->
  [student].
noun(n(students)) -->
  [students].
noun(n(professor)) -->
  [professor].
noun(n(professors)) -->
  [professors].
noun(n(lecturer)) -->
  [lecturer].
noun(n(lecturers)) -->
  [lecturers].
noun(n(scientist)) -->
  [scientist].
noun(n(scientists)) -->
  [scientists].
noun(n(researcher)) -->
  [researcher].
noun(n(researchers)) -->
  [researchers].
noun(n(woman)) -->
  [woman].
noun(n(women)) -->
  [women].
noun(n(man)) -->
  [man].
noun(n(men)) -->
  [men].


%%%%%%%%%%%%%%

%verbs
verb(verb(was)) -->
  [was].
verb(verb(were)) -->
  [were].
verb(verb(ate)) -->
  [ate].
verb(verb(ran)) -->
  [ran].
verb(verb(pushed)) -->
  [pushed].
verb(verb(worked)) -->
  [worked].
verb(verb(stored)) -->
  [stored].
verb(verb(gave)) -->
  [gave].
verb(verb(climbed)) -->
  [climbed].
verb(verb(watched)) -->
  [watched].
verb(verb(admired)) -->
  [admired].
verb(verb(appreciated)) -->
  [appreciated].
verb(verb(saw)) -->
  [saw].
verb(verb(appreciated)) -->
  [appreciated].
verb(verb(ran)) -->
  [ran].
verb(verb(walked)) -->
  [walked].
verb(verb(studied)) -->
  [studied].
verb(verb(teached)) -->
  [teached].
verb(verb(jumped)) -->
  [jumped].
verb(verb(advised)) -->
  [advised].
verb(verb(loved)) -->
  [loved].
verb(verb(warned)) -->
  [warned].
verb(verb(missed)) -->
  [missed].
verb(verb(hated)) -->
  [hated].
verb(v(work)) -->
  [work].
verb(v(worked)) -->
  [worked].
verb(v(push)) -->
  [push].
verb(v(pushed)) -->
  [pushed].
verb(v(store)) -->
  [store].
verb(v(stored)) -->
  [stored].
verb(v(give)) -->
  [give].
verb(v(gave)) -->
  [gave].
verb(v(climb)) -->
  [climb].
verb(v(climbed)) -->
  [climbed].
verb(v(watch)) -->
  [watch].
verb(v(watched)) -->
  [watched].
verb(v(admire)) -->
  [admire].
verb(v(admired)) -->
  [admired].
verb(v(appreciate)) -->
  [appreciate].
verb(v(appreciated)) -->
  [appreciated].
verb(v(take)) -->
  [take].
verb(v(took)) -->
  [took].
verb(v(become)) -->
  [become].
verb(v(became)) -->
  [became].
verb(v(run)) -->
  [run].
verb(v(ran)) -->
  [ran].
verb(v(look)) -->
  [look].
verb(v(looked)) -->
  [looked].
verb(v(love)) -->
  [love].
verb(v(loved)) -->
  [loved].
verb(v(like)) -->
  [like].
verb(v(liked)) -->
  [liked].
verb(v(taste)) -->
  [taste].
verb(v(tasted)) -->
  [tasted].
verb(v(sleep)) -->
  [sleep].
verb(v(slept)) -->
  [slept].
verb(v(eat)) -->
  [eat].
verb(v(ate)) -->
  [ate].
verb(v(drink)) -->
  [drink].
verb(v(drank)) -->
  [drank].
verb(v(smoke)) -->
  [smoke].
verb(v(smoked)) -->
  [smoked].
verb(v(study)) -->
  [study].
verb(v(studied)) -->
  [studied].
verb(v(go)) -->
  [go].
verb(v(went)) -->
  [went].
verb(v(swim)) -->
  [swim].
verb(v(swam)) -->
  [swam].

%%%%%%%%%%%%%%

%Relatives
relative(r(who)) -->
  [who].
relative(r(whom)) -->
  [whom].

%%%%%%%%%%%%%%

%conjunctions
conjunction(conj(and)) -->
  [and].
conjunction(conj(or)) -->
  [or].
conjunction(conj(while)) -->
  [while].
conjunction(conj(nor)) -->
  [nor].
conjunction(conj(yet)) -->
  [yet].
conjunction(conj(but)) -->
  [but].

%%%%%%%%%%%%%%

%preposition
preposition(ppos(in)) -->
  [in].
preposition(ppos(on)) -->
  [on].
preposition(ppos(at)) -->
  [at].

preposition(ppos(for)) -->
  [for].
preposition(ppos(to)) -->
  [to].
preposition(ppos(into)) -->
  [into].

preposition(ppos(under)) -->
  [under].
preposition(ppos(below)) -->
  [below].
preposition(ppos(above)) -->
  [above].
preposition(ppos(over)) -->
  [over].
preposition(ppos(behind)) -->
  [behind].

preposition(ppos(from)) -->
  [from].
preposition(ppos(off)) -->
  [off].
preposition(ppos(by)) -->
  [by].
preposition(ppos(towards)) -->
  [towards].

preposition(ppos(before)) -->
  [before].
preposition(ppos(after)) -->
  [after].

preposition(ppos(about)) -->
  [about].

preposition(ppos(across)) -->
  [across].
preposition(ppos(against)) -->
  [against].
preposition(ppos(among)) -->
  [among].

%%%%%%%%%%%%%%

%ADJECTIVES
adjective(adj(young)) -->
  [young].
adjective(adj(old)) -->
  [old].
adjective(adj(big)) -->
  [big].
adjective(adj(small)) -->
  [small].
adjective(adj(large)) -->
  [large].
adjective(adj(huge)) -->
  [huge].
adjective(adj(empty)) -->
  [empty].
adjective(adj(full)) -->
  [full].
adjective(adj(poor)) -->
  [poor].
adjective(adj(rich)) -->
  [rich].
adjective(adj(white)) -->
  [white].
adjective(adj(black)) -->
  [black].
adjective(adj(same)) -->
  [same].
adjective(adj(red)) -->
  [red].
adjective(adj(green)) -->
  [green].
adjective(adj(brilliant)) -->
  [brilliant].
adjective(adj(smart)) -->
  [smart].
adjective(adj(talented)) -->
  [talented].
adjective(adj(gifted)) -->
  [gifted].
adjective(adj(quick)) -->
  [quick].
adjective(adj(slow)) -->
  [slow].
adjective(adj(bright)) -->
  [bright].
adjective(adj(smelly)) -->
  [smelly].
adjective(adj(fast)) -->
  [fast].
adjective(adj(dedicated)) -->
  [dedicated].
adjective(adj(passionate)) -->
  [passionate].
adjective(adj(loyal)) -->
  [loyal].
adjective(adj(faithful)) -->
  [faithful].
adjective(adj(devoted)) -->
  [devoted].

%%%%%%%%%%%%%%

%ADVERBS
adverb(adv(quickly)) -->
  [quickly].
adverb(adv(secretly)) -->
  [secretly].
adverb(adv(quietly)) -->
  [quietly].
adverb(adv(smoothly)) -->
  [smoothly].
adverb(adv(heavily)) -->
  [heavily].
adverb(adv(subconsciously)) -->
  [subconsciously].
adverb(adv(easily)) -->
  [easily].
adverb(adv(happily)) -->
  [happily].
adverb(adv(honestly)) -->
  [honestly].
adverb(adv(intentionally)) -->
  [intentionally].
adverb(adv(suspisciously)) -->
  [suspisciously].
adverb(adv(quite)) -->
  [quite].
adverb(adv(completely)) -->
  [completely].
adverb(adv(really)) -->
  [really].
adverb(adv(so)) -->
  [so].
adverb(adv(too)) -->
  [too].
adverb(adv(enough)) -->
  [enough].
adverb(adv(almost)) -->
  [almost].
adverb(adv(very)) -->
  [very].
adverb(adv(while)) -->
  [while].
%%%%%%%%%%%%%%