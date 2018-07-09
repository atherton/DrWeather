//
//  ResultsTableViewController.swift
//  DrWeather
//
//  Created by Eric Atherton on 7/8/18.
//  Copyright © 2018 Eric Atherton. All rights reserved.
//

import UIKit
//import Foundation

class ResultsTableViewController: UITableViewController {
    
    var zipCode: Int?
//    var forecasts: [(high: Int, low: Int)]
    let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"] // TODO remove when pulling in proper days
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        if let zipCode = zipCode {
            title = String(zipCode)
            getData(for: zipCode)
        }
    }
    
    private func getData(for zipCode: Int) {
        APIManager.getWeather(for: zipCode) { (result) in
            switch result {
            case .success(let weatherData):
//                self.forecasts = weatherData
                self.parse(weatherData: weatherData)
            case .failure(let error):
                fatalError(error.localizedDescription) // TODO present API failed alert instead
            }
        }
    }

    private func parse(weatherData: WeatherData) {
        let dateFormatterIn = DateFormatter()
        dateFormatterIn.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterOut = DateFormatter()
        dateFormatterOut.dateFormat = "MM-dd-yyyy"


        var date = Date(timeIntervalSince1970: 0)
        for item in weatherData.list {
            if let itemDate = dateFormatterIn.date(from: item.date) {
                if Calendar.current.compare(date, to: itemDate, toGranularity: .day) != .orderedSame {
                    date = itemDate
                    
                } else {

                }
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "resultsCell",
                                                       for: indexPath) as? ResultsTableViewCell else {
                                                        return UITableViewCell()
        }
        cell.highTempLabel.text?.append("85 ")
        cell.lowTempLabel.text?.append("70 ")
        cell.textLabel?.text = days[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
