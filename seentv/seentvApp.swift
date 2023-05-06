//
//  seentvApp.swift
//  seentv
//
//  Created by Steven Tsan on 4/6/23.
//

//import SwiftUI
//
//
//
//@main
//struct seentvApp: App {
//    var body: some Scene {
//        WindowGroup {i
//            TabView{
//                ContentView()
//                    .tabItem{
//                        Image(systemName: "popcorn")
//                        // color of popcorn color
//                            .foregroundColor(.white)
//
//                    }
//                Text("Favorites")
//                    .tabItem{
//                        Image(systemName: "heart.fill")
//                    }
//                Text("Tickets")
//                    .tabItem{Image(systemName: "bookmark.fill")}
//            }
//
//        }
//    }
//}


import SwiftUI

@main
struct seentvApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .tabItem {
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color(red: 186/255, green: 147/255, blue: 216/255))
                            Image(systemName: "popcorn")
                                .foregroundColor(.white)
                        }
                    }
                Text("Favorites")
                    .tabItem {
                        Image(systemName: "heart.fill")
                    }
                Text("Tickets")
                    .tabItem { Image(systemName: "bookmark.fill")
                    }
                Text("Profile")
                    .tabItem { Image(systemName: "person.crop.circle")}
                
            }
        }
    }
}
