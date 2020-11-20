# CMPush

CMPush is a solution for customers that want to send push notifications to their apps by using phone numbers. 
The CM platform will look up the corresponding push token for the telephone number and send a push message. When a push message can't be delivered for some reason, CM will send the message by SMS (or another channel , if configured)

Please see [https://www.cm.com/app/docs/en/api/business-messaging-api/1.0/index#push](https://www.cm.com/app/docs/en/api/business-messaging-api/1.0/index#push) for details.

---

To enable pushing messages to your app you need to enable push in your app settings and you have to add the CMPush framework to your project. 

## Adding push capabilities to your project

Select the target and under 'Signing & Capabilities' use add (+) capability to add push notifications and the background mode ‘Remote notifications’.

## Add a Notification Service Extension build target

The CMPush library confirms push messages and this functionality needs to be called from the Notification Service Extension to be sure that it is always called when iOS receives a CM Push message.

## Adding App group to the project

To allow communication between the app and the notification service extension, a group should be added to the app and the notification service. Use add (+) capabiliy to add an app group to your project and notification service. Use the same name for both of them.

## Add CMPush XCframework

You can add the swift package from GitHub by adding the following URL as a repository in Xcode: [https://github.com/cmdotcom/text-push-library-ios](https://github.com/cmdotcom/text-push-library-ios)

## Enable push in AppDelegate

CM Push needs to be configured at application startup. Add CMPush_Config with the account id and groupname to `didFinishLaunchingWithOptions` in the appdelegate. Call `registerForRemoteNotifications` to generate the push token. In the `didRegisterForRemoteNotificationsWithDeviceToken` call `CMPush_UpdateToken` with the token.

Also add `UNUserNotificationCenterDelegate` to the app delegate and set the delegate in `didFinishLaunchingWithOptions`.

See example code below.

```swift
import UIKit
import CMPush

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Configure CMPush
        #if DEBUG
        CMPush_SetApplePushEnvironment(.Sandbox)
        #endif

        CMPush_Config(accountId: "1234", groupName: "group.com.cm.CMPushTest")

        // Register push to get push token
        UIApplication.shared.registerForRemoteNotifications()

        // Alert notifications
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Remote notification is unavailable: \(error.localizedDescription)")
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Send push token to CM
        CMPush_UpdateToken(deviceToken: deviceToken)
    }
}
```

## Add Sending Status Reports in NotificationService

CM Push needs to be configured in the NotificationService init. Add CMPush_Config with account id and groupname to `init()` in the service. In the notification service add CMPush_StatusReport to confirm delivery of push messages.

```swift
import UserNotifications
import CMPush

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override init() {
        CMPush_Config(accountId: "1234", groupName: "group.com.cm.CMPushTest")
        super.init()
    }

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)

        if let bestAttemptContent = self.bestAttemptContent {
            CMPush_StatusReport(bestAttemptContent: bestAttemptContent) { success, Error in
                bestAttemptContent.body += "\nsuccess = \(success)\n"
                contentHandler(bestAttemptContent)
            }
        }
    }

    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
}
```

## Registering a phone number

### PreRegister

Use `CMPush_PreRegister` to trigger an OTP request for a phone number that was entered by end-user, used to link a phone number to this device.

```swift
    // Ask user permission
    let unCenter = UNUserNotificationCenter.current()
    unCenter.requestAuthorization(options: [.alert, .sound, .badge]) {granted,error in

        if granted {
            // If granted ask otp code CMPush
            CMPush_PreRegister(msisdn: msisdn, sender: pushsender) {succes,error in

            }
        }
    }
```

### Register

Checks an OTP that user has received by SMS, link a phone number to this device.

```swift
import CMPush

...

CMPush_Register(msisdn: msisdn, otpCode: pushOptCode) {succes,error in
// succes: true or false
}
```
