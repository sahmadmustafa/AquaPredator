
import SwiftUI

// MARK: - Splash Screen
struct SplashScreen: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.1, green: 0.3, blue: 0.6), Color(red: 0.2, green: 0.5, blue: 0.9)]),
                          startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Image(systemName: "fish.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                    .shadow(color: .blue, radius: 20)
                
                Text("Aqua Predator")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 5, x: 2, y: 2)
                    .padding(.top, 20)
                
                Spacer()
                
                Text("Loading...")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.bottom, 50)
            }
        }
    }
}
