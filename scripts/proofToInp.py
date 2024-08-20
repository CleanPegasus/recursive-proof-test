import json;

from vkeyToInp import Fpconvert, Fp2convert, FQ, FQ2;

with open('circuit-output/proof.json', 'r') as proof_file:
    proof_data = proof_file.read()
proof = json.loads(proof_data)

n = 43
k = 6

x, y, z = tuple([FQ((int(x))) for x in proof["pi_a"]]) 
negpi_a = (x / z, - (y / z))

x, y, z = tuple([ FQ2([int(x[0]), int(x[1])]) for x in proof["pi_b"]])
pi_b = (x / z, y / z)

x, y, z = tuple([FQ((int(x))) for x in proof["pi_c"]]) 
pi_c = (x / z, y / z)

proofParameters = {
    "negpa": [Fpconvert(negpi_a[0], n, k), Fpconvert(negpi_a[1], n, k)],
    "pb": [ Fp2convert(pi_b[0], n, k), Fp2convert(pi_b[1], n, k)],
    "pc": [Fpconvert(pi_c[0], n, k), Fpconvert(pi_c[1], n, k)],
}

print("proofParameters", proofParameters)

with open('circuit-output/pubSignals.json', 'r') as public_file:
    public_data = public_file.read()
pubInputs = json.loads(public_data)

pubParameters  = {
    "pubInput": [],
}
for pubInput in pubInputs:
    pubParameters["pubInput"].append(int(pubInput))

print("pubParameters", pubParameters)