import Quick
import Nimble
import Sidewinder

class AppDelegateTest: QuickSpec {
    
    override func spec() {
        describe("When the application registers a device token") {
            it("will create a Job Subscription Service with that token") {
                let app = UIApplication.sharedApplication()
                expectExists(app.delegate) { delegate in
                    let data = "DeviceToken#1".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
                    delegate.application?(app, didRegisterForRemoteNotificationsWithDeviceToken: data!)
                    expect(JobSubscriptionServiceInstance?.DeviceToken).to(equal(data))
                }
            }
        }
    }
}

public func expectExists<T>(potentialValue: T?, then: (value: T) -> Void, file: String = __FILE__, line: UInt = __LINE__) {
    if let value = potentialValue {
        then(value: value)
    } else {
        XCTFail("Value did not exist.", file: file, line: line)
    }
}
