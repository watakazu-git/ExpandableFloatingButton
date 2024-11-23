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
    let firstButtonColor: Color
    /// The color of the second floating button.
    let secondButtonColor: Color
    /// The color of the third floating button.
    let thirdButtonColor: Color

    /// The action to perform when the first floating button is tapped.
    let firstButtonAction: () -> Void
    /// The action to perform when the second floating button is tapped.
    let secondButtonAction: () -> Void
    /// The action to perform when the third floating button is tapped.
    let thirdButtonAction: () -> Void

    /// The size of the floating buttons
    let buttonSize: CGFloat

    /// A Boolean value that determines whether to use gradient backgrounds for the buttons.
    let usesGradient: Bool

    /// The animation type for the floating button expansion.
    let animationType: Animation

    // MARK: - Internal Properties
    /// A Boolean value that determines whether the floating buttons are expanded or collapsed.
    @State private var isExpanded: Bool = false

    // MARK: - Public Initializer
    /**
     Initializes an ExpandableFloatingButton with customizable options.

     - Parameters:
        - mainIconName: The system name for the main button icon. Default is `plus`.
        - firstButtonIconName: The system name for the first expandable button icon. Default is `"person.fill"`.
        - secondButtonIconName: The system name for the second expandable button icon. Default is `"bell.fill"`.
        - thirdButtonIconName: The system name for the third expandable button icon. Default is `"square.and.arrow.up"`.
        - mainIconColor: The color of the main button. Default is `.gray`.
        - firstButtonColor: The color of the first expandable button. Default is `.red`.
        - secondButtonColor: The color of the second expandable button. Default is `.blue`.
        - thirdButtonColor: The color of the third expandable button. Default is `.green`.
        - buttonSize: The size of the floating buttons. Default is `48`.
        - usesGradient: A Boolean value that indicates whether to use gradient backgrounds. Default is `false`.
        - animationType: The animation to be used when expanding or collapsing the buttons.Default is `.spring(response: 0.5, dampingFraction: 0.4, blendDuration: 0.2)`. This parameter allows you to customize the type of animation, such as `.linear`, `.easeInOut`, or a custom spring animation, to achieve the desired transition effect when the floating button toggles between expanded and collapsed states.
     */

    public init(
        mainIconName: String = "plus",
        firstButtonIconName: String = "person.fill",
        secondButtonIconName: String = "bell.fill",
        thirdButtonIconName: String = "square.and.arrow.up",
        mainIconColor: Color = .gray,
        firstButtonColor: Color = .red,
        secondButtonColor: Color = .blue,
        thirdButtonColor: Color = .green,
        firstButtonAction: @escaping () -> Void = {},
        secondButtonAction: @escaping () -> Void = {},
        thirdButtonAction: @escaping () -> Void = {},
        buttonSize: CGFloat = 32,
        usesGradient: Bool = false,
        animationType: Animation = .spring(response: 0.5, dampingFraction: 0.4, blendDuration: 0.2)
    ) {
        self.mainIconName = mainIconName
        self.firstButtonIconName = firstButtonIconName
        self.secondButtonIconName = secondButtonIconName
        self.thirdButtonIconName = thirdButtonIconName
        self.mainIconColor = mainIconColor
        self.firstButtonColor = firstButtonColor
        self.secondButtonColor = secondButtonColor
        self.thirdButtonColor = thirdButtonColor
        self.firstButtonAction = firstButtonAction
        self.secondButtonAction = secondButtonAction
        self.thirdButtonAction = thirdButtonAction
        self.buttonSize = buttonSize
        self.usesGradient = usesGradient
        self.animationType = animationType
    }

    // MARK: - Body
    public var body: some View {
        ZStack {
            // First Button
            FloatingButton(
                action: { firstButtonAction() },
                systemName: firstButtonIconName,
                color: firstButtonColor,
                buttonSize: buttonSize,
                usesGradient: usesGradient,
                isExpanded: $isExpanded
            )
            .shadow(radius: 8)
            .offset(x: isExpanded ? -64 : 0)
            .opacity(isExpanded ? 1 : 0)

            // Second Button
            FloatingButton(
                action: { secondButtonAction() },
                systemName: secondButtonIconName,
                color: secondButtonColor,
                buttonSize: buttonSize,
                usesGradient: usesGradient,
                isExpanded: $isExpanded
            )
            .shadow(radius: 8)
            .offset(x: isExpanded ? -56 : 0, y: isExpanded ? -56 : 0)
            .opacity(isExpanded ? 1 : 0)

            // Third Button
            FloatingButton(
                action: { thirdButtonAction() },
                systemName: thirdButtonIconName,
                color: thirdButtonColor,
                buttonSize: buttonSize,
                usesGradient: usesGradient,
                isExpanded: $isExpanded
            )
            .shadow(radius: 8)
            .offset(y: isExpanded ? -64 : 0)
            .opacity(isExpanded ? 1 : 0)

            // Main Button with toggle action
            FloatingButton(
                action: {
                    withAnimation(animationType) {
                        isExpanded.toggle()
                    }
                },
                systemName: mainIconName,
                color: mainIconColor,
                buttonSize: buttonSize,
                usesGradient: usesGradient,
                isExpanded: $isExpanded
            )
            .shadow(radius: 4)
            .rotationEffect(.degrees(isExpanded ? 405 : 0))
            .scaleEffect(isExpanded ? 1.3 : 1)
        }
    }

    // MARK: - FloatingButton
    /// A subview representing a single button in the floating button stack.
    private struct FloatingButton: View {
        // Arguments
        let action: () -> Void
        let systemName: String
        let color: Color
        let buttonSize: CGFloat
        let usesGradient: Bool

        // Internal Properties
        @Binding var isExpanded: Bool
        private var backgroundStyle: some ShapeStyle {
            usesGradient ? AnyShapeStyle(color.gradient) : AnyShapeStyle(color)
        }

        var body: some View {
            Button(action: { action() }) {
                Image(systemName: systemName)
                    .resizable()
                    .frame(width: buttonSize, height: buttonSize)
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
