//
//  ExtensionPointIdentifer.swift
//  NetNewsWire
//
//  Created by Maurice Parker on 4/8/20.
//  Copyright © 2020 Ranchero Software. All rights reserved.
//

import Foundation
import Account
import RSCore

enum ExtensionPointIdentifer: Hashable {
	#if os(macOS)
	case marsEdit
	case microblog
	#endif
	case twitter(String)
	
	var extensionPointType: ExtensionPoint.Type {
		switch self {
		#if os(macOS)
		case .marsEdit:
			return SendToMarsEditCommand.self
		case .microblog:
			return SendToMicroBlogCommand.self
		#endif
		case .twitter:
			return TwitterFeedProvider.self
		}
	}
	
	public var userInfo: [AnyHashable: AnyHashable] {
		switch self {
		#if os(macOS)
		case .marsEdit:
			return [
				"type": "marsEdit"
			]
		case .microblog:
			return [
				"type": "microblog"
			]
		#endif
		case .twitter(let screenName):
			return [
				"type": "twitter",
				"screenName": screenName
			]
		}
	}
	
	public init?(userInfo: [AnyHashable: AnyHashable]) {
		guard let type = userInfo["type"] as? String else { return nil }
		
		switch type {
		#if os(macOS)
		case "marsEdit":
			self = ExtensionPointIdentifer.marsEdit
		case "microblog":
			self = ExtensionPointIdentifer.microblog
		#endif
		case "twitter":
			guard let screenName = userInfo["screenName"] as? String else { return nil }
			self = ExtensionPointIdentifer.twitter(screenName)
		default:
			return nil
		}
	}
	
	public func hash(into hasher: inout Hasher) {
		switch self {
		#if os(macOS)
		case .marsEdit:
			hasher.combine("marsEdit")
		case .microblog:
			hasher.combine("microblog")
		#endif
		case .twitter(let screenName):
			hasher.combine("twitter")
			hasher.combine(screenName)
		}
	}
	
}
