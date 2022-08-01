//
//  Utils.swift
//  Native-iOS-Baselione
//
//  Created by Mindstix on 26/07/21.
//

import Foundation
import SwiftUI
import UIKit

///This utility component includes essential swift functions which require by every iOS app developer when we start with any new project development. Developers can add this package to the respective projects in order to use functionality that is included in the base utility.
public class CommonUtils {
    
    
    /// Haptic feedback option
    public static let hapticFeedback = UIImpactFeedbackGenerator(style: .heavy)
    
    /// Use this method in case you need to save any key-value pair with help of userdefaults
    /// - Parameters:
    ///   - key:String key to save the value
    ///   - val: Any data to save with userdefaults
    public static func saveToUserDefaults(key : String, val : Any) {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(val, forKeyPath: key)
    }
    
    /// To get String data associated with key from userdefaults
    /// - Parameters:
    ///   - key:String key to get the associated value
    /// - Returns: A String value.
    public static func getStringFromUserDefaults(key : String) -> String? {
        let userDefaults = UserDefaults.standard
        return userDefaults.string(forKey: key)
    }
    
    /// To get Bool data associated with key from userdefaults
    /// - Parameters:
    ///   - key:String key to get the associated value
    /// - Returns: A Bool value.
    public static func getBoolFromUserDefaults(key : String) -> Bool {
        let userDefaults = UserDefaults.standard
        return userDefaults.bool(forKey: key)
    }
    
