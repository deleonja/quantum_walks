(* ::Package:: *)

BeginPackage["QuantumWalks`"];


Coin::usage = "Coin[ket]. ket={c(m,p), m , p}. Haddamard operator for now.
Coin[rho,2]. rho={Psi(m,p,n,q),m,p,n,q}.";


CoinMatrix::usage = "CoinMatrix[Theta, t]. Theta = Pi/4 es Haddamard con fase relativa, t: pasos temporales DTQW.";


Shift::usage = "Shift[ket]. ket={c(m,p), m , p}. Unbounded shift operator.
Shift[rho, 2]. rho={Psi(m,p,n,q),m,p,n,q}.";


DTQW::usage = "DTQW[psi0, timeSteps]. psi0={{c1(m1,p1),m1,p1},...,{cN(mN,pN),mN,pN}}, timeSteps: n\[UAcute]mero entero.
DTQW[rho0, timeSteps, 2] rho0={{Psi(m1,p1,n1,q1),m1,p1,n1,q1},...,{Psi(mN,pN,nN,qN),mN,pN,nN,qN}}";


DTQWTimeStep::usage "DTQW[psi]. psi={{c1(m1,p1),m1,p1},...,{cN(mN,pN),mN,pN}}.";


PartialTrace::usage = "PartialTrace[psi] returns the coin's reduced density matrix. psi={{c1(m1,p1),m1,p1},...,{cN(mN,pN),mN,pN}}";


BlochVector::usage = "BlochVector[rho]. rho = 2x2 matrix.";


DensityMatrix::usage = "DensityMatrix[psi] returns {{Psi(m1,p1,n1,q1),m1,p1,n1,q1},...,{Psi(mN,pN,nN,qN),mN,pN,nN,qN}} given a psi in form {c(m,p),m,p}.";


Begin["`Private`"];


(*We are using the coin operator of Eq. (4) of arXiv:2311.15801. 
This form of the coin has the advantage that always introduce a relative phase between states |0> and |1>*)
CoinMatrix[\[Theta]_,t_]:=N[KroneckerProduct[{{Cos[\[Theta]],-I Sin[\[Theta]]},{-I Sin[\[Theta]],Cos[\[Theta]]}},IdentityMatrix[2*t+1]]]


Coin[ket_]:=Which[#[[2]]==0,{{#[[1]]/Sqrt[2.],0,#[[3]]},{#[[1]]/Sqrt[2.],1,#[[3]]}},#[[2]]==1,{{#[[1]]/Sqrt[2.],0,#[[3]]},{-#[[1]]/Sqrt[2.],1,#[[3]]}}]&[ket]


Coin[\[Rho]_,2]:=Flatten[Table[{#1/2Power[-1,r*#2+s*#4],r,#3,s,#5},{r,0,1},{s,0,1}]&@@\[Rho],1]


Shift[ket_]:=Which[#[[2]]==0,ReplacePart[#,3->#[[3]]+1],#[[2]]==1,ReplacePart[#,3->#[[3]]-1]]&[ket]


Shift[\[Rho]_,2]:=Flatten[Table[{#1 KroneckerDelta[r,#2]KroneckerDelta[s,#4],r,#3+Power[-1,r],s,#5+Power[-1,s]},{r,0,1},{s,0,1}]&@@\[Rho],1]


DTQW[psi0_,timeSteps_]:=Module[{psi},
psi=psi0;
(*Para cada paso temporal:*)
Do[
(*aplicar la Moneda y Shift al estado psi*)
psi=Shift/@Flatten[Coin/@#,1]&[psi];
(*juntar los kets que son iguales*)
psi=Join[{Total[#[[All,1]]]},#[[1,2;;]]]&/@GatherBy[psi,{#[[2]],#[[3]]}&];
(*si alg\[UAcute]n ket tiene amplitud de prob 0, quitarlo*)
psi=If[#[[1]]!=0,#,Nothing]&/@psi,
{t,timeSteps}];
psi
]


DTQWTimeStep[psi0_]:=Module[{psi},
psi=psi0;
(*aplicar la Moneda y Shift al estado psi*)
psi=Shift/@Flatten[Coin/@#,1]&[psi];
(*juntar los kets que son iguales*)
psi=Join[{Total[#[[All,1]]]},#[[1,2;;]]]&/@GatherBy[psi,{#[[2]],#[[3]]}&];
(*si alg\[UAcute]n ket tiene amplitud de prob 0, quitarlo*)
If[#[[1]]!=0,#,Nothing]&/@psi
]


DTQW[rho0_,timeSteps_,2]:=Module[{rho},
rho=rho0;
(*Para cada paso temporal:*)
Do[
(*aplicar la Moneda y Shift al estado psi*)
rho=Flatten[Shift[#,2]&/@Flatten[Coin[#,2]&/@rho,1],1];
(*juntar los kets que son iguales*)
rho=Join[{Total[#[[All,1]]]},#[[1,2;;]]]&/@GatherBy[rho,{#[[2]],#[[3]],#[[4]],#[[5]]}&];
(*si alg\[UAcute]n ket tiene amplitud de prob 0, quitarlo*)
rho=If[#[[1]]!=0,#,Nothing]&/@rho,
{t,timeSteps}];
rho
]


PartialTrace[psi_]:=Normal[Sum[Total[Map[SparseArray[{#1[[2]],#2[[2]]}+1->#1[[1]]*Conjugate[#2[[1]]],{2,2}]&@@#&,Tuples[Select[psi,Last[#]==p&],2]]],{p,DeleteDuplicates[psi[[;;,-1]]]}]](*quiz\[AAcute]s se puede hacer m\[AAcute]s entendible. Explicar despues!!!*)


BlochVector[\[Rho]_]:=Chop[Tr[PauliMatrix[#] . \[Rho]]]&/@{1,2,3}


DensityMatrix[psi_]:={#1[[1]]*#2[[1]],#1[[2]],#1[[3]],#2[[2]],#2[[3]]}&@@#&/@Tuples[psi,2]


End[];


EndPackage[];
