//
//  Router.swift
//  MyReads
//
//  Created by Leo Mogiano on 23/2/25.
//

import SwiftUI
import Observation


@Observable
class Router {
    
    public enum Destination: Codable, Hashable {
       // case detailBook(book: Book)
        case bookDetailView
    }
    
    var navPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
    func back() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
    
    
}