    /// To get build  version from application
    /// - Returns: A String value which is build version..
    public static func fetchBuildVersion() -> String {
        if let buildversion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return buildversion
        }
        return ""
    }
    
    /// To get build number from application.
    /// - Returns: A String value which is build number.
    public static func getAppBuildNo() -> String? {
        guard let build: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String else {
            return nil
        }
        return build
    }
    
    /// To get urlQueryAllowed url from url string
    /// - Parameters:
    ///   - urlString:String url to get the associated value
    /// - Returns: A urlQueryAllowed string
    public static func getURLFromString(urlString : String) -> String {
        return urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    
    //MARK:- UI Alert Pop up
    
    /// Call this method to show the alert in UIKit workflow.
    /// - Parameters:
    ///   - title:String title of the alert
    ///   - message: String message for the alert
    ///   - action: action determines if the OK button is visible
    public static func showOKAlertPopUp(title : String, message : String, action : Bool, controller : UIViewController, completion : @escaping () -> Void ) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        if action {
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        }
        DispatchQueue.main.async {
            controller.present(alert, animated: true, completion: completion)
        }
    }
    
    /// Call this method to show the alert in SwiftUI workflow.
    /// - Parameters:
    ///   - title:String title of the alert
    ///   - message: String message for the alert
    ///   - OKButtonText: OK button String title
    /// - Returns: Default Alert with 1 Button.
    public static func showDefaultAlert(title : String, message : String, OKButtonText : String) -> Alert {
        
        return Alert(title: Text(title), message: Text(message), dismissButton: .default(Text(OKButtonText)))
    }
    
    ///Returns Default Alert with 2 Buttons and actions closure
    /// Call this method to show the alert in SwiftUI workflow.
    /// - Parameters:
    ///   - title:String title of the alert
    ///   - message: String message for the alert
    ///   - primaryButtonText:1st option  button String title
    ///   - secondaryButtonText: OK button String title
    /// - Returns: Returns Default Alert with 2 Buttons and actions closure
    public static func showDefaultAlert(title : String, message : String, primaryButtonText : String, secondaryButtonText : String, primaryButtonAction: @escaping () -> Void, secondaryButtonAction : @escaping () -> Void) -> Alert {
        
        return Alert(title: Text(title), message: Text(message), primaryButton: .default(Text(primaryButtonText), action: primaryButtonAction), secondaryButton: .default(Text(secondaryButtonText), action: secondaryButtonAction))
    }
    
    
    //MARK:- Date & Time
    /// Get greeting for the current time
    /// - Returns: String > Good morning if its day and so on
    public static func getGreetingForCurrentTime() -> String {
        
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 6..<12 : return "good_morning"
        case 12..<17 : return "good_afternoon"
        default:
            return "good_evening"
        }
    }
    
    /// Gets the Date formatted string from provided UTC string and mentioned UTC format
    public static func getDateTimeFromUTC(utcDateString : String, utcDateFormat : DateType = .UTCFormat, expectedOutputDateFormat : DateType ) -> String {
        
        // get the date format and convert it into UTC
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = utcDateFormat.rawValue
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: utcDateString) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = expectedOutputDateFormat.rawValue
            
            let dateString = dateFormatter.string(from: date)
            return dateString.replacingOccurrences(of: "suffix", with: date.daySuffix())
            //return dateString
        }
        return "NO_DATE"
    }
    
    /// Returns the Difference in days string based on inFuture Value. If in future > 2 days ago. Else 2 days ago
    public static func getDifferenceInDaysText(numberofDaysString: String, inFuture: Bool ) -> String {
        
        // Remove the negative sign if difference is -ve
        let noOfDaysString = numberofDaysString.replacingOccurrences(of: "-", with: "")
        
        switch noOfDaysString {
        
        case "0" :
            return "today"
        case "1":
            return  "1 " + (inFuture ? "day_to_go" : "day_ago")
        default:
            return  "\(noOfDaysString) " + (inFuture ? "days_to_go" : "days_ago")
        }
    }
    
    /// gets the date object from the provided utc string
    public static func getDateObject(utcDateString : String, dateFormat : DateType = .UTCFormat) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.rawValue
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: utcDateString) {
            return date
        }
        return nil
    }
    
    // Fetch Dictionary from Json files
    public static func fetchDataFromLocalJson(name : String)-> NSDictionary? {
        
        if let path = Bundle.main.path(forResource: name, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                return (jsonResult as! NSDictionary)
            } catch {
                // handle error
            }
        }
        return nil
    }
    
    //MARK:- Base operations
    /// Open URL in Safari
    /// - Parameters:
    ///   - url:String url to open in the safari
    public static func openInSafari(url : String) {
        if let urlString = URL(string: url) {
            UIApplication.shared.open(urlString)
        }
    }
    
    /// Open mail with provided emailID
    /// - Parameters:
    ///   - emailId:String email to send an email
    public static func openMail(emailId: String) {
        let mailURL = URL(string: "mailto:\(emailId)")!
        if UIApplication.shared.canOpenURL(mailURL) {
            UIApplication.shared.open(mailURL, options: [:], completionHandler: nil)
        }
    }
    
    /// Open dial pad with provided phone number
    /// - Parameters:
    ///   - phoneString:String phone number to open it dial pad
    public static func openPhone(phoneString : String) {
        let numberString = phoneString.replacingOccurrences(of: " ", with: "")
        guard let url = URL(string: "telprompt://\(numberString)") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    public static func getSecKeyFromString(keyBase64 : String) -> SecKey {
        
        let keyData = Data(base64Encoded: keyBase64)!
        let key = SecKeyCreateWithData(keyData as NSData, [
            kSecAttrKeyType: kSecAttrKeyTypeRSA,
            kSecAttrKeyClass: kSecAttrKeyClassPrivate,
        ] as NSDictionary, nil)!
        
        return key
    }
}

public enum DateType : String {
    case UTCFormat = "yyyy-MM-dd'T'HH:mm:ss"
    case RegularDateNoSuffix = "dd MMM yyyy"
    case RegularDate = "dd'suffix' MMM yyyy"
    case RegularDateDay = "dd'suffix' MMM yyyy, EEE"
    case Time = "KK:mm a"
    case UTCFormat_Space = "yyyy-MM-dd HH:mm:ss"
}

extension Date {
    
    public func dateFormatWithSuffix() -> String {
        return "dd'\(self.daySuffix())' MMMM yyyy"
    }
    
    public func daySuffix() -> String {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.day, from: self)
        let dayOfMonth = components.day
        switch dayOfMonth {
        case 1, 21, 31:
            return "st"
        case 2, 22:
            return "nd"
        case 3, 23:
            return "rd"
        default:
            return "th"
        }
    }
}
