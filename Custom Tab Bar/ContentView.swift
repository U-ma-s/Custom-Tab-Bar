//
//  ContentView.swift
//  Custom Tab Bar
//  
//  Created by umas on 2023/05/19
//  
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
            .preferredColorScheme(.light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
