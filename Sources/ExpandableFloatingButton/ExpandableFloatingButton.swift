import SwiftUI

@available(iOS 18.0, macOS 14.0, *)
public struct ExpandableFloatingButton: View {
    // MARK:  Internal Properties
    @State var isPushed: Bool = false
    var isGradient: Bool = true

    // MARK: Argument Properties
    // Systemname
    var mainSystemName: String
    var firstSystemName: String
    var secondSystemName: String
    var thirdSystemName: String

    // Color
    var mainButtonColor: Color
    var firstButtonColor: Color
    var secondButtonColor: Color
    var thirdButtonColor: Color

    // MARK: Public Initializer
    public init(
        isGradient: Bool = true,
        mainSystemName: String = "plus",
        firstSystemName: String = "person.fill",
        secondSystemName: String = "bell.fill",
        thirdSystemName: String = "square.and.arrow.up",
        mainButtonColor: Color = .gray,
        firstButtonColor: Color = .red,
        secondButtonColor: Color = .blue,
        thirdButtonColor: Color = .green
    ) {
        self.isGradient = isGradient
        self.mainSystemName = mainSystemName
        self.firstSystemName = firstSystemName
        self.secondSystemName = secondSystemName
        self.thirdSystemName = thirdSystemName
        self.mainButtonColor = mainButtonColor
        self.firstButtonColor = firstButtonColor
        self.secondButtonColor = secondButtonColor
        self.thirdButtonColor = thirdButtonColor
    }

    public var body: some View {
        ButtonView(action: {}, systemName: firstSystemName, color: firstButtonColor, isPushed: $isPushed, isGradient: isGradient)
            .shadow(radius: 8)
            .offset(x: isPushed ? -64 : 0)
            .opacity(isPushed ? 1 : 0)

        ButtonView(action: {}, systemName: secondSystemName, color: secondButtonColor, isPushed: $isPushed, isGradient: isGradient)
            .shadow(radius: 8)
            .offset(x: isPushed ? -56 : 0, y: isPushed ? -56 : 0)
            .opacity(isPushed ? 1 : 0)

        ButtonView(action: {}, systemName: thirdSystemName, color: thirdButtonColor, isPushed: $isPushed, isGradient: isGradient)
            .shadow(radius: 8)
            .offset(y: isPushed ? -64 : 0)
            .opacity(isPushed ? 1 : 0)

        ButtonView(action: {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.4, blendDuration: 0.2)) {
                isPushed.toggle()
            }
        }, systemName: mainSystemName, color: mainButtonColor, isPushed: $isPushed, isGradient: isGradient)
        .shadow(radius: 4)
        .rotationEffect(.degrees(isPushed ? 405 : 0))
        .scaleEffect(isPushed ? 1.3 : 1)
    }

    struct ButtonView: View {
        // Arguments
        let action: () -> Void
        let systemName: String
        let color: Color

        // Internal Properties
        @Binding var isPushed: Bool
        let isGradient: Bool

        public var body: some View {
            if isGradient {
                Button(action: {action()}, label: {
                    Image(systemName: systemName)
                        .padding()
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .background(
                            Circle()
                                .foregroundStyle(color.gradient)
                        )
                })
            } else {
                Button(action: {action()}, label: {
                    Image(systemName: systemName)
                        .padding()
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .background(
                            Circle()
                                .foregroundStyle(color)
                        )
                })
            }

        }
    }
}

