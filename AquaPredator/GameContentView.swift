
import SwiftUI


// MARK: - Game Content View
struct GameContentView: View {
    @Binding var shark: Shark
    @Binding var fishes: [Fish]
    @Binding var score: Int
    @Binding var gameOver: Bool
    @Binding var level: Int
    let colors: [Color]
    let oceanGradient: LinearGradient
    let isSoundOn: Bool
    let pauseAction: () -> Void
    let checkCollisions: () -> Void
    let startGame: () -> Void
    let resetGame: () -> Void
    let startSpawningFish: () -> Void
    let spawnFish: () -> Void
    let updateGame: () -> Void
    
    var body: some View {
        ZStack {
            // Ocean background with gradient
            oceanGradient
                .edgesIgnoringSafeArea(.all)
            
            // Bubbles background effect
            ForEach(0..<30, id: \.self) { _ in
                BubbleView()
            }
            
            // Game area
            GeometryReader { geometry in
                ZStack {
                    // Fishes
                    ForEach(fishes) { fish in
                        ZStack {
                            if fish.isBomb {
                                Image(systemName: "burst.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(fish.color)
                                    .shadow(color: .white, radius: 5)
                                    .shadow(color: fish.color, radius: 10)
                            } else {
                                Image(systemName: "fish.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(fish.color)
                                    .shadow(color: .white, radius: 2)
                            }
                        }
                        .rotationEffect(fish.direction == .left ? .degrees(180) : fish.direction == .top ? .degrees(-90) : fish.direction == .bottom ? .degrees(90) : .degrees(0))
                        .position(fish.position)
                    }
                    
                    // Shark (draggable)
                    ZStack {
                        Image(systemName: "fish.fill") // Using hare as shark for better visibility
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                            .foregroundColor(shark.color)
                            .shadow(color: .white, radius: 5)
                            .shadow(color: shark.color, radius: 15)
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 3)
                                    .frame(width: 70, height: 70)
                                    .opacity(0.5)
                            )
                    }
                    .position(shark.position)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                // Keep shark within screen bounds
                                let newX = min(max(value.location.x, 30), geometry.size.width - 30)
                                let newY = min(max(value.location.y, 30), geometry.size.height - 30)
                                shark.position = CGPoint(x: newX, y: newY)
                            }
                    )
                    
                    // UI Elements
                    VStack {
                        HStack {
                            // Score display
                            ScoreCardView(value: score, label: "SCORE", color: .yellow)
                            
                            Spacer()
                            
                            // Health display
                            HStack(spacing: 5) {
                                ForEach(0..<shark.health, id: \.self) { _ in
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(.red)
                                        .font(.title2)
                                        .shadow(color: .black, radius: 3, x: 2, y: 2)
                                }
                            }
                            .padding(10)
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(20)
                            
                            Spacer()
                            
                            // Level display
                            ScoreCardView(value: level, label: "LEVEL", color: .green)
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                        
                        // Color selector buttons
                        HStack {
                            ForEach(colors, id: \.self) { color in
                                Button(action: {
                                    shark.color = color
                                }) {
                                    Circle()
                                        .fill(color)
                                        .frame(width: 40, height: 40)
                                        .overlay(
                                            Circle()
                                                .stroke(Color.white, lineWidth: shark.color == color ? 4 : 0)
                                                .shadow(radius: 5)
                                        )
                                        .shadow(color: color, radius: shark.color == color ? 10 : 5)
                                }
                            }
                            
                            // Pause button
                            Button(action: pauseAction) {
                                Image(systemName: "pause.fill")
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(Color.black.opacity(0.5))
                                    .clipShape(Circle())
                                    .shadow(radius: 5)
                            }
                            .padding(.leading, 20)
                        }
                        .padding(.bottom, 30)
                    }
                }
            }
        }
    }
}
