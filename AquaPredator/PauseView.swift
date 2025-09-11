
import SwiftUI


// MARK: - Pause Screen
struct PauseView: View {
    let resumeAction: () -> Void
    let restartAction: () -> Void
    let quitAction: () -> Void
    let score: Int
    let level: Int
    
    var body: some View {
        VStack(spacing: 30) {
            Text("GAME PAUSED")
                .font(.largeTitle)
                .foregroundColor(.white)
                .bold()
                .shadow(color: .black, radius: 5, x: 2, y: 2)
            
            VStack(spacing: 10) {
                Text("Score: \(score)")
                    .font(.title)
                    .foregroundColor(.white)
                
                Text("Level: \(level)")
                    .font(.title)
                    .foregroundColor(.white)
            }
            .padding(.bottom, 30)
            
            MenuButton(title: "RESUME", action: resumeAction, color: .green)
            MenuButton(title: "RESTART", action: restartAction, color: .blue)
            MenuButton(title: "QUIT", action: quitAction, color: .red)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

