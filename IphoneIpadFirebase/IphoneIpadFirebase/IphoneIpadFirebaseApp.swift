//
//  IphoneIpadFirebaseApp.swift
//  IphoneIpadFirebase
//
//  Created by MAC on 09/08/22.
//

import SwiftUI

@main
struct IphoneIpadFirebaseApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelagate.self) var appDelegate //Agrega firebase a Xcode
    
    var body: some Scene {
        let login = FirebaseViewModel()
        WindowGroup {
            ContentView().environmentObject(login)
        }
    }
}
