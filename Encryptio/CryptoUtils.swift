//
//  CryptoUtils.swift
//  Encryptio
//
//  Created by Anum Qudsia on 24/07/2018.
//  Copyright © 2018 anum.qudsia. All rights reserved.
//

import CommonCrypto

class CryptoUtils {
    let HASH_SHA_1 = "sha1"
    let HASH_SHA_256 = "sha256"
    let HASH_ALGORITHM = "sha256"
//    let CRYPTO_ALGORITHM: CCAlgorithm = kCCAlgorithmAES128
//    let KEY_SIZE: Int = kCCKeySizeAES256
//    let BLOCK_SIZE: Int = kCCBlockSizeAES128
//    let OPTIONS: CCOptions = kCCOptionPKCS7Padding
    // MARK: -
    // MARK: Private constants
    static var keyBytes1: Data?
    static var keyBytes2: Data?
    static var keyBytes3: Data?
    static var iv1: Data?
    static var iv2: Data?
    static var iv3: Data?
}
