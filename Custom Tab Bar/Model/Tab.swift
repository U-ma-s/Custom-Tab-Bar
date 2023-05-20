//
//  Tab.swift
//  Custom Tab Bar
//  
//  Created by umas on 2023/05/20
//  
//

import SwiftUI

////  App Tab
enum Tab: String, CaseIterable {
    case home = "Home"
    case services = "Services"
    case partners = "Pertners"
    case activity = "Activity"
    
    var systemImage: String {
        switch self {
        case .home:
            return "house"
        case .services:
            return "envelope.open.badge.clock"
        case .partners:
            return "hand.raised"
        case .activity:
            return "bell"
        }
    }
    
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}
