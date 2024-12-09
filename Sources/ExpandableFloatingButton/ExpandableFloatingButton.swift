import SwiftUI

@available(iOS 18.0, macOS 14.0, *)
@MainActor
/// A customizable Expandable Floating Button component for SwiftUI.
public struct ExpandableFloatingButton: View {
    // MARK: - Enum
    /// Defines the floating button's background style for the buttons.
    public enum FloatingButtonBackgroundStyle {
        case solid
        case gradient
    }

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

    /// The gradient style for the buttons.
    let floatingButtonBackgroundStyle: FloatingButtonBackgroundStyle

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
        - buttonSize: The size of the floating buttons. Default is `32`.
        - floatingButtonBackgroundStyle: Specifies the background style of the buttons. Default is `.solid`.
        - animationType: The animation for expanding the buttons. Default is `.spring(response: 0.5, dampingFraction: 0.4, blendDuration: 0.2)`.
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
        floatingButtonBackgroundStyle: FloatingButtonBackgroundStyle = .solid,
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
        self.floatingButtonBackgroundStyle = floatingButtonBackgroundStyle
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
                gradientStyle: floatingButtonBackgroundStyle,
                isExpanded: $isExpanded
            )
            .shadow(radius: 8)
            .offset(x: isExpanded ? -buttonSize * 2.5 : 0)
            .opacity(isExpanded ? 1 : 0)

            // Second Button
            FloatingButton(
                action: { secondButtonAction() },
                systemName: secondButtonIconName,
                color: secondButtonColor,
                buttonSize: buttonSize,
                gradientStyle: floatingButtonBackgroundStyle,
                isExpanded: $isExpanded
            )
            .shadow(radius: 8)
            .offset(x: isExpanded ? -buttonSize * 2.25 : 0, y: isExpanded ? -buttonSize * 2.25 : 0)
            .opacity(isExpanded ? 1 : 0)

            // Third Button
            FloatingButton(
                action: { thirdButtonAction() },
                systemName: thirdButtonIconName,
                color: thirdButtonColor,
                buttonSize: buttonSize,
                gradientStyle: floatingButtonBackgroundStyle,
                isExpanded: $isExpanded
            )
            .shadow(radius: 8)
            .offset(y: isExpanded ? -buttonSize * 2.5 : 0)
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
                gradientStyle: floatingButtonBackgroundStyle,
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
        let gradientStyle: FloatingButtonBackgroundStyle

        // Internal Properties
        @Binding var isExpanded: Bool
        private var backgroundStyle: some ShapeStyle {
            switch gradientStyle {
            case .solid: return AnyShapeStyle(color)
            case .gradient: return AnyShapeStyle(color.gradient)
            }
        }

        var body: some View {
            Button(action: { action() }) {
                Image(systemName: systemName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: buttonSize, height: buttonSize)
                    .padding(buttonSize * 0.5)
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
