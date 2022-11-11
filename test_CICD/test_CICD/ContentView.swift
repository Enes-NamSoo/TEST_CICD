//
//  ContentView.swift
//  test_CICD
//
//  Created by 김남수 on 2022/10/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            
            Button {
                fatalError("errorororororororo")
            } label: {
                Text("error!")
            }
            
            Spacer().frame(height: 30)
            Button {
                fatalError("error2!!!222222")
            } label: {
                Text("error!")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
