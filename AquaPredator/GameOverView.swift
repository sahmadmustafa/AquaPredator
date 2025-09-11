
import SwiftUI

// MARK: - Game Over Screen
struct GameOverView: View {
    let score: Int
    let level: Int
    let restartAction: () -> Void
    let menuAction: () -> Void
    
    var body: some View {
        ZStack {
            // Semi-transparent background
            Color.black.opacity(0.7)
                .edgesIgnoringSafeArea(.all)
            
            // Content container with proper padding
            ScrollView {
                VStack(spacing: 30) {
                    Text("GAME OVER")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 5, x: 2, y: 2)
                        .padding(.top, 40)
                    
                    // Score display
                    VStack(spacing: 10) {
                        Text("Final Score")
                            .font(.title2)
                            .foregroundColor(.white)
                        
                        Text("\(score)")
                            .font(.system(size: 60, weight: .bold))
                            .foregroundColor(.yellow)
                            .shadow(color: .black, radius: 5, x: 2, y: 2)
                        
                        Text("Level Reached: \(level)")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity)
                    .background(Color.black.opacity(0.4))
                    .cornerRadius(15)
                    .padding(.horizontal, 20)
                    
                    // Buttons
                    VStack(spacing: 20) {
                        // Share button
                        Button(action: shareScore) {
                            HStack {
                                Image(systemName: "square.and.arrow.up")
                                Text("Share Score")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                        }
                        .padding(.horizontal, 20)
                        
                        // Play Again button
                        Button(action: restartAction) {
                            Text("PLAY AGAIN")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal, 20)
                        
                        // Menu button
                        Button(action: menuAction) {
                            Text("MAIN MENU")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.orange)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 40)
            }
        }
    }
    
    private func shareScore() {
        let items = ["I scored \(score) points in Aqua Predator Game! Can you beat me?"]
        let av = UIActivityViewController(activityItems: items, applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true)
    }
}
