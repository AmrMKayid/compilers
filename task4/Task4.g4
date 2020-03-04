grammar Task4;
prog: S1 | S2;
S1:( [0] | ([1]+[0][0]) )* [1]+ { System.out.print("01"); } ;
S2:( [0] | ([1]+[0][0]) )* [1]+[0] { System.out.print("10"); } ;