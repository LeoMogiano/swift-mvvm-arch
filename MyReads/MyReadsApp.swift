//
//  MyReadsApp.swift
//  MyReads
//
//  Created by Leo Mogiano on 23/2/25.
//

import SwiftUI

@main
struct MyReadsApp: App {
    @State var router = Router()
    @State var bookViewModel = BookViewModel()
    
    var body: some Scene {
        
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                HomeView()
                    .ignoresSafeArea(edges: .bottom)
                    .navigationDestination(for: Router.Destination.self) { destination in
                        switch destination {
                            
                        case .bookDetailView:
                            BookDetailView()
                        }
                        
                    }
            }.environment(router)
                .environment(bookViewModel)
        }
        
    }
}
