//
//  DoctorsAppApp.swift
//  DoctorsApp
//
//  Created by Yash Patil on 16/02/23.
//

import SwiftUI

@main
struct DoctorsAppApp: App {
    @StateObject var postvm = PostViewModel()
    @StateObject var getvm = GetViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(postvm)
                .environmentObject(getvm)
                
        }
    }
}
