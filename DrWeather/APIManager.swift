//
//  APIManager.swift
//  DrWeather
//
//  Created by Eric Atherton on 7/8/18.
//  Copyright © 2018 Eric Atherton. All rights reserved.
//

import UIKit

struct WeatherData: Codable {
    let cnt: Int
    let list: [ListItems]
}

struct ListItems: Codable {
    let date: String
    let main: MainItems

    enum CodingKeys: String, CodingKey {
        case date = "dt_txt"
        case main
    }
}

struct MainItems: Codable {
    let minTemp: Double
    let maxTemp: Double

    enum CodingKeys: String, CodingKey {
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
    }
}

class APIManager: NSObject {
    enum Result<Value> {
        case success(Value)
        case failure(Error)
    }
    
    static func getWeather(for zipCode: Int, completion: ((Result<WeatherData>) -> Void)?) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org" // TODO this is just a sample. Use api.openweathermap.org
        urlComponents.path = "/data/2.5/forecast"
        
        let zipCodeItem = URLQueryItem(name: "zip", value: "\(zipCode)")
        let unitsItem = URLQueryItem(name: "units", value: "imperial")
        let appIdItem = URLQueryItem(name: "appid", value: "6496d58df09a21f5e9510fd85ca2bfb9")

        urlComponents.queryItems = [zipCodeItem, unitsItem, appIdItem]
        guard let url = urlComponents.url else {
            fatalError("couldn't create url from components")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                if let error = responseError {
                    completion?(.failure(error))
                } else if let jsonData = responseData {
                    let decoder = JSONDecoder()
                    do {
                        let forecasts = try decoder.decode(WeatherData.self, from: jsonData)
                        completion?(.success(forecasts))
                    } catch {
                        completion?(.failure(error))
                    }
                } else {
                    let userInfo = [NSLocalizedDescriptionKey: "Data was not retrieved from request"]
                    let error = NSError(domain: "", code: 0, userInfo: userInfo) as Error
                    completion?(.failure(error))
                }
            }
        }
        task.resume()
    }
}
