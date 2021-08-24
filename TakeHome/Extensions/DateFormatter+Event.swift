//
//  TakeHome
//
//  Created by Alberto Enrique Ortiz Chavolla on 23/08/21.
//  Copyright © 2021 Alberto Enrique Ortiz Chavolla. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let eventDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US")
        df.dateFormat = "MMMM dd, yyyy hh:mm a"
        df.amSymbol = "AM"
        df.pmSymbol = "PM"
        return df
    }()
    
    static let hourDateFormatter: DateFormatter =  {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US")
        df.dateFormat = "hh:mm a"
        df.amSymbol = "AM"
        df.pmSymbol = "PM"
        return df
    }()
    
    static let dayDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US")
        df.dateFormat = "MMM dd"
        return df
    }()
}
