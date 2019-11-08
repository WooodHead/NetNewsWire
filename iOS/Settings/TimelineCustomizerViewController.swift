//
//  TimelineCustomizerViewController.swift
//  NetNewsWire-iOS
//
//  Created by Maurice Parker on 11/8/19.
//  Copyright © 2019 Ranchero Software. All rights reserved.
//

import UIKit

class TimelineCustomizerViewController: UIViewController {

	@IBOutlet weak var iconSizeSliderContainerView: UIView!
	@IBOutlet weak var iconSizeSlider: UISlider!
	@IBOutlet weak var numberOfLinesSliderContainerView: UIView!
	@IBOutlet weak var numberOfLinesSlider: UISlider!
	
	@IBOutlet weak var previewWidthConstraint: NSLayoutConstraint!
	@IBOutlet weak var previewHeightConstraint: NSLayoutConstraint!
	
	@IBOutlet weak var previewContainerView: UIView!
	var previewController: TimelinePreviewTableViewController {
		return children.first as! TimelinePreviewTableViewController
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()

		iconSizeSliderContainerView.layer.cornerRadius = 12
		numberOfLinesSliderContainerView.layer.cornerRadius = 12
		
		numberOfLinesSlider.value = Float(AppDefaults.timelineNumberOfLines)
		iconSizeSlider.value = Float(AppDefaults.timelineIconSize.rawValue)
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		updatePreviewBorder()
		updatePreview()
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		updatePreviewBorder()
		updatePreview()
	}

	@IBAction func iconSizeChanged(_ sender: Any) {
		guard let iconSize = MasterTimelineIconSize(rawValue: Int(iconSizeSlider.value)) else { return }
		AppDefaults.timelineIconSize = iconSize
		updatePreview()
	}
	
	@IBAction func numberOfLinesChanged(_ sender: Any) {
		AppDefaults.timelineNumberOfLines = Int(numberOfLinesSlider.value)
		updatePreview()
	}
	
}

// MARK: Private

private extension TimelineCustomizerViewController {
	
	func updatePreview() {
		let previewWidth: CGFloat = {
			if traitCollection.userInterfaceIdiom == .phone {
				return view.bounds.width
			} else {
				return view.bounds.width / 1.5
			}
		}()
		
		previewWidthConstraint.constant = previewWidth
		previewHeightConstraint.constant = previewController.heightFor(width: previewWidth)
		
		previewController.reload()
	}
	
	func updatePreviewBorder() {
		if traitCollection.userInterfaceStyle == .dark {
			previewContainerView.layer.borderColor = UIColor.black.cgColor
			previewContainerView.layer.borderWidth = 1
		} else {
			previewContainerView.layer.borderWidth = 0
		}
	}
	
}