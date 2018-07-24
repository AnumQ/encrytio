//
//  KeychainUtils.swift
//  Encryptio
//
//  Created by Anum Qudsia on 21/07/2018.
//  Copyright © 2018 anum.qudsia. All rights reserved.
//

class KeychainUtils {
    
    static let userId = "11111"
    
    static func getUserId() -> String {
        return userId
    }
    
    class func getUniqueDeviceIdFromKeychain() -> String? {
        return Globals.getKeyChainManager().searchKeyChain(forItem: KEYCHAIN_UNIQUE_DEVICE_ID, service: MOBILE_OTP_SERVICE_NAME)
    }
}
