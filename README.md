# A5-1-GSM-Cipher-Image-Encryption-and-Decryption-using-Verilog

## Task
 Encrypt a 256*256 grayscale image using A5/1 stream cipher.

## Constraints

    1. Clock Frequency = 100 GHz\
    2. 64 bit secret key = “hardware”
    3. 22 bit public key = 22’b11_0100_1110_0001_1001_0001

## Steps

- Verilog cannot directly read .jpg files but can read .txt files with binary values using system function $readmemb. So the jpg file is converted into binary file using OpenCV.
- Next, pseudo random keystream is generated using the following steps.
- LFSRs are initialised with zeros.
- The secret key is fed bit by bit ignoring the majority logic.
- After 64 bit secret key, the known 22bit public key is fed(bit by bit) ignoring the majority logic.
- Next LFSRs are clocked 100 times using the Majprity Logic and the outputs are ignored.
- Finally the generation of pseudo random keystream started.The LFSRs are clocked using Majority Logic and the LSB bits of three LFSRs are XORed to get single bit key.
- These pseudo keys are stored in a register bit by bit and then XORed with the input bits(from binary file) to get the encrypted bits.
- These encrypted bits are then converted to hex file and finally to jpg file.
- The encrypted bits can be decrypted by XORing it with pseudo random keystream. The decrypted bits are also stored in a hex file and then converted to jpg file.
 
#### Image Used

The image used can be downloaded from below link:
https://drive.google.com/file/d/1lY4oa_g-ZyZldpEqa8Ew9wfwkFMMWzfX/view?usp=sharing

## Results

- Encrypted Image:\

   ![encrypt](https://user-images.githubusercontent.com/77710362/177014251-d0d4d915-07b9-487b-886f-99e5fb6eb217.jpg)
- Decrypted Image:\

   ![decrypt](https://user-images.githubusercontent.com/77710362/177014243-24200adb-3578-4740-9faf-5c7fa4cc8771.jpg)
 
## References

- https://youtu.be/LgZAI3DdUA4
- https://www.cryptographynotes.com/2019/02/symmetric-stream-a5by1-algorithm-linear-feedback-shift-register.html
- https://en.wikipedia.org/wiki/A5/1

