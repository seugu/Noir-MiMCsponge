#!/bin/bash

PHASE1=../../powersOfTau28_hez_final_12.ptau
CIRCUIT_NAME=testFeistelMimc

if [ -f "$PHASE1" ]; then
    echo "Found Phase 1 ptau file"
else
    echo "No Phase 1 ptau file found. Exiting..."
    exit 1
fi

echo $PWD

echo "****COMPILING CIRCUIT****"
start=`date +%s`
#circom "$CIRCUIT_NAME".circom --O0 --c --output "$BUILD_DIR"
circom "$CIRCUIT_NAME".circom --r1cs --sym --wasm
end=`date +%s`
echo "DONE ($((end-start))s)"

echo "****COMPILING JS WITNESS GENERATION CODE****"
start=`date +%s`
cd ./"$CIRCUIT_NAME"_js 
node generate_witness.js "$CIRCUIT_NAME".wasm ../input.json ../witness.wtns
end=`date +%s`
echo "DONE ($((end-start))s)"


echo "****GENERATING ZKEY 0****"
start=`date +%s`
cd ..
snarkjs groth16 setup "$CIRCUIT_NAME".r1cs "$PHASE1" "$CIRCUIT_NAME".zkey
end=`date +%s`
echo "DONE ($((end-start))s)"


echo "****EXPORTING VKEY****"
start=`date +%s`
snarkjs zkey export verificationkey "$CIRCUIT_NAME".zkey verification_key.json
end=`date +%s`
echo "DONE ($((end-start))s)"

echo "****GENERATING PROOF FOR SAMPLE INPUT****"
start=`date +%s`
snarkjs groth16 prove "$CIRCUIT_NAME".zkey witness.wtns proof.json public.json
end=`date +%s`
echo "DONE ($((end-start))s)"

echo "****VERIFYING PROOF FOR SAMPLE INPUT****"
start=`date +%s`
snarkjs groth16 verify verification_key.json public.json proof.json
end=`date +%s`
echo "DONE ($((end-start))s)"

echo "input.json" && cat input.json 
echo "proof.json" && cat public.json