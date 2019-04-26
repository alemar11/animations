//
//  AppDelegate.swift
//  Animations
//
//  Created by Alessandro Marzoli on 25/04/19.
//  Copyright © 2019 Alessandro Marzoli. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow()
    window?.rootViewController = ViewController4()
    window?.makeKeyAndVisible()
    return true
  }
}

