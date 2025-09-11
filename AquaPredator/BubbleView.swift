

import SwiftUI


// MARK: - Helper Components
struct BubbleView: View {
    @State private var position: CGPoint = CGPoint(
        x: CGFloat.random(in: 0..<UIScreen.main.bounds.width),
        y: CGFloat.random(in: 0..<UIScreen.main.bounds.height)
    )
    @State private var opacity: Double = Double.random(in: 0.1...0.5)
    @State private var size: CGFloat = CGFloat.random(in: 5...30)
    @State private var speed: CGFloat = CGFloat.random(in: 0.5...2)
    
    var body: some View {
        Circle()
            .fill(Color.white.opacity(opacity))
            .frame(width: size, height: size)
            .position(position)
            .onAppear {
                withAnimation(Animation.linear(duration: Double.random(in: 5...15)).repeatForever()) {
                    position.y = -size
                    position.x += CGFloat.random(in: -50...50)
                }
            }
    }
}

struct MenuButton: View {
    let title: String
    let action: () -> Void
    let color: Color
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title2)
                .bold()
                .foregroundColor(.white)
                .frame(width: 250, height: 50)
                .background(color)
                .cornerRadius(25)
                .shadow(color: color.opacity(0.7), radius: 10, x: 0, y: 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.white, lineWidth: 2)
                )
        }
    }
}

struct TipCardView: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                    .font(.title)
                
                Text(title)
                    .font(.title2)
                    .foregroundColor(.white)
                    .bold()
            }
            
            Text(description)
                .foregroundColor(.white)
                .font(.body)
        }
        .padding()
        .background(Color.black.opacity(0.3))
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.white.opacity(0.5), lineWidth: 1)
        )
    }
}

struct LevelButton: View {
    let level: Int
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("\(level)")
                .font(.title)
                .bold()
                .foregroundColor(.white)
                .frame(width: 80, height: 80)
                .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom))
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 2)
                )
                .shadow(radius: 5)
        }
    }
}

struct ScoreRowView: View {
    let score: GameScore
    
    var body: some View {
        HStack {
            Text("\(score.score)")
                .font(.title2)
                .bold()
                .foregroundColor(.white)
                .frame(width: 80)
            
            VStack(alignment: .leading) {
                Text("Level \(score.level)")
                    .foregroundColor(.white)
                
                Text(score.date, style: .date)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
            }
            
            Spacer()
            
            Image(systemName: "trophy.fill")
                .foregroundColor(getTrophyColor())
                .font(.title2)
        }
        .padding()
        .background(Color.black.opacity(0.3))
        .cornerRadius(10)
    }
    
    private func getTrophyColor() -> Color {
        switch score.score {
        case ..<100: return .gray
        case 100..<300: return .yellow
        case 300..<500: return .orange
        default: return .red
        }
    }
}

struct ScoreCardView: View {
    let value: Int
    let label: String
    let color: Color
    
    var body: some View {
        VStack {
            Text("\(value)")
                .font(.title2)
                .bold()
                .foregroundColor(.white)
            
            Text(label)
                .font(.caption)
                .foregroundColor(.white)
        }
        .padding(10)
        .frame(width: 100)
        .background(color.opacity(0.5))
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.white, lineWidth: 2)
        )
    }
}

struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

