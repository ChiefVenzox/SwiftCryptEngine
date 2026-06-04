# SwiftCryptEngine 🔒🗜️

A lightweight, pure-Swift command-line engine implementing standard cryptographic ciphers and data compression algorithms from scratch. 

This project was built to demonstrate core computer science principles—such as tree data structures, bitwise operations, dictionary-based compression, and polyalphabetic substitution—using clean Swift syntax and modern software testing practices.

---

## 🚀 Features

### 1. Cryptography (Encryption/Decryption)
* **Caesar Cipher:** Simple substitution cipher shifting character Unicode scalar values. Supports large and negative shift boundaries.
* **Vigenère Cipher:** Polyalphabetic substitution cipher using a key phrase to shift letters dynamically.
* **XOR Cipher:** Bitwise symmetric encryption mapping data bytes against a secret key using the XOR (`^`) operator, outputted in standard Base64 format.

### 2. Compression (Lossless)
* **Huffman Coding:** A frequency-based frequency-sorted binary tree algorithm. It builds an optimal prefix tree (Huffman Tree) for the input text, generates variable-length bit codes, and compresses text into a binary stream.
* **LZW (Lempel-Ziv-Welch):** A dictionary-based compression algorithm that dynamically builds a translation table as it reads data, converting repeating patterns into integer codes.

### 3. CLI Interactive Sandbox
* A interactive terminal menu allowing you to input custom text strings and immediately see the compression/encryption ratios, key outputs, and verification checks.

### 4. Robust Unit Testing
* Built with Apple's modern **Swift Testing** framework, including edge cases (boundary checks, large shifts, negative shifts, binary-only check, and full string reconstruction).

---

## 🛠️ Requirements & Installation

* macOS 14.0+ / Linux
* Swift 6.0+ / Xcode 15.0+

To clone and run this project locally:

```bash
# Clone the repository
git clone https://github.com/ChiefVenzox/SwiftCryptEngine.git

# Navigate into the project folder
cd SwiftCryptEngine
```

---

## 💻 How to Run

### Run the CLI Tool
Build and run the interactive suite directly from the command line:
```bash
swift run
```

### Run Unit Tests
Verify correctness of the cryptographic and compression engines:
```bash
swift test
```

---

## 📂 Project Structure

```text
Sources/
  └── SwiftCryptEngine/
      ├── SwiftCryptEngine.swift   # CLI Entry Point & Interactive Menu
      ├── Ciphers.swift            # Caesar & Vigenère Implementations
      ├── XORCipher.swift          # Bitwise XOR Encryption
      ├── HuffmanCoding.swift      # Binary tree-based Huffman Compression
      └── LZW.swift                # Dictionary-based LZW Compression
Tests/
  └── SwiftCryptEngineTests/
      └── SwiftCryptEngineTests.swift # Modern Unit Tests using Swift Testing
```

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the [issues page](https://github.com/yourusername/SwiftCryptEngine/issues).

## 📄 License

This project is licensed under the MIT License.
