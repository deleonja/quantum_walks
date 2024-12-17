(* ::Package:: *)

(* Informaci\[OAcute]n para llenar luego *)


BeginPackage["MathDTQW`"];


Unprotect@@Names["MathDTQW`*"];


ClearAll@@Names["MathDTQW`*"];


InitializeDTQW::usage="InitializeDTQW[\!\(\*
StyleBox[\"c\", \"TI\"]\),\!\(\*
StyleBox[\"p\", \"TI\"]\)] creates the internal variables needed to simulate a DTQW, where \!\(\*
StyleBox[\"c\", \"TI\"]\) is the size of the coin space and \!\(\*
StyleBox[\"p\", \"TI\"]\) the size of the position space."


MakeCoin::usage="Given an specification it will build the appropriate operator (incomplete)"


MakeShift::usage="Given an specification it will build the appropriate shift operator (incomplete)."


MakeUnitary::usage="MakeUnitary[] "


VectorState::usage="VectorState[{{\!\(\*SubscriptBox[
StyleBox[\"a\", \"TI\"], 
StyleBox[\"1\", \"TI\"]]\),\!\(\*SubscriptBox[
StyleBox[\"c\", \"TI\"], 
StyleBox[\"1\", \"TI\"]]\),\!\(\*SubscriptBox[
StyleBox[\"p\", \"TI\"], 
StyleBox[\"1\", \"TI\"]]\)},...,{\!\(\*SubscriptBox[
StyleBox[\"a\", \"TI\"], 
StyleBox[\"n\", \"TI\"]]\),\!\(\*SubscriptBox[
StyleBox[\"c\", \"TI\"], 
StyleBox[\"n\", \"TI\"]]\),\!\(\*SubscriptBox[
StyleBox[\"p\", \"TI\"], 
StyleBox[\"n\", \"TI\"]]\)}}] creates a vector state given by the expression \!\(\*UnderoverscriptBox[\(\[Sum]\), \(\*
StyleBox[\"i\", \"TI\"] = 1\), 
StyleBox[\"n\", \"TI\"]]\)\!\(\*SubscriptBox[
StyleBox[\"a\", \"TI\"], 
StyleBox[\"i\", \"TI\"]]\)\!\(\*TemplateBox[{RowBox[{SubscriptBox[StyleBox[\"c\", \"TI\"], StyleBox[\"i\", \"TI\"]], \",\", SubscriptBox[StyleBox[\"p\", \"TI\"], StyleBox[\"i\", \"TI\"]]}]},\n\"Ket\"]\)."


DMatrixState::usage="DMatrixState[] creates a matrix given by the expression ...."


ValidVectorStateQ::usage="ValidVectorStateQ[\!\(\*
StyleBox[\"state\", \"TI\"]\)] gives \!\(\*TemplateBox[{Cell[TextData[\"True\"]], \"paclet:ref/True\"},\n\"RefLink\",\nBaseStyle->{\"InlineFormula\"}]\) if \!\(\*
StyleBox[\"state\", \"TI\"]\) is a valid VectorState, and \!\(\*TemplateBox[{Cell[TextData[\"False\"]], \"paclet:ref/False\"},\n\"RefLink\",\nBaseStyle->{\"InlineFormula\"}]\) otherwise."


ValidDMatrixStateQ::usage="ValidDMatrixStateQ[state] gives True if state is a valid DMatrixState, and False otherwise."


VectorStateToArray::usage="VectorStateToArray[\!\(\*
StyleBox[\"state\", \"TI\"]\)] transforms a \!\(\*
StyleBox[\"state\", \"TI\"]\) of VectorState into an Array."


DMatrixStateToMatrix::usage="DMatrixStateToMatrix[state] transforms a state of DMatrixState into a Matrix."


DTQW::usage="DTQW[\!\(\*
StyleBox[\"state\", \"TI\"]\),\!\(\*
StyleBox[\"n\", \"TI\"]\)] evaluates \!\(\*
StyleBox[\"n\", \"TI\"]\) steps in the DTQW with initial VectorState \!\(\*
StyleBox[\"state\", \"TI\"]\) using the Coin and Shift operators created by their respective functions.
DTQW[\!\(\*
StyleBox[\"state\", \"TI\"]\),\!\(\*
StyleBox[\"n\", \"TI\"]\)] evaluates \!\(\*
StyleBox[\"n\", \"TI\"]\) steps in the DTQW with initial DMatrixState \!\(\*
StyleBox[\"state\", \"TI\"]\) using the Coin and Shift operators created by their respective functions."


DTQW2::usage="DTQW2[\!\(\*
StyleBox[\"state\", \"TI\"]\),\!\(\*
StyleBox[\"n\", \"TI\"]\)] evaluates \!\(\*
StyleBox[\"n\", \"TI\"]\) steps in the DTQW with initial VectorState \!\(\*
StyleBox[\"state\", \"TI\"]\) using the Coin and Shift operators created by their respective functions.
DTQW2[\!\(\*
StyleBox[\"state\", \"TI\"]\),\!\(\*
StyleBox[\"n\", \"TI\"]\)] evaluates \!\(\*
StyleBox[\"n\", \"TI\"]\) steps in the DTQW with initial DMatrixState \!\(\*
StyleBox[\"state\", \"TI\"]\) using the Coin and Shift operators created by their respective functions."


DTQW2wDecoherence::usage="DTQW2wDecoherence[\!\(\*
StyleBox[\"state\", \"TI\"]\),\!\(\*
StyleBox[\"p\", \"TI\"]\),\!\(\*
StyleBox[\"n\", \"TI\"]\)] evaluates \!\(\*
StyleBox[\"n\", \"TI\"]\) steps in the DTQW with initial VectorState \!\(\*
StyleBox[\"state\", \"TI\"]\) using the Coin and Shift operators created by their respective functions and with \!\(\*
StyleBox[\"p\", \"TI\"]\) probability of getting a phase\[Dash]flip.
DTQW2wDecoherence[\!\(\*
StyleBox[\"state\", \"TI\"]\),\!\(\*
StyleBox[\"p\", \"TI\"]\),\!\(\*
StyleBox[\"n\", \"TI\"]\)] evaluates \!\(\*
StyleBox[\"n\", \"TI\"]\) steps in the DTQW with initial DMatrixState \!\(\*
StyleBox[\"state\", \"TI\"]\) using the Coin and Shift operators created by their respective functions and with \!\(\*
StyleBox[\"p\", \"TI\"]\) probability of getting a phase\[Dash]flip."


Begin["`Private`"];


(* Initializing functions *)


InitializeDTQW[coinSz_Integer,posSz_Integer]:=(
coinSize=coinSz;
posSize=posSz;
coinB=Transpose[{#}]&/@IdentityMatrix[coinSz];
posB=Transpose[{#}]&/@IdentityMatrix[posSz];
);


MakeCoin[r_,\[Theta]_,\[Phi]_]:=CoinMat={{Sqrt[r],Sqrt[1-r]Exp[I \[Theta]]},{Sqrt[1-r]Exp[I \[Theta]],-Sqrt[r]Exp[I(\[Theta]+\[Phi])]}}


MakeShift[]:=ShiftMat=KroneckerProduct[coinB[[1]] . coinB[[1]]\[ConjugateTranspose],Sum[posB[[i+1]] . posB[[i]]\[ConjugateTranspose],{i,1,posSize-1}]]+
KroneckerProduct[coinB[[2]] . coinB[[2]]\[ConjugateTranspose],Sum[posB[[i-1]] . posB[[i]]\[ConjugateTranspose],{i,2,posSize}]]


MakeUnitary[]:=UnitaryMat=ShiftMat . KroneckerProduct[CoinMat,IdentityMatrix[posSize]];


(* VectorState related functions *)


ValidVectorStateQ[state_VectorState]:=1==Sum[Abs[v]^2,{v,state[[1,;;,1]]}]


VectorStateToArray[state_VectorState?ValidVectorStateQ]:=Total[#[[1]] KroneckerProduct[coinB[[#[[2]]+Round[coinSize/2]]],posB[[#[[3]]+Round[(posSize+1)/2]]]]&/@state[[1]]] (* Esto est\[AAcute] incompleto (odds, evens) *)


DTQW[state_VectorState,n_Integer]:=MatrixPower[ShiftMat . KroneckerProduct[CoinMat,IdentityMatrix[posSize]],n] . N[VectorStateToArray[state]] (* Message advising the limit *)


DTQW2[state_VectorState,n_Integer]:=Module[
{U=ShiftMat . KroneckerProduct[CoinMat,IdentityMatrix[posSize]]},
Nest[Dot[U,#]&,N[VectorStateToArray[state]],n]
]


DTQW2wDecoherence[state_VectorState,p_?NumericQ,n_Integer]:=Module[
{U=UnitaryMat,K1,K2,rho},
(* Caminata cu\[AAcute]ntica con decoherencia calculada seg\[UAcute]n los operadores de Kraus *)
(* Calculo de operadores de Kraus *)
K1=Sqrt[p] U;
K2=Sqrt[1-p] KroneckerProduct[PauliMatrix[3],IdentityMatrix[posSize]] . U;
(* Calculo de la matriz densidad *)
rho=# . #\[ConjugateTranspose]&@N[VectorStateToArray[state]];
(* Calculo del canal cu\[AAcute]ntico *)
Nest[Chop[K1 . # . K1\[ConjugateTranspose]+K2 . # . K2\[ConjugateTranspose]]&,rho,n]
]


(* DMatrixState related functions *)


ValidDMatrixStateQ[state_DMatrixState]:=1==Sum[If[(#[[2]]==#[[4]])&&(#[[3]]==#[[5]]),#[[1]],0]&@v,{v,state[[1]]}]


DMatrixStateToMatrix[state_DMatrixState?ValidDMatrixStateQ]:=Total[#[[1]] 
KroneckerProduct[coinB[[#[[2]]+Round[coinSize/2]]],posB[[#[[3]]+Round[(posSize+1)/2]]]] . (KroneckerProduct[coinB[[#[[4]]+Round[coinSize/2]]],posB[[#[[5]]+Round[(posSize+1)/2]]]])\[ConjugateTranspose]&/@state[[1]]
]


DTQW[state_DMatrixState,n_Integer]:=MatrixPower[ShiftMat . KroneckerProduct[CoinMat,IdentityMatrix[posSize]],n] . N[DMatrixStateToMatrix[state]] . (MatrixPower[ShiftMat . KroneckerProduct[CoinMat,IdentityMatrix[posSize]],n])\[ConjugateTranspose]


DTQW2[state_DMatrixState,n_Integer]:=Module[
{U=UnitaryMat},
Nest[U . # . U\[ConjugateTranspose]&,N[DMatrixStateToMatrix[state]],n]
]


DTQW2wDecoherence[state_DMatrixState,p_?NumericQ,n_Integer]:=Module[
{U=UnitaryMat,K1,K2,rho},
K1=Sqrt[p] U;
K2=Sqrt[1-p] KroneckerProduct[PauliMatrix[3],IdentityMatrix[posSize]] . U;
rho=N[DMatrixStateToMatrix[state]];
Nest[Chop[K1 . # . K1\[ConjugateTranspose]+K2 . # . K2\[ConjugateTranspose]]&,rho,n]
]


End[];


Protect@@Names["MathDTQW`*"];


EndPackage[];
