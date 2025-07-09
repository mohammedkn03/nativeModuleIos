import Foundation
import React

@objc(WeatherModule)
class WeatherModule: NSObject {
  
  @objc static func requiresMainQueueSetup() -> Bool {
    return true
  }
  
  @objc func fetchWeatherForRiyadh(_ callback: @escaping RCTResponseSenderBlock) {
    let apiKey = "YOUR_API_KEY" // استبدلها بمفتاحك
    let urlString = "https://api.openweathermap.org/data/2.5/weather?q=Riyadh&appid=\(apiKey)&units=metric"
    
    guard let url = URL(string: urlString) else {
      callback(["Error: Invalid URL"])
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, _, error in
      if let error = error {
        callback(["Error: \(error.localizedDescription)"])
        return
      }
      
      guard let data = data,
            let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
        callback(["Error: Invalid data"])
        return
      }
      
      callback([json])
    }
    task.resume()
  }
}
