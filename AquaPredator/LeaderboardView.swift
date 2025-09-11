
import SwiftUI

// MARK: - Leaderboard Screen
struct LeaderboardView: View {
    let scores: [GameScore]
    let backAction: () -> Void
    
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
                
                Text("LEADERBOARD")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                    .padding(.bottom, 20)
                
                if scores.isEmpty {
                    Text("No scores yet!")
                        .foregroundColor(.white)
                        .font(.title2)
                        .padding()
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 10) {
                            ForEach(scores.prefix(10)) { score in
                                ScoreRowView(score: score)
                            }
                        }
                        .padding()
                    }
                }
                
                Spacer()
            }
        }
    }
}
