// Copyright (c) 2015,2016 Microsoft Corporation

#if INTERACTIVE
#r @"..\bin\Liquid1.dll"                 
#else
namespace Microsoft.Research.Liquid // Tell the compiler our namespace
#endif

open System                         // Open any support libraries

open Microsoft.Research.Liquid      // Get necessary Liquid libraries
open Util                           // General utilites
open Operations                     // Basic gates and operations

module Script =   

    let rec convertToInt list n =
        match list with
        | '0'::tl -> 0 + convertToInt tl (n-1)
        | '1'::tl -> pown 2 n + convertToInt tl (n-1)
        | _::tl -> failwith "invalid input"
        | [] -> 0

    let setKet (ket:Ket) binStr = 
        let mutable n = 0
        for c in binStr do
            if c = '0' then ket.Qubits.[n].StateSet(1.0,0.0,0.0,0.0)
            elif c = '1' then ket.Qubits.[n].StateSet(0.0,0.0,1.0,0.0)
            else failwith "invalid input"
            n <- n + 1

    let binaryAdd qs = 
        H qs
        M qs   

    [<LQD>]
    let add(a:string) (b:string) =
        show "Input binary value of a: %s, b: %s" a b
        let ab = convertToInt (Seq.toList a) (String.length a - 1)
        let bb = convertToInt (Seq.toList b) (String.length b - 1)
        show "Corresponding integer values of a: %d, b: %d" ab bb

        let k1 = Ket(5)
        let k2 = Ket(5)  // Create two qubit registers to hold our integers
        setKet k1 a
        setKet k2 b
        show "Qubit register initial states are \nk1:\n%A,\nk2:\n%A" k1.Qubits k2.Qubits
        
        let circ = (k1.Join k2).Qubits
        binaryAdd circ
        show "Final state of qubits is: \n%A" circ



        // let qs = k.Qubits // qs is the list of qubits for the ket k
        // H qs // Hadamard on the first qubit
        // CNOT qs // CNOT on first and second qubits
        // M >< qs // measure all 5 qubits
        // show "First qubit after measurement %d" qs.[0].Bit.v
        // show "Second qubit after measurement %d" qs.[1].Bit.v