//
//  TabShape.swift
//  Custom Tab Bar
//  
//  Created by umas on 2023/05/20
//  
//

import SwiftUI

struct TabShape: Shape {
    var midpoint: CGFloat
    
    /// Adding shape animation
    var animatableData: CGFloat {
        get { midpoint }
        set {
            midpoint = newValue
        }
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            /// Drawing upward rectangle shape
            path.addPath(Rectangle().path(in: rect))
            /// Drawing upward curve shape
            path.move(to: .init(x: midpoint - 60, y: 0))
            
            let to = CGPoint(x: midpoint, y: -25)
            let controll1 = CGPoint(x: midpoint - 25, y: 0)
            let controll2 = CGPoint(x: midpoint - 25, y: -25)
            
            path.addCurve(to: to, control1: controll1, control2: controll2)
            
            let to1 = CGPoint(x: midpoint + 60, y: 0)
            let controll3 = CGPoint(x: midpoint + 25, y: -25)
            let controll4 = CGPoint(x: midpoint + 25, y: 0)
            
            path.addCurve(to: to1, control1: controll3, control2: controll4)
        }
    }
}
