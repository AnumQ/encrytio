//
//  CryptoEncryptDecryptUtils.swift
//  Encryptio
//
//  Created by Anum Qudsia on 24/07/2018.
//  Copyright © 2018 anum.qudsia. All rights reserved.
//

import Foundation

class CryptoEncryptDecryptUtils {
    
    static func encrypt(pin: String) {
        var cryptoUtils = CryptoUtils()
        
        var encryptedKey = cryptoUtils.encryptString(KeychainUtils.getKey(), keyString: DeviceUtils.getPinAndDeviceId(pin), ivString: KeychainUtils.getUserId())
        Globals.encryptedKey = encryptedKey
    }
    
}
