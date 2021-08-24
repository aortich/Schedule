//
//  Calendar.swift
//  TakeHome
//
//  Created by Alberto Enrique Ortiz Chavolla on 23/08/21.
//  Copyright © 2021 Alberto Enrique Ortiz Chavolla. All rights reserved.
//

import Foundation

struct Calendar {
    let events: [Event]
    var groupedEvents: Dictionary<String, [Event]>?
    var sortedDays: [String]?
    var conflictMap = Dictionary<String, [Conflict]>()
    
    init(events: [Event]) {
        self.events = events
        self.groupedEvents = getEventsByDay()
        self.sortedDays = getSortedKeys()
        self.conflictMap = conflicts()
    }
        
    ///*This algorithm performs in O(n), the algorithm is assuming that
    ///event list is already ordered, luckily our data source takes care
    ///of sorting for us. Algorithm returns a dictionary of all conflicts, so later we can
    ///consult if event has conflict in O(1)*/
    func conflicts() -> Dictionary<String, [Conflict]> {
        var conflicts = Dictionary<String, [Conflict]>()
        
        //makes an instance of a single possible conflict
        var singleConflict: Conflict = [self.events[0]]
        
        var end = self.events[0].end_t
        for i in 1 ..< self.events.count {
            let event = self.events[i]
            //Compares current event start interval with previous end interval
            //to see if event overlaps with previous event
            if(event.start_t >= end) {
                //if current start interval and previous end interval do not conflict, then we assume there is no conflict, or that conflict has already ended
                if(singleConflict.count > 1) {
                    //a conflict can only exist between two or more events
                    
                    //add conflict to map for easy consult later on
                    // we're using event title as key even though they might not be unique
                    // but hopefully it's understandable due to the lack of a proper unique ID
                    // within the example json
                    singleConflict.forEach{
                        var eventConflicts = conflicts[$0.title] ?? []
                        eventConflicts.append(singleConflict)
                        conflicts[$0.title] = eventConflicts
                    }
                }
                //either we didn't find a conflict or conflict has already been stored in the result array, so we can stop keeping track of current conflict
                singleConflict.removeAll()
            }
            //we get the maximum end time in case current conflicting event has a shorter duration than previous event
            end = Swift.max(event.end_t, end)
            //conflict instance keeps accumulating events in a single conflict as long as start and end intervals keep overlapping,
            //thus we can get conflicts involving more than two events
            singleConflict.append(event)
            
        }
        
        return conflicts
    }
    
    /*group events to get a more readable schedule view*/
    private func getEventsByDay() -> Dictionary<String, [Event]> {
        Dictionary(grouping: self.events, by: { $0.day })
    }
    
    /*Sort grouped events keys*/
    private func getSortedKeys() -> [String] {
        guard let dictionary = self.groupedEvents else {
            return []
        }
        
        return dictionary.keys.sorted { a, b -> Bool in
            DateFormatter.dayDateFormatter.date(from: a) ?? Date.init(timeIntervalSince1970: 0) <
                DateFormatter.dayDateFormatter.date(from: b) ?? Date.init(timeIntervalSince1970: 0)
        }
    }
    
    func doesEventConflict(event: Event) -> Bool {
        return conflictMap[event.title] != nil
    }
}
