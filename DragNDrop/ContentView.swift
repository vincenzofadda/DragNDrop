//
//  ContentView.swift
//  DragNDrop
//
//  Created by user on 11/04/23.
//

import SwiftUI

struct ContentView: View {
    @State var isDragging = false
    @State var position = CGPoint.zero
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .frame(width: 100, height: 100)
            .position(x: position.x, y: position.y)
            .foregroundColor(isDragging ? Color.green : Color.blue)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        position = value.location
                        isDragging = true
                    })
                    .onEnded { _ in
                        isDragging = false
                    }
            )
            .onAppear {
                // Geometry Reader
                position = CGPoint(
                    x: (UIScreen.main.bounds.width/2),// - 100,
                    y: (UIScreen.main.bounds.height/2) - 100
                )
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
