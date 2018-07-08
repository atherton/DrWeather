//
//  APIManager.swift
//  DrWeather
//
//  Created by Eric Atherton on 7/8/18.
//  Copyright © 2018 Eric Atherton. All rights reserved.
//

import UIKit

struct WeatherData: Codable {
    let cod: String
    let message: Double
    let cnt: Int
    let list: String
    let city: String
}

class APIManager: NSObject {
    enum Result<Value> {
        case success(Value)
        case failure(Error)
    }
    
    static func getWeather(for zipCode: Int, completion: ((Result<[WeatherData]>) -> Void)?) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "samples.openweathermap.org" // TODO this is just a sample. Use api.openweathermap.org
        urlComponents.path = "/data/2.5/forecast"
        
        let zipCodeItem = URLQueryItem(name: "zip", value: "\(zipCode)")
//        let unitsItem = URLQueryItem(name: "units", value: "imperial") // uncomment when you're ready to try for real
        let appIdItem = URLQueryItem(name: "appid", value: "b6907d289e10d714a6e88b30761fae22") // sample
//        let appIdItem = URLQueryItem(name: "appid", value: "6496d58df09a21f5e9510fd85ca2bfb9") // real
        
        urlComponents.queryItems = [zipCodeItem, appIdItem] // [zipCodeItem, unitsItem, appIdItem]
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
                    // Now we have jsonData, Data representation of the JSON returned to us
                    // from our URLRequest...
                    
                    // Create an instance of JSONDecoder to decode the JSON data to our
                    // Codable struct
                    let decoder = JSONDecoder()
                    
                    do {
                        // We would use WeatherData.self for JSON representing a single WeatherData
                        // object, and [WeatherData].self for JSON representing an array of
                        // WeatherData objects
                        let forecasts = try decoder.decode([WeatherData].self, from: jsonData)
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
