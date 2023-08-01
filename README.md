# Noir-MiMCsponge

 MiMC-2p/p implementation \
 constants are (publicly generated) random numbers, for instance using keccak as a ROM.\
 You must use constants generated for the native field\
 Rounds number should be ~ log(p)/log(exp) log_5(21888242871839275222246405745257275088548364400416034343698204186575808495617) ~= 110\
 For 254-bit primes, exponent 5 and 220 rounds seem to be recommended\

 ## Functions

 **1. MiMCFeistel:** (xL_in : Field, xR_in : Field, k : Field) ->  [Field;2] 
 
 **inputs**: xL_in, xR_in, and k are all Field \
 **outputs**: two dimensional array S[2] that holds S[0] is xL and S[1] is xR

 MiMCFeistel takes these inputs, processes them by adding the previous round's data with constant data and taking exponent, and swaps xL and xR for 220 rounds. 

  **2. MiMCFeistelDecryption:** (xL_in : Field, xR_in : Field, k : Field) ->  [Field;2] 
 
 **inputs**: xL_in, xR_in, and k are all Field \
 **outputs**: two dimensional array S[2] that holds S[0] is xL and S[1] is xR

 MiMCFeistelDecryption takes these inputs, processes them by adding the previous round's data with constant data and taking exponent, and swaps xL and xR for 220 rounds so that:
 
 for all input **MiMCFeistelDecryption(MiMCFeistel(input)) == input** 

   **3. MiMCSponge:** (plaintext : [Field;N], k: Field) ->  [Field;M]
 
 **inputs**: arbitrary length input N and k from Field
 **outputs**: arbitrary length output M 

 MiMCSponge takes N-length input, absorbs all, and squeezes for a demanding number of outputs. MiMCFeistel function is used for each absorbing and squeezing phase. 

 Note: Each Field element can hold 254 bits of any number. 

  ## Use Cases

  1. Anyone can benefit from the succinctness of Noir-MiMCsponge without performing the algorithm with inputs by verifying in seconds the proof. This can make it possible to switch on-chain encryption to off-chain.
  2. MiMCSponge can use as a hash function, so anyone can prove that they know the preimage of the hash function without revealing it.
 


 

 
