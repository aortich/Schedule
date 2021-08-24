//
//  EventCellViewModel.swift
//  TakeHome
//
//  Created by Alberto Enrique Ortiz Chavolla on 23/08/21.
//  Copyright © 2021 Alberto Enrique Ortiz Chavolla. All rights reserved.
//

import Foundation

extension EventCell {
    class ViewModel {
        let event: Event
        let title: String
        let hourInterval: String
        let eventConflict: Bool
        
        init(event: Event, eventConflict: Bool = false) {
            self.event = event
            self.title = event.title
            self.eventConflict = eventConflict
            
            if let start = event.start, let end = event.end  {
                self.hourInterval =
                    "\(DateFormatter.hourDateFormatter.string(from: start)) - \(DateFormatter.hourDateFormatter.string(from: end))"
            } else {
                self.hourInterval = ""
            }
        }
    }
}
