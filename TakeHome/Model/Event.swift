//
//  EventEntity.swift
//  TakeHome
//
//  Created by Alberto Enrique Ortiz Chavolla on 23/08/21.
//  Copyright © 2021 Alberto Enrique Ortiz Chavolla. All rights reserved.
//

import Foundation

// MARK: - EventElement
struct Event: Codable {
    private enum CodingKeys: String, CodingKey {
        case title
        case start
        case end
    }
    
    let title, day: String
    let start, end: Date?
    let start_t, end_t: TimeInterval
    let hasConflict: Bool
    let conflicts: [Conflict]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: CodingKeys.title)
        
        let startString = try container.decode(String.self, forKey: CodingKeys.start)
        let endString = try container.decode(String.self, forKey: CodingKeys.end)
        self.start = DateFormatter.eventDateFormatter.date(from: startString)
        self.end = DateFormatter.eventDateFormatter.date(from: endString)
        self.day = DateFormatter.dayDateFormatter.string(from: self.start ?? Date())
        self.start_t = self.start?.timeIntervalSince1970 ?? 0
        self.end_t = self.end?.timeIntervalSince1970 ?? 0
        
        self.hasConflict = false
        self.conflicts = []
        
    }
}

typealias Conflict = [Event]

