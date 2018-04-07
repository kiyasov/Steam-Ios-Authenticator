//
//  SteamTotp.swift
//  Steam Ios Authenticator
//
//  Created by Ислам Киясов on 20.03.2018.
//  Copyright © 2018 Ислам Киясов. All rights reserved.
//

import Foundation
import CryptoSwift

class SteamTotp {
    
    public static func timeFormat (timeOffset: Int) -> Int  {
        return Int(floor(floor(Double(Date().toMillis()) / Double(1000))/30));
    };
    
    /**
     * Generate a Steam-style TOTP authentication code.
     * @param string shared_secret   Your TOTP shared_secret, as a base64 string, hex string, or binary string
     * @param int time_offset        If you know how far off your clock is from the Steam servers, put the offset here in seconds
     * @return string
     */
    public static func getAuthCode(shared_secret: String, time_offset: Int, digits: Int = 6) -> String {
        let time = UInt64(self.timeFormat(timeOffset: 0));
        
        let counterMessage = Data(time.bigEndian.toData())
        
        let hmac = try! HMAC(key: shared_secret.fromBase64().bytes, variant: .sha1).authenticate(counterMessage.bytes)
        
        let offset = Int((hmac.last ?? 0x00) & 0x0f)
        
        let data =  Data(bytes: Array(hmac[offset...offset + 3]))
        
        var number = UInt32(strtoul(data.toHexString(), nil, 16))
        
        number &= 0x7fffffff
        
        number = number % UInt32(pow(10, Float(digits)))
        
        var fullcode = Int(UInt32(strtoul(data.toHexString(), nil, 16)) & 0x7FFFFFFF);
        
        let str = "23456789BCDFGHJKMNPQRTVWXY";
        
        var code = "";
        for _ in 0...4 {
            let at = str.index(str.startIndex, offsetBy: fullcode % str.count)
            code += String(str[at]);
            fullcode /= str.count;
        }
        
        return code;
    }
    
    
}


extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}

extension UInt64 {
    func toData() -> Data {
        //Convert UInt64 to data
        var int = self
        let data = Data(bytes: &int, count: MemoryLayout.size(ofValue: self))
        return data
    }
}

extension String {
    
    func fromBase64() -> Data {
        return Data(base64Encoded: self)!
    }
    
}


