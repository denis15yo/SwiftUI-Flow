import SwiftUI

/// A layout that arranges its children in a vertically flowing manner.
@available(iOS 16.0, *)
@frozen
public struct VFlowLayout {
    @usableFromInline
    let layout: FlowLayout

    /// Creates a vertical flow layout with the given spacing and horizontal alignment.
    ///
    /// - Parameters:
    ///   - alignment: The guide for aligning the subviews in this flow. This
    ///     guide has the same vertical screen coordinate for every child view.
    ///   - itemSpacing: The distance between adjacent subviews, or `nil` if you
    ///     want the flow to choose a default distance for each pair of subviews.
    ///   - columnSpacing: The distance between adjacent columns, or `nil` if you
    ///     want the flow to choose a default distance for each pair of columns.
    ///   - justification: Whether the layout should fill the remaining
    ///     available space in each column by stretching either items or spaces.
    ///   - distributeItemsEvenly: Instead of prioritizing the first columns, this
    ///     mode tries to distribute items more evenly by minimizing the empty
    ///     spaces left in each column, while respecting their order.
    @inlinable
    public init(
        alignment: HorizontalAlignment = .center,
        itemSpacing: CGFloat? = nil,
        columnSpacing: CGFloat? = nil,
        justification: Justification? = nil,
        distributeItemsEvenly: Bool = false
    ) {
        self.init(
            horizontalAlignment: alignment,
            verticalAlignment: .top,
            horizontalSpacing: columnSpacing,
            verticalSpacing: itemSpacing,
            justification: justification,
            distributeItemsEvenly: distributeItemsEvenly
        )
    }

    /// Creates a vertical flow with the given spacing and alignment.
    ///
    /// - Parameters:
    ///   - horizonalAlignment: The guide for aligning the subviews horizontally.
    ///   - horizonalSpacing: The distance between subviews on the horizontal axis.
    ///   - verticalAlignment: The guide for aligning the subviews vertically.
    ///   - verticalSpacing: The distance between subviews on the vertical axis.
    ///   - justification: Whether the layout should fill the remaining
    ///     available space in each column by stretching either items or spaces.
    ///   - distributeItemsEvenly: Instead of prioritizing the first columns, this
    ///     mode tries to distribute items more evenly by minimizing the empty
    ///     spaces left in each column, while respecting their order.
    ///   - content: A view builder that creates the content of this flow.
    @inlinable
    public init(
        horizontalAlignment: HorizontalAlignment,
        verticalAlignment: VerticalAlignment,
        horizontalSpacing: CGFloat? = nil,
        verticalSpacing: CGFloat? = nil,
        justification: Justification? = nil,
        distributeItemsEvenly: Bool = false
    ) {
        layout = .vertical(
            horizontalAlignment: horizontalAlignment,
            verticalAlignment: verticalAlignment,
            horizontalSpacing: horizontalSpacing,
            verticalSpacing: verticalSpacing,
            justification: justification,
            distributeItemsEvenly: distributeItemsEvenly
        )
    }
}

@available(iOS 16.0, *)
extension VFlowLayout: Layout {
    @inlinable
    public func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: LayoutSubviews,
        cache: inout FlowLayoutCache
    ) -> CGSize {
        layout.sizeThatFits(proposal: proposal, subviews: subviews, cache: &cache)
    }

    @inlinable
    public func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: LayoutSubviews,
        cache: inout FlowLayoutCache
    ) {
        layout.placeSubviews(in: bounds, proposal: proposal, subviews: subviews, cache: &cache)
    }

    @inlinable
    public func makeCache(subviews: LayoutSubviews) -> FlowLayoutCache {
        FlowLayoutCache(subviews, axis: .vertical)
    }

    @inlinable
    public static var layoutProperties: LayoutProperties {
        var properties = LayoutProperties()
        properties.stackOrientation = .vertical
        return properties
    }
}
