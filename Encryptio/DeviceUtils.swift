//
//  DeviceUtils.swift
//  Encryptio
//
//  Created by Anum Qudsia on 24/07/2018.
//  Copyright © 2018 anum.qudsia. All rights reserved.
//

import Foundation

class DeviceUtils {
    
    class func getDeviceUniqueID() -> String? {
        let keychain_unique_id = KeychainUtils.getUniqueDeviceIdFromKeychain()
        if keychain_unique_id != nil {
            return keychain_unique_id
        } else {
            return self.getDeviceIdentifierForVendor()
        }
    }
    
    class func getDeviceIdentifierForVendor() -> String? {
        let UUID_PREFIX = "FFFFFFFF"
        let RANGE1 = [0, 8] as? NSRange
        let RANGE2 = [9, 4] as? NSRange
        let RANGE3 = [14, 4] as? NSRange
        let RANGE4 = [19, 4] as? NSRange
        let RANGE5 = [24, 12] as? NSRange
        let uuid = Device.current.identifierForVendor?.uuidString
        if let a1 = RANGE1, let a2 = RANGE2, let a3 = RANGE3, let a4 = RANGE4, let a5 = RANGE5 {
            return "\(UUID_PREFIX)\((uuid as NSString?)?.substring(with: a1) ?? "")\((uuid as NSString?)?.substring(with: a2) ?? "")\((uuid as NSString?)?.substring(with: a3) ?? "")\((uuid as NSString?)?.substring(with: a4) ?? "")\((uuid as NSString?)?.substring(with: a5) ?? "")"
        }
        return nil
    }
    
    class func getPinAndDeviceId(_ pin: String?) -> String? {
        return StringUtils.concatStrings(pin, self.getDeviceUniqueID())
    }
    
    class func getPinAndDeviceIdCString(_ pin: String?) -> UnsafePointer<Int8>? {
        return DeviceUtils.getPinAndDeviceId(pin)?.utf8CString
    }
}
