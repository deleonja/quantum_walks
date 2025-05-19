(* ::Package:: *)

BeginPackage["QuantumWalks`"]


ClearAll[
  Shift, Coin, DTQWStep, DTQW, PositionProbabilityDistribution, KetBra
]


Shift::usage = "Shift[t] constructs the sparse shift matrix for a DTQW at time t."
Coin::usage = "Coin[t] or Coin[t, c] returns the coin operator (default Fourier matrix)."
DTQWStep::usage = "DTQWStep[t] or DTQWStep[t, c] returns the full unitary step operator."
DTQW::usage = "DTQW[psi0, t] or DTQW[psi0, t, c] evolves initial state psi0 for t steps."
PositionProbabilityDistribution::usage = "PositionProbabilityDistribution[psi, tmax] computes total position probability at each site."
KetBra::usage = "KetBra[psi] returns the density matrix |psi\:27e9\:27e8psi|."


Begin["`Private`"]


Shift[t_] := SparseArray[
  Join[
    Table[{i, i + 2}, {i, Range[2, # - 2, 2]}],
    Table[{i, i - 2}, {i, Range[3, #, 2]}]
  ] -> 1., {#, #}] &[2*(2*t + 1)]


Coin[t_] := KroneckerProduct[
  IdentityMatrix[2 t + 1, SparseArray],
  SparseArray[FourierMatrix[2]]
]

Coin[t_, c_] := KroneckerProduct[
  IdentityMatrix[2 t + 1, SparseArray],
  c
]


DTQWStep[t_] := Shift[t] . Coin[t]
DTQWStep[t_, c_] := Shift[t] . Coin[t, c]
DTQWStep[t_, c_, psi_] := Chop[DTQWStep[t, c] . ArrayPad[psi, 2]]


DTQW[psi0_, t_] := Module[{psi},
  psi = ArrayPad[psi0, 2];
  Do[psi = ArrayPad[Chop[DTQWStep[i] . psi], 2], {i, t}];
  psi
]

DTQW[psi0_, t_, c_] := Module[{psi},
  psi = ArrayPad[psi0, 2];
  Do[psi = ArrayPad[Chop[DTQWStep[i, c] . psi], 2], {i, t}];
  psi
]


PositionProbabilityDistribution[psi_, tmax_] := Chop[
  Total[Abs[psi[[# ;; # + 1]]]^2] & /@ Range[1, 2*(2*tmax + 3), 2]
]


(* ::Text:: *)
(*Esta funcion tiene mas sentido que la pase a QMB:*)


KetBra[psi_] := Transpose[{psi}] . Conjugate[{psi}]


End[]


EndPackage[]
