


import SwiftUI

// MARK: - Main Game View
struct HungrySharkGame: View {
    @State private var appState: AppState = .splash
    @State private var shark = Shark(color: .blue, position: CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2))
    @State private var fishes: [Fish] = []
    @State private var score = 0
    @State private var gameOver = false
    @State private var level = 1
    @State private var gameTimer: Timer?
    @State private var spawnTimer: Timer?
    @State private var scores: [GameScore] = []
    @State private var selectedLevel = 1
    @State private var isSoundOn = true
    @State private var isMusicOn = true
    
    // Game colors
    let colors: [Color] = [.red, .blue, .green, .yellow, .orange, .purple]
    let oceanGradient = LinearGradient(gradient: Gradient(colors: [Color(red: 0.1, green: 0.3, blue: 0.6), Color(red: 0.2, green: 0.5, blue: 0.9)]), startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        ZStack {
            switch appState {
            case .splash:
                SplashScreen()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                appState = .menu
                            }
                        }
                    }
                
            case .menu:
                MenuView(
                    startAction: { appState = .game },
                    tipsAction: { appState = .tips },
                    levelsAction: { appState = .levels },
                    leaderboardAction: {
                        loadScores()
                        appState = .leaderboard
                    },
                    soundToggle: $isSoundOn,
                    musicToggle: $isMusicOn
                )
                
            case .tips:
                TipsView(backAction: { appState = .menu })
                
            case .levels:
                LevelsView(
                    backAction: { appState = .menu },
                    selectLevel: { selectedLevel in
                        self.selectedLevel = selectedLevel
                        level = selectedLevel
                        appState = .game
                    }
                )
                
            case .leaderboard:
                LeaderboardView(scores: scores, backAction: { appState = .menu })
                
            case .game:
                GameContentView(
                    shark: $shark,
                    fishes: $fishes,
                    score: $score,
                    gameOver: $gameOver,
                    level: $level,
                    colors: colors,
                    oceanGradient: oceanGradient,
                    isSoundOn: isSoundOn,
                    pauseAction: {
                        gameTimer?.invalidate()
                        spawnTimer?.invalidate()
                        appState = .pause
                    },
                    checkCollisions: checkCollisions,
                    startGame: startGame,
                    resetGame: resetGame,
                    startSpawningFish: startSpawningFish,
                    spawnFish: spawnFish,
                    updateGame: updateGame
                )
                .onAppear {
                    startGame()
                }
                
            case .pause:
                PauseView(
                    resumeAction: {
                        appState = .game
                        startGame()
                    },
                    restartAction: {
                        resetGame()
                        appState = .game
                    },
                    quitAction: {
                        resetGame()
                        appState = .menu
                    },
                    score: score,
                    level: level
                )
                .background(BlurView(style: .systemUltraThinMaterialDark))
                
            case .gameOver:
                GameOverView(
                    score: score,
                    level: level,
                    restartAction: {
                        resetGame()
                        appState = .game
                    },
                    menuAction: {
                        resetGame()
                        appState = .menu
                    }
                )
                .background(BlurView(style: .systemUltraThinMaterialDark))
            }
        }
        .transition(.opacity)
        .animation(.easeInOut, value: appState)
    }
    
    // MARK: - Game Functions
    private func startGame() {
        let screenSize = UIScreen.main.bounds.size
        shark = Shark(color: colors.randomElement() ?? .blue, position: CGPoint(x: screenSize.width/2, y: screenSize.height/2))
        score = 0
        gameOver = false
        fishes.removeAll()
        
        // Start game loop
        gameTimer = Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { _ in
            updateGame()
        }
        
        // Start fish spawning
        startSpawningFish()
    }
    
    private func resetGame() {
        gameTimer?.invalidate()
        spawnTimer?.invalidate()
    }
    
    private func startSpawningFish() {
        let baseInterval = max(0.3, 2.0 - Double(level) * 0.15)
        spawnTimer = Timer.scheduledTimer(withTimeInterval: baseInterval, repeats: true) { _ in
            spawnFish()
        }
    }
    
    private func spawnFish() {
        let screenSize = UIScreen.main.bounds.size
        let directions: [Fish.Direction] = [.top, .bottom, .left, .right]
        let direction = directions.randomElement()!
        
        var position: CGPoint
        
        switch direction {
        case .top:
            position = CGPoint(x: CGFloat.random(in: 50...screenSize.width-50), y: -30)
        case .bottom:
            position = CGPoint(x: CGFloat.random(in: 50...screenSize.width-50), y: screenSize.height+30)
        case .left:
            position = CGPoint(x: -30, y: CGFloat.random(in: 50...screenSize.height-50))
        case .right:
            position = CGPoint(x: screenSize.width+30, y: CGFloat.random(in: 50...screenSize.height-50))
        }
        
        // 10% chance of bomb in higher levels
        let isBomb = level > 2 && Double.random(in: 0...1) < 0.1
        let fishColor = isBomb ? colors.randomElement()! : colors.randomElement()!
        
        let baseSpeed = min(10.0, 1.0 + Double(level) * 0.5)
        let speed = CGFloat.random(in: CGFloat(baseSpeed * 0.8)...CGFloat(baseSpeed * 1.2))
        
        let newFish = Fish(
            color: fishColor,
            direction: direction,
            position: position,
            speed: speed,
            isBomb: isBomb
        )
        
        fishes.append(newFish)
    }
    
    private func updateGame() {
        // Move fishes
        for index in fishes.indices {
            switch fishes[index].direction {
            case .top:
                fishes[index].position.y += fishes[index].speed
            case .bottom:
                fishes[index].position.y -= fishes[index].speed
            case .left:
                fishes[index].position.x += fishes[index].speed
            case .right:
                fishes[index].position.x -= fishes[index].speed
            }
        }
        
        // Remove off-screen fishes
        let screenSize = UIScreen.main.bounds.size
        fishes.removeAll { fish in
            fish.position.x < -50 || fish.position.x > screenSize.width + 50 ||
            fish.position.y < -50 || fish.position.y > screenSize.height + 50
        }
        
        // Check collisions
        checkCollisions()
        
        // Level up every 10 points
        let newLevel = min(15, score / 10 + 1)
        if newLevel > level {
            level = newLevel
            spawnTimer?.invalidate()
            startSpawningFish()
        }
    }
    
    private func checkCollisions() {
        let sharkRadius: CGFloat = 25
        let fishRadius: CGFloat = 15
        
        for index in fishes.indices {
            let distance = hypot(fishes[index].position.x - shark.position.x, fishes[index].position.y - shark.position.y)
            if distance < sharkRadius + fishRadius {
                // Collision detected
                if fishes[index].color == shark.color && !fishes[index].isBomb {
                    // Correct fish - add score
                    score += 1
                } else if fishes[index].isBomb {
                    // Bomb - lose health
                    shark.health -= 2
                } else {
                    // Wrong fish - lose health
                    shark.health -= 1
                }
                
                // Remove the fish
                fishes.remove(at: index)
                
                // Check game over
                if shark.health <= 0 {
                    gameOver = true
                    gameTimer?.invalidate()
                    spawnTimer?.invalidate()
                    saveScore()
                    appState = .gameOver
                }
                
                break // Only process one collision per frame
            }
        }
    }
    
    private func saveScore() {
        let newScore = GameScore(score: score, date: Date(), level: level)
        scores.append(newScore)
        scores.sort { $0.score > $1.score }
        
        if let encoded = try? JSONEncoder().encode(scores) {
            UserDefaults.standard.set(encoded, forKey: "gameScores")
        }
    }
    
    private func loadScores() {
        if let data = UserDefaults.standard.data(forKey: "gameScores") {
            if let decoded = try? JSONDecoder().decode([GameScore].self, from: data) {
                scores = decoded
            }
        }
    }
}
