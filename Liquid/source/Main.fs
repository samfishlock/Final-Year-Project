namespace Microsoft.Research.Liquid

module UserSample =
    open System
    open Util
    open Operations
    //open Native             // Support for Native Interop
    //open HamiltonianGates   // Extra gates for doing Hamiltonian simulations
    //open Tests              // All the built-in tests

    /// <summary>
    /// Performs an arbitrary rotation around X. 
    /// </summary>
    /// <param name="theta">Angle to rotate by</param>
    /// <param name="qs">The head qubit of this list is operated on.</param>
    let rotX (theta:float) (qs:Qubits) =
        let gate (theta:float) =
            let nam     = "Rx" + theta.ToString("F2")
            new Gate(
                Name    = nam,
                Help    = sprintf "Rotate in X by: %f" theta,
                Mat     = (
                    let phi     = theta / 2.0
                    let c       = Math.Cos phi
                    let s       = Math.Sin phi
                    CSMat(2,[0,0,c,0.;0,1,0.,-s;1,0,0.,-s;1,1,c,0.])),
                Draw    = "\\gate{" + nam + "}"
                )
        (gate theta).Run qs

    let qFunc (qs:Qubits) = 
        H qs
        M qs

    [<LQD>]
    let __UserSample() =
        let stats = Array.create 2 0
        let k = Ket(1)
        for i in 0..9999 do
            let qs = k.Reset(1)
            qFunc qs
            let v = qs.Head.Bit.v
            stats.[v] <- stats[v] + 1
        show "Measured: 0 = %d%, 1= %d%" stats.[0] stats.[1]
    

module Main =
    open App

    /// <summary>
    /// The main entry point for Liquid.
    /// </summary>
    [<EntryPoint>]
    let Main _ =
        RunLiquid ()
