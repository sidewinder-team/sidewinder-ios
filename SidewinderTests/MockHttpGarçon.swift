import Foundation
import Sidewinder

public class MockHttpGarçon : HttpGarçon {
    
    public var UrlResponses = [String : NSData]()

    public func Get(url: String) -> NSData? {
        return UrlResponses[url]
    }
    
}