**Amway-Base-Utility**

This utility component includes essential swift functions which is required by every iOS app developer when they start with any new project development. Developers can add this package to the respective projects in order to use functionality that is included in the base utility.


**Function details in the class**

class CommonUtils:

public static func saveToUserDefaults(key : String, val : Any)
 Use this method in case you need to save any key-value pair with help of userdefaults
    Parameters:
    key:String key to save the value
    val: Any data to save with userdefaults
    
    
 public static func getStringFromUserDefaults(key : String)
  To get String data associated with key from userdefaults
    Parameters:
    key:String key to get the associated value
    Returns: A String value.
  
  
 public static func getBoolFromUserDefaults(key : String) -> Bool
  To get Bool data associated with key from userdefaults
    Parameters:
    key:String key to get the associated value
    Returns: A Bool value. 


**Important reference Links: **

https://developer.apple.com/documentation/xcode/creating_a_standalone_swift_package_with_xcode
https://www.innominds.com/blog/a-new-approach-to-managing-dependencies-in-ios-development-with-swift-package-manager
https://medium.com/@zippicoder/libraries-frameworks-swift-packages-whats-the-difference-764f371444cd
https://blog.bitrise.io/post/migrating-from-cocoapods-to-swift-package-manager


