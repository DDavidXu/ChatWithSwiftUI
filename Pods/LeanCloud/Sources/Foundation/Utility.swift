//
//  Utility.swift
//  LeanCloud
//
//  Created by Tang Tianyong on 3/25/16.
//  Copyright © 2016 LeanCloud. All rights reserved.
//

import Foundation
#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import IOKit
#endif

class Utility {
    static var compactUUID: String {
        return UUID().uuidString
            .replacingOccurrences(of: "-", with: "")
            .lowercased()
    }
    
    static var UDID: String {
        var udid: String?
        #if os(iOS) || os(tvOS)
        if let identifierForVendor = UIDevice.current
            .identifierForVendor?.uuidString {
            udid = identifierForVendor
        }
        #elseif os(macOS)
        let platformExpert = IOServiceGetMatchingService(
            kIOMasterPortDefault,
            IOServiceMatching("IOPlatformExpertDevice")
        )
        if let serialNumber = IORegistryEntryCreateCFProperty(
            platformExpert,
            kIOPlatformSerialNumberKey as CFString,
            kCFAllocatorDefault,
            0).takeRetainedValue() as? String {
            udid = serialNumber
        }
        IOObjectRelease(platformExpert)
        #endif
        if let udid = udid {
            return udid.lowercased()
        } else {
            return Utility.compactUUID
        }
    }
    
    static func jsonString(_ object: Any) throws -> String? {
        return String(
            data: try JSONSerialization.data(
                withJSONObject: object),
            encoding: .utf8)
    }
}

protocol InternalSynchronizing {
    
    var mutex: NSLock { get }
}

extension InternalSynchronizing {
    
    func sync<T>(_ closure: @autoclosure () -> T) -> T {
        self.sync(closure: closure)
    }
    
    func sync<T>(closure: () -> T) -> T {
        self.mutex.lock()
        defer {
            self.mutex.unlock()
        }
        return closure()
    }
}