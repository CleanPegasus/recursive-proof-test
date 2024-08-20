pragma circom 2.0.3;

include "../pairing-circuits/bn254/groth16.circom";

template didenRecursiveProof(publicInputCount) {

    var k = 6;
   // verification key
    signal input negalfa1xbeta2[6][2][k]; // e(-alfa1, beta2)
    signal input gamma2[2][2][k];
    signal input delta2[2][2][k];
    signal input IC[publicInputCount+1][2][k];

    // proof
    signal input negpa[2][k];
    signal input pb[2][2][k];
    signal input pc[2][k];
    signal input pubInput[publicInputCount];

    signal output out;

    component verifyProof = verifyProof(publicInputCount);

    verifyProof.negalfa1xbeta2 <== negalfa1xbeta2;
    verifyProof.gamma2 <== gamma2;
    verifyProof.delta2 <== delta2;
    verifyProof.IC <== IC;

    verifyProof.negpa <== negpa;
    verifyProof.pb <== pb;
    verifyProof.pc <== pc;
    verifyProof.pubInput <== pubInput;

    out <== verifyProof.out;
    log(out);
    
}

component main = didenRecursiveProof(2);