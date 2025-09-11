
import SwiftUI

// MARK: - Levels Screen
struct LevelsView: View {
    let backAction: () -> Void
    let selectLevel: (Int) -> Void
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.1, green: 0.3, blue: 0.6), Color(red: 0.2, green: 0.5, blue: 0.9)]),
                          startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Back button
                HStack {
                    Button(action: backAction) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.5))
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .padding()
                
                Text("SELECT LEVEL")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                    .padding(.bottom, 30)
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 20) {
                        ForEach(1..<16) { level in
                            LevelButton(level: level, action: { selectLevel(level) })
                        }
                    }
                    .padding()
                }
            }
        }
    }
}
