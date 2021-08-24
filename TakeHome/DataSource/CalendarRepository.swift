//
//  CalendarRepository.swift
//  TakeHome
//
//  Created by Alberto Enrique Ortiz Chavolla on 23/08/21.
//  Copyright © 2021 Alberto Enrique Ortiz Chavolla. All rights reserved.
//

import Foundation

protocol CalendarDataSourceProtocol {
    func getCalendar() -> CalendarResult?
}

class CalendarMockDataSource: CalendarDataSourceProtocol {
    func getCalendar() -> CalendarResult? {
        guard let path = Bundle.main.path(forResource: "mock", ofType: "json") else {
            return CalendarResult.error(error: .missingFile)
        }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return CalendarResult.error(error: .dataError)
        }
        
        guard let result = try? JSONDecoder().decode([Event].self, from: data) else {
            return CalendarResult.error(error: .serializationError)
        }
        
        //I´m pretending that events are already sorted from the backend
        return CalendarResult.success(events: result.sorted(by: { a, b -> Bool in
            a.start_t < b.start_t
        }))
    }
}

enum ParseError: Error {
    case dataError
    case missingFile
    case serializationError
}

enum CalendarResult {
    case success(events: [Event])
    case error(error: ParseError)
}
