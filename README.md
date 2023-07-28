# Noir-MiMCsponge

// MiMC-2p/p implementation \
// constants are (publicly generated) random numbers, for instance using keccak as a ROM.\
// You must use constants generated for the native field\
// Rounds number should be ~ log(p)/log(exp) log_5(21888242871839275222246405745257275088548364400416034343698204186575808495617) ~= 110\
// For 254 bit primes, exponent 5 and 220 rounds seems to be recommended\
