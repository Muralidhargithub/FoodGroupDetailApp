//
//  AnalyticsManager.swift
//  PracticeFoodGroup
//
//  Created by Muralidhar reddy Kakanuru on 12/18/24.
//

import Firebase
import Foundation

class AnalyticsManager {
    static let shared = AnalyticsManager()
    private init() {}

    func logItemSelected(itemName: String, Description: String) {
        Analytics.logEvent("item_selected", parameters: [
            "item_name": itemName,
            "item_price": Description
        ])
        print("Firebase Event Logged: Item Name: \(itemName), Description: \(Description)")
    }
}
