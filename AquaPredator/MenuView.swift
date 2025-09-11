
import SwiftUI

// MARK: - Menu Screen
struct MenuView: View {
    let startAction: () -> Void
    let tipsAction: () -> Void
    let levelsAction: () -> Void
    let leaderboardAction: () -> Void
    @Binding var soundToggle: Bool
    @Binding var musicToggle: Bool
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.1, green: 0.3, blue: 0.6), Color(red: 0.2, green: 0.5, blue: 0.9)]),
                          startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            // Bubbles in background
            ForEach(0..<20, id: \.self) { _ in
                BubbleView()
            }
            
            VStack(spacing: 20) {
                Spacer()
                
                Text("Aqua Predator")
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .shadow(color: .black, radius: 5, x: 2, y: 2)
                    .padding(.bottom, 40)
                
                MenuButton(title: "START GAME", action: startAction, color: .green)
                MenuButton(title: "GAME TIPS", action: tipsAction, color: .blue)
                MenuButton(title: "LEVELS", action: levelsAction, color: .yellow)
                MenuButton(title: "LEADERBOARD", action: leaderboardAction, color: .orange)
                Spacer()
            }
            .padding()
        }
    }
}

