//
//  TimelineCellAppearance.swift
//  Evergreen
//
//  Created by Brent Simmons on 2/6/16.
//  Copyright © 2016 Ranchero Software, LLC. All rights reserved.
//

import AppKit
import DB5

struct TimelineCellAppearance: Equatable {

	let cellPadding: NSEdgeInsets
	
	let feedNameColor: NSColor
	let feedNameFont: NSFont

	let dateColor: NSColor
	let dateMarginLeft: CGFloat
	let dateFont: NSFont
	
	let titleColor: NSColor
	let titleFont: NSFont
	let titleBottomMargin: CGFloat
	
	let textColor: NSColor
	let textFont: NSFont

	let textOnlyColor: NSColor
	let textOnlyFont: NSFont

	let unreadCircleColor: NSColor
	let unreadCircleDimension: CGFloat
	let unreadCircleMarginRight: CGFloat

	let starDimension: CGFloat

	let gridColor: NSColor
	let drawsGrid: Bool

	let avatarSize: NSSize
	let avatarMarginRight: CGFloat
	let avatarMarginLeft: CGFloat
	let avatarAdjustmentTop: CGFloat
	let avatarCornerRadius: CGFloat
	let showAvatar: Bool

	let boxLeftMargin: CGFloat

	init(theme: VSTheme, showAvatar: Bool, fontSize: FontSize) {

		let actualFontSize = AppDefaults.actualFontSize(for: fontSize)
		let smallItemFontSize = floor(actualFontSize * 0.95)
		let largeItemFontSize = floor(actualFontSize * 1.1)

		self.cellPadding = theme.edgeInsets(forKey: "MainWindow.Timeline.cell.padding")
		
		self.feedNameColor = theme.color(forKey: "MainWindow.Timeline.cell.feedNameColor")
		self.feedNameFont = NSFont.systemFont(ofSize: smallItemFontSize)

		self.dateColor = theme.color(forKey: "MainWindow.Timeline.cell.dateColor")
		self.dateFont = NSFont.systemFont(ofSize: smallItemFontSize)
		self.dateMarginLeft = theme.float(forKey: "MainWindow.Timeline.cell.dateMarginLeft")
		
		self.titleColor = theme.color(forKey: "MainWindow.Timeline.cell.titleColor")
		self.titleFont = NSFont.systemFont(ofSize: largeItemFontSize, weight: NSFont.Weight.semibold)
		self.titleBottomMargin = theme.float(forKey: "MainWindow.Timeline.cell.titleMarginBottom")
		
		self.textColor = theme.color(forKey: "MainWindow.Timeline.cell.textColor")
		self.textFont = NSFont.systemFont(ofSize: largeItemFontSize)

		self.textOnlyColor = theme.color(forKey: "MainWindow.Timeline.cell.textOnlyColor")
		self.textOnlyFont = NSFont.systemFont(ofSize: largeItemFontSize)

		self.unreadCircleColor = theme.color(forKey: "MainWindow.Timeline.cell.unreadCircleColor")
		self.unreadCircleDimension = theme.float(forKey: "MainWindow.Timeline.cell.unreadCircleDimension")
		self.unreadCircleMarginRight = theme.float(forKey: "MainWindow.Timeline.cell.unreadCircleMarginRight")

		self.starDimension = theme.float(forKey: "MainWindow.Timeline.cell.starDimension")
		
		self.gridColor = theme.colorWithAlpha(forKey: "MainWindow.Timeline.gridColor")
		self.drawsGrid = theme.bool(forKey: "MainWindow.Timeline.drawsGrid")
		
		self.avatarSize = theme.size(forKey: "MainWindow.Timeline.cell.avatar")
		self.avatarMarginRight = theme.float(forKey: "MainWindow.Timeline.cell.avatarMarginRight")
		self.avatarMarginLeft = theme.float(forKey: "MainWindow.Timeline.cell.avatarMarginLeft")
		self.avatarAdjustmentTop = theme.float(forKey: "MainWindow.Timeline.cell.avatarAdjustmentTop")
		self.avatarCornerRadius = theme.float(forKey: "MainWindow.Timeline.cell.avatarCornerRadius")
		self.showAvatar = showAvatar

		let margin = self.cellPadding.left + self.unreadCircleDimension + self.unreadCircleMarginRight
//		if showAvatar {
//			margin += (self.avatarSize.width + self.avatarMarginRight)
//		}
		self.boxLeftMargin = margin
	}

	static func ==(lhs: TimelineCellAppearance, rhs: TimelineCellAppearance) -> Bool {

		return lhs.boxLeftMargin == rhs.boxLeftMargin && lhs.showAvatar == rhs.showAvatar && lhs.cellPadding == rhs.cellPadding && lhs.feedNameColor == rhs.feedNameColor && lhs.feedNameFont == rhs.feedNameFont && lhs.dateColor == rhs.dateColor && lhs.dateMarginLeft == rhs.dateMarginLeft && lhs.dateFont == rhs.dateFont && lhs.titleColor == rhs.titleColor && lhs.titleFont == rhs.titleFont && lhs.titleBottomMargin == rhs.titleBottomMargin && lhs.textColor == rhs.textColor && lhs.textFont == rhs.textFont && lhs.unreadCircleColor == rhs.unreadCircleColor && lhs.unreadCircleDimension == rhs.unreadCircleDimension && lhs.unreadCircleMarginRight == rhs.unreadCircleMarginRight && lhs.gridColor == rhs.gridColor && lhs.avatarSize == rhs.avatarSize && lhs.avatarMarginRight == rhs.avatarMarginRight && lhs.avatarAdjustmentTop == rhs.avatarAdjustmentTop && lhs.avatarCornerRadius == rhs.avatarCornerRadius
	}
}

extension NSEdgeInsets: Equatable {

	public static func ==(lhs: NSEdgeInsets, rhs: NSEdgeInsets) -> Bool {

		return lhs.left == rhs.left && lhs.top == rhs.top && lhs.right == rhs.right && lhs.bottom == rhs.bottom
	}
}
