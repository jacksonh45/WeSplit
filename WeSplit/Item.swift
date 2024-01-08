//
//  Item.swift
//  WeSplit
//
//  Created by Jackson Harrison on 1/8/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
