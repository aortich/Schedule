//
//  ViewController.swift
//  TakeHome
//
//  Created by Alberto Enrique Ortiz Chavolla on 23/08/21.
//  Copyright © 2021 Alberto Enrique Ortiz Chavolla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var viewModel: ViewModel?
    var calendar: Calendar?
    private let eventReuseIdentifier = "EventCell"
    private let headerReuseIdentifier = "DateHeader"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = ViewModel(loadError: loadingError(_:), didComplete: loadingComplete(_:))
        self.viewModel?.loadCalendar()
        setupTableView()
    }
    
    func setupTableView() {
        self.tableView.register(UINib(nibName: eventReuseIdentifier, bundle: nil), forCellReuseIdentifier: eventReuseIdentifier)
        self.tableView.register(UINib(nibName: headerReuseIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: headerReuseIdentifier)
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 200
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func loadingError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: "Error loading events", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
    }
    
    func loadingComplete(_ calendar: Calendar) {
        self.calendar = calendar
        self.tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let days = self.calendar?.sortedDays else {
            return 0
        }
        
        return days.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 80
        }
        
        return 55
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let day = self.calendar?.sortedDays?[section],
            let events = self.calendar?.groupedEvents?[day] else {
                return 0
        }
        
        return events.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(with: self.headerReuseIdentifier, as: DateHeader.self)
        if let day = self.calendar?.sortedDays?[section] {
            header.labelTitle.text = day
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, with: self.eventReuseIdentifier, as: EventCell.self)
        if let day = self.calendar?.sortedDays?[indexPath.section],
            let events = self.calendar?.groupedEvents?[day] {
            let event = events[indexPath.row]
            cell.viewModel = EventCell.ViewModel(event: event,
                                                 eventConflict: self.calendar?.doesEventConflict(event: event) ?? false)
        }
        return cell
    }
}

