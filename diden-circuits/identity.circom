pragma circom 2.0.3;

include "../node_modules/circomlib/circuits/poseidon.circom";

template identity() {
  // signal input name;
  signal input countryCode;
  signal input dobTimestamp;
  signal input hash;

  component poseidon = Poseidon(2);
  poseidon.inputs[0] <== countryCode;
  poseidon.inputs[1] <== dobTimestamp;
  
  log(poseidon.out);
  hash === poseidon.out;

}

component main{public [countryCode, hash]} = identity();