//
//  Home.swift
//  Custom Tab Bar
//  
//  Created by umas on 2023/05/20
//  
//

import SwiftUI

struct Home: View {
    @State private var activeTab: Tab = .home
    /// For smooth shape sliding effect,  I'm going to use Matched Geometry Effect
    @Namespace private var animation
    @State private var tabShapePosition: CGPoint = .zero
    
    init() {
        /// Hiding Tab Bar due to SwiftUI ios16 bug
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $activeTab) {
                Text("Home")
                    .tag(Tab.home)
                    //// Hiding Native Tab Bar
                    //.toolbar(.hidden, for: .tabBar)
                
                Text("Services")
                    .tag(Tab.services)
                    //// Hiding Native Tab Bar
                    //.toolbar(.hidden, for: .tabBar)
                
                Text("Partners")
                    .tag(Tab.partners)
                    //// Hiding Native Tab Bar
                    //.toolbar(.hidden, for: .tabBar)
                
                Text("Activity")
                    .tag(Tab.activity)
                    //// Hiding Native Tab Bar
                    //.toolbar(.hidden, for: .tabBar)
            }
            
            CustomTabBar()
        }
    }
    
    /// Custom Tab Bar
    /// With more easy customization
    @ViewBuilder
    func CustomTabBar(_ tint: Color = Color("Blue"), _ inactiveTint: Color = .blue) -> some View {
        HStack(alignment: .bottom, spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) {
                TabItem(
                    tint: tint,
                    inactiveTint: inactiveTint,
                    tab: $0,
                    animation: animation,
                    activeTab: $activeTab,
                    position: $tabShapePosition

                )
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 15)
        .background(content: {
            TabShape(midpoint: tabShapePosition.x)
                .fill(.white)
                .ignoresSafeArea()
                /// Add Blur + Shadow
                /// For shape smoothening
                .shadow(color: tint.opacity(0.2), radius: 5, x: 0, y: -5)
                .blur(radius: 2)
                .padding(.top, 25)
        })
        /// Adding animation
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: activeTab)
    }
}

struct TabItem: View {
    var tint: Color
    var inactiveTint: Color
    var tab: Tab
    var animation: Namespace.ID
    @Binding var activeTab: Tab
    @Binding var position: CGPoint
    
    /// Each Tab Item Posirion on the Screen
    @State private var tabPosition: CGPoint = .zero
    
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: tab.systemImage)
                .font(.title2)
                .foregroundColor(activeTab == tab ? .white : inactiveTint)
            /// Increasing size for Active Tab
                .frame(width: activeTab == tab ? 58 : 35, height: activeTab == tab ? 58: 35)
                .background {
                    if activeTab == tab {
                        Circle()
                            .fill(tint.gradient)
                            .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                    }
                }
            
            Text(tab.rawValue)
                .font(.caption)
                .foregroundColor(activeTab == tab ? tint : .gray)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .viewPosition(completion: { rect in
            tabPosition.x = rect.midX
            
            /// Updating active tab position
            if activeTab == tab {
                position.x = rect.midX
            }
        })
        .onTapGesture {
            activeTab = tab
            
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                position.x = tabPosition.x
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
