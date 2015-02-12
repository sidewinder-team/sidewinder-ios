import Quick
import Nimble
import Sidewinder

class AppDelegateTest: QuickSpec {
    override func spec() {
        
        describe("When the application registers a device token") {
            it("will create a Job Subscription Service with that token") {
                let app = UIApplication.sharedApplication()
                if let delegate = UIApplication.sharedApplication().delegate {
                    let data = "DeviceToken#1".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
                    delegate.application?(app, didRegisterForRemoteNotificationsWithDeviceToken: data!)

                    expect(JobSubscriptionServiceInstance?.DeviceToken).to(equal(data))
                }
            }
        }
    }
}
