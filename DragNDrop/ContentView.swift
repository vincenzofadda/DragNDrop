//import SwiftUI
//
//struct ContentView: View {
//    @State var isDragging = false
//    @State var position = CGPoint.zero
//
//    var body: some View {
//        RoundedRectangle(cornerRadius: 20, style: .continuous)
//            .frame(width: 100, height: 100)
//            .position(x: position.x, y: position.y)
//            .foregroundColor(isDragging ? Color.green : Color.blue)
//            .gesture(
//                DragGesture()
//                    .onChanged({ value in
//                        position = value.location
//                        isDragging = true
//                    })
//                    .onEnded { _ in
//                        isDragging = false
//                    }
//            )
//            .onAppear {
//                // Geometry Reader
//                position = CGPoint(
//                    x: (UIScreen.main.bounds.width/2),// - 100,
//                    y: (UIScreen.main.bounds.height/2) - 100
//                )
//            }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}



import SwiftUI
import AVKit

class SoundManager {
    
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    func playSound() {
        
        guard let url = Bundle.main.url(forResource: "duck", withExtension: ".mp3") else { return }
        
        do{
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Erro, sem som. \(error.localizedDescription)")
        }
    }
        
}

struct ContentView: View {
    
    @State var isDragging = false
    @State var position = CGPoint.zero
    @State private var actionExecuted = false
    
    //SoundManager.instance.playSound()
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .frame(width: 100, height: 100)
                    .position(x: position.x, y: position.y)
                    .foregroundColor(getColor())
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                if !actionExecuted {
                                    SoundManager.instance.playSound()
                                    actionExecuted = true
                                }
                                position = value.location
                                isDragging = true
                                
                            })
                            .onEnded { _ in
                                isDragging = false
                                actionExecuted = false
                                
                            }
                    )
                    
            }
            Spacer()
        }
    }
    
    private func getColor() -> Color {
        let halfScreenWidth = UIScreen.main.bounds.width / 2
        let halfScreenHeight = UIScreen.main.bounds.height / 2
        
        if !isDragging {
            return Color.blue
            
        } else if position.x < halfScreenWidth {
            if position.y < halfScreenHeight {
                return Color.red
                
            } else {
                return Color.purple
            }
            
        } else {
            if position.y < halfScreenHeight {
                return Color.green
            } else {
                return Color.orange
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

