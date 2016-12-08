//
//  AppDelegate.swift
//  PokeIV
//
//  Created by Daniel Tseng on 8/10/16.
//  Copyright © 2016 Daniel Tseng. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // paypal
        PayPalMobile.initializeWithClientIds(forEnvironments: [PayPalEnvironmentProduction: "ARkbwmgFqinqf-XerAW1iTy-g66ieLajEnkOcBXvZ1te6JA56AUDhbDjr8anP_OTWRDfzDo0UrpJZVT4",PayPalEnvironmentSandbox: "AfXYmOTzw-Fzx73MaOR9d4s27o8k7s_ZfALACysWaIyQiKxsnNyLXJk4PqV5LWE5nNvvGCJ6Hnn8p-7a"])
        
        // Add auto delete photo bool in UserDefaults
        let defaults = UserDefaults.standard
        let defaultValue = ["autoDeletePhoto" : false]
        defaults.register(defaults: defaultValue)
        
        // checking bundle version
        let userDefaults: UserDefaults = UserDefaults.standard
        let bundleVersion: String = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
        if (userDefaults.object(forKey: "2VERSION") != nil) {
            let version: NSString = userDefaults.object(forKey: "2VERSION") as! NSString
            if !(version.isEqual(to: bundleVersion)) {
                self.replaceDatabase()
                userDefaults.set(bundleVersion, forKey: "2VERSION")
            }
        } else {
            self.replaceDatabase()
            userDefaults.set(bundleVersion, forKey: "2VERSION")
        }
        
        // Copy DataBase
        Util.copyFile("PokemonGO.sqlite")
        
        return true
    }
    
    // replace dataBase
    func replaceDatabase() {
        
        let fileManager: FileManager = FileManager.default
        
        // remove old sqlite database from documents directory
        let dbDocumentsURL: URL = self.applicationDocumentsDirectory().appendingPathComponent("PokemonGO.sqlite")
        let dbDocumentsPath = dbDocumentsURL.path
        if fileManager.fileExists(atPath: dbDocumentsPath) {
            do {
                try fileManager.removeItem(atPath: dbDocumentsPath)
            }
            catch let error as NSError {
                print("Error deleting sqlite database: \(error)")
            }
            
        }
        
        // move new sqlite database from bundle to documents directory
        let dbBundlePath: String? = Bundle.main.path(forResource: "PokemonGO", ofType: "sqlite")
        if dbBundlePath != nil {
            do {
                try fileManager.copyItem(atPath: dbBundlePath!, toPath: dbDocumentsPath)
            }
            catch let error as NSError {
                print("Error copying sqlite database: \(error)")
            }
        }
    }
    
    // get applicationDoucmentsDirectory
    func applicationDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).last!
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

