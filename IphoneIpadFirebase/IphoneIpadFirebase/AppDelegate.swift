//
//  AppDelegate.swift
//  IphoneIpadFirebase
//
//  Created by MAC on 09/08/22.
//

import UIKit
import Firebase

class AppDelagate: NSObject, UIApplicationDelegate {
    
    //Funcion para Firebase
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
}

