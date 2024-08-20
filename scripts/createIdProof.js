
// const ethers = require("ethers");
const circomlibjs = require("circomlibjs");
const snarkjs = require("snarkjs");
const fs = require("fs");
const path = require("path");
const F1Field = require("ffjavascript").F1Field;
const Scalar = require("ffjavascript").Scalar;
exports.p = Scalar.fromString(
  "21888242871839275222246405745257275088548364400416034343698204186575808495617"
);
const Fr = new F1Field(exports.p);

async function poseidonHash(input) {
  const poseidon = await circomlibjs.buildPoseidon();
  const hash = poseidon(input);
  return poseidon.F.toString(hash);
}


async function main() {

  const preImages = [1, 1724132307,];

  const hash = await poseidonHash(preImages);

  console.log(hash);

  const {proof, publicSignals} = await snarkjs.groth16.fullProve(
    {
     dobTimestamp: 1724132307,
     countryCode: 1,
     hash: hash
    },
    "circuit-output/identity_js/identity.wasm",
    "circuit-output/identity_0001.zkey"
  );

}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });