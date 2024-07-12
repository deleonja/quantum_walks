(* ::Package:: *)

BeginPackage["QuantumWalks`"];


InitializeQW::usage="Initialize the sizes of the quantum walk 'cuz idk what else to do."


JAToVec::usage="Transform JA notation to vector states."


Shift::usage="Apply the shift operator
otra definicion."


MakeCoin::usage="Create the coin operator."


Coin::usage="Apply (C\[TensorProduct]I)."


Begin["`Private`"];


InitializeQW[coinSz_,posSz_]:=(
{coinB,posB,coinSize,posSize}={IdentityMatrix@coinSz,IdentityMatrix@posSz,coinSz,posSz};
ShiftMat=KroneckerProduct[
{coinB[[1]]}\[Transpose] . {coinB[[1]]},Sum[{posB[[i+1]]}\[Transpose] . {posB[[i]]},{i,1,posSize-1}]
]+KroneckerProduct[
{coinB[[2]]}\[Transpose] . {coinB[[2]]},Sum[{posB[[i-1]]}\[Transpose] . {posB[[i]]},{i,2,posSize}]
];
)


(* ::Input::Initialization:: *)
JAToVec[state_,nsteps_]:=Total[#[[1]] KroneckerProduct[{coinB[[#[[2]]+1]]}\[Transpose],{posB[[#[[3]]+nsteps+1]]}\[Transpose]]&/@state]


MakeCoin[r_,\[Theta]_,\[Phi]_]:=CoinMat={{Sqrt[r],Sqrt[1-r]Exp[I \[Theta]]},{Sqrt[1-r]Exp[I \[Theta]],-Sqrt[r]Exp[I(\[Theta]+\[Phi])]}};


Shift[state_]:=ShiftMat . state


Shift[state_,2]:=ShiftMat . rho . ShiftMat


Coin[state_]:=KroneckerProduct[CoinMat,posB] . state


End[];


EndPackage[];
