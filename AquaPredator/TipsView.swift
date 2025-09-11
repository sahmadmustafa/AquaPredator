
import SwiftUI

// MARK: - Tips Screen
struct TipsView: View {
    let backAction: () -> Void
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.1, green: 0.3, blue: 0.6), Color(red: 0.2, green: 0.5, blue: 0.9)]),
                          startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
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
                    .padding(.bottom, 20)
                    
                    Text("GAME TIPS")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .bold()
                        .padding(.bottom, 10)
                    
                    TipCardView(
                        icon: "fish.fill",
                        title: "Control Your Shark",
                        description: "Drag the shark around the screen to catch fish. Stay within the screen boundaries."
                    )
                    
                    TipCardView(
                        icon: "fish.fill",
                        title: "Match Colors",
                        description: "Change your shark's color to match the fish you want to eat. Tap the color buttons at the bottom."
                    )
                    
                    TipCardView(
                        icon: "burst.fill",
                        title: "Avoid Bombs",
                        description: "Bombs will hurt your shark! They look like exploding fish."
                    )
                    
                    TipCardView(
                        icon: "heart.fill",
                        title: "Health System",
                        description: "You start with 3 hearts. Wrong fish take 1 heart, bombs take 2 hearts."
                    )
                    
                    TipCardView(
                        icon: "chart.line.uptrend.xyaxis",
                        title: "Level Up",
                        description: "Score points to level up. Higher levels mean faster fish and more bombs!"
                    )
                }
                .padding()
            }
        }
    }
}

