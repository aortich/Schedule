//
//  EventCell.swift
//  TakeHome
//
//  Created by Alberto Enrique Ortiz Chavolla on 23/08/21.
//  Copyright © 2021 Alberto Enrique Ortiz Chavolla. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
    
    @IBOutlet weak var bgEvent: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelTimelapse: UILabel!
    var viewModel: ViewModel? {
        didSet {
            applyViewModel()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func applyViewModel() {
        self.labelTitle.text = self.viewModel?.title
        self.labelTimelapse.text =
        "\(self.viewModel?.hourInterval ?? "") \(self.viewModel?.eventConflict ?? false ? "*CONFLICTS*" : "")"
        self.bgEvent.backgroundColor = self.viewModel?.eventConflict ?? false ?
            UIColor(named: "conflictBg") : UIColor(named: "eventBg")
        
    }
}
