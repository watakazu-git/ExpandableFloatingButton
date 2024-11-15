import SwiftUI

@available(iOS 18.0, macOS 14.0, *)
@MainActor
/// A customizable Expandable Floating Button component for SwiftUI.
public struct ExpandableFloatingButton: View {
    // MARK: - Argument Properties
    /// The system name for the main floating button icon.
    let mainIconName: String
    /// The system name for the first floating button icon.
    let firstButtonIconName: String
    /// The system name for the floating floating button icon.
    let secondButtonIconName: String
    /// The system name for the third floating button icon.
    let thirdButtonIconName: String

    /// The color of the main floating button.
    let mainIconColor: Color
    /// The color of the first floating button.
    let firstButtonIconColor: Color
    /// The color of the second floating button.
    let secondButtonIconColor: Color
    /// The color of the third floating button.
    let thirdButtonIconColor: Color

    /// The action to perform when the first floating button is tapped.
    let firstButtonAction: () -> Void
    /// The action to perform when the second floating button is tapped.
    let secondButtonAction: () -> Void
    /// The action to perform when the third floating button is tapped.
    let thirdButtonAction: () -> Void

    /// A Boolean value that determines whether to use gradient backgrounds for the buttons.
    let usesGradient: Bool

    // MARK: - Internal Properties
    /// A Boolean value that determines whether the floating buttons are expanded or collapsed.
    @State private var isExpanded: Bool = false

    // MARK: - Public Initializer
    /**
     Initializes an ExpandableFloatingButton with customizable options.

     - Parameters:
        - mainIconName: The system name for the main button icon. Default is `"plus"`.
        - firstButtonIconName: The system name for the first expandable button icon. Default is `"person.fill"`.
        - secondButtonIconName: The system name for the second expandable button icon. Default is `"bell.fill"`.
        - thirdButtonIconName: The system name for the third expandable button icon. Default is `"square.and.arrow.up"`.
        - mainIconColor: The color of the main button. Default is `.gray`.
        - firstButtonIconColor: The color of the first expandable button. Default is `.red`.
        - secondButtonIconColor: The color of the second expandable button. Default is `.blue`.
        - thirdButtonIconColor: The color of the third expandable button. Default is `.green`.
        - usesGradient: A Boolean value that indicates whether to use gradient backgrounds. Default is `false`.
     */

    public init(
        mainIconName: String = "plus",
        firstButtonIconName: String = "person.fill",
        secondButtonIconName: String = "bell.fill",
        thirdButtonIconName: String = "square.and.arrow.up",
        mainIconColor: Color = .gray,
        firstButtonIconColor: Color = .red,
        secondButtonIconColor: Color = .blue,
        thirdButtonIconColor: Color = .green,
        firstButtonAction: @escaping () -> Void = {},
        secondButtonAction: @escaping () -> Void = {},
        thirdButtonAction: @escaping () -> Void = {},
        usesGradient: Bool = false
    ) {
        self.mainIconName = mainIconName
        self.firstButtonIconName = firstButtonIconName
        self.secondButtonIconName = secondButtonIconName
        self.thirdButtonIconName = thirdButtonIconName
        self.mainIconColor = mainIconColor
        self.firstButtonIconColor = firstButtonIconColor
        self.secondButtonIconColor = secondButtonIconColor
        self.thirdButtonIconColor = thirdButtonIconColor
        self.usesGradient = usesGradient
        self.firstButtonAction = firstButtonAction
        self.secondButtonAction = secondButtonAction
        self.thirdButtonAction = thirdButtonAction
    }

    public var body: some View {
        // First Button
        FloatingButton(action: { firstButtonAction() }, systemName: firstButtonIconName, color: firstButtonIconColor, usesGradient: usesGradient, isExpanded: $isExpanded)
            .shadow(radius: 8)
            .offset(x: isExpanded ? -64 : 0)
            .opacity(isExpanded ? 1 : 0)

        // Second Button
        FloatingButton(action: { secondButtonAction() }, systemName: secondButtonIconName, color: secondButtonIconColor, usesGradient: usesGradient, isExpanded: $isExpanded)
            .shadow(radius: 8)
            .offset(x: isExpanded ? -56 : 0, y: isExpanded ? -56 : 0)
            .opacity(isExpanded ? 1 : 0)

        // Third Button
        FloatingButton(action: { thirdButtonAction() }, systemName: thirdButtonIconName, color: thirdButtonIconColor, usesGradient: usesGradient, isExpanded: $isExpanded)
            .shadow(radius: 8)
            .offset(y: isExpanded ? -64 : 0)
            .opacity(isExpanded ? 1 : 0)

        // Main Button with toggle action
        FloatingButton(action: {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.4, blendDuration: 0.2)) {
                isExpanded.toggle()
            }
        }, systemName: mainIconName, color: mainIconColor, usesGradient: usesGradient, isExpanded: $isExpanded)
        .shadow(radius: 4)
        .rotationEffect(.degrees(isExpanded ? 405 : 0))
        .scaleEffect(isExpanded ? 1.3 : 1)
    }

    // MARK: - FloatingButton
    /// A subview representing a single button in the floating button stack.
    private struct FloatingButton: View {
        // Arguments
        let action: () -> Void
        let systemName: String
        let color: Color
        let usesGradient: Bool

        // Internal Properties
        @Binding var isExpanded: Bool
        private var backgroundStyle: some ShapeStyle {
            usesGradient ? AnyShapeStyle(color.gradient) : AnyShapeStyle(color)
        }

        var body: some View {
            Button(action: { action() }) {
                Image(systemName: systemName)
                    .padding()
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .background(
                        Circle()
                            .foregroundStyle(backgroundStyle)
                    )
            }
        }
    }
}
