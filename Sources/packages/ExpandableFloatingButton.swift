import SwiftUI

@available(iOS 18.0, macOS 14.0, *)
public struct ExpandableFloatingButton: View {
    // MARK:  Internal Properties
    @State var isPushed: Bool = false
    let isGradient: Bool = true

    // MARK: Argument Properties
    let mainSystemName: String = "plus"
    let firstSystemName: String = "person.fill"
    let secondSystemName: String = "bell.fill"
    let thirdSystemName: String = "square.and.arrow.up"

    let mainButtonColor: Color = .gray
    let firstButtonColor: Color = .red
    let secondButtonColor: Color = .blue
    let thirdButtonColor: Color = .green

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

