import Foundation

public func initializeWdtCSwift(url : String, dir : String) -> Int{
    let c_url = url.cString(using: String.defaultCStringEncoding)!
    let c_dir = dir.cString(using: String.defaultCStringEncoding)!
    return Int(initializeWdt(c_url,c_dir))
}

public func getProgressCSwift() -> Double {
    return getProgress()
}

