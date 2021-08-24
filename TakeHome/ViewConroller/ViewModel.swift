//
//  ViewControllerPresenter.swift
//  TakeHome
//
//  Created by Alberto Enrique Ortiz Chavolla on 23/08/21.
//  Copyright © 2021 Alberto Enrique Ortiz Chavolla. All rights reserved.
//

import Foundation

extension ViewController {
    class ViewModel {
        let loadError: ((Error) -> Void)
        let didComplete: ((Calendar) -> Void)
        
        init(loadError: @escaping ((Error) -> Void), didComplete: @escaping ((Calendar) -> Void)) {
            self.loadError = loadError
            self.didComplete = didComplete
        }
        
        func loadCalendar() {
            let repository = CalendarMockDataSource()
            switch repository.getCalendar() {
            case .error(let error):
                self.loadError(error)
            case .success(let events):
                self.didComplete(Calendar(events: events))
            default:
                break
            }
        }
        
    }
}
