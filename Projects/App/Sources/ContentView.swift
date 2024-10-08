import SwiftUI
import CoreKit
import NetworkKit
import DesignCore
import Main

public struct ContentView: View {
    public init() {}

    public var body: some View {
        VStack(spacing: 20) {
            Text("Hello, World!")
                .padding()
                .pretendard(weight: ._300, size: 20)
                .robotoSlab(size: 12)
            
            MainView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
