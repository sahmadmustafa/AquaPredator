import Foundation
import SwiftUI
struct Fish: Identifiable {
    let id = UUID()
    let color: Color
    let direction: Direction
    var position: CGPoint
    var speed: CGFloat
    var isBomb: Bool = false
    
    enum Direction {
        case top, bottom, left, right
    }
}

struct Shark {
    var color: Color
    var position: CGPoint
    var health: Int = 3
}

struct GameScore: Identifiable, Codable {
    let id = UUID()
    let score: Int
    let date: Date
    let level: Int
}

// MARK: - App State
enum AppState {
    case splash
    case menu
    case tips
    case levels
    case leaderboard
    case game
    case pause
    case gameOver
}

// MARK: - Preview
struct HungrySharkGame_Previews: PreviewProvider {
    static var previews: some View {
        HungrySharkGame()
    }
}
