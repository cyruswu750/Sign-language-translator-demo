////
////  Api.swift
////  CameraTest
////
////  Created by Rakan on 2023/8/11.
////
//
//import Foundation
//func fetchAccessToken(completion: @escaping (String?, Error?) -> Void) {
//    let url = URL(string: "https://aip.baidubce.com/oauth/2.0/token")!
//    var request = URLRequest(url: url)
//    request.httpMethod = "POST"
//    
//    let bodyData = ""grant_type=client_credentials&client_id=YOUR_API_KEY&client_secret=YOUR_SECRET_KEY""
//    request.httpBody = bodyData.data(using: .utf8)
//    
//    let task = URLSession.shared.dataTask(with: request) { data, response, error in
//        guard error == nil else {
//            completion(nil, error)
//            return
//        }
//        
//        guard let data = data else {
//            completion(nil, NSError(domain: "No data", code: 0, userInfo: nil))
//            return
//        }
//        
//        do {
//            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
//               let accessToken = json["access_token"] as? String {
//                completion(accessToken, nil)
//            } else {
//                completion(nil, NSError(domain: "Invalid JSON", code: 0, userInfo: nil))
//            }
//        } catch {
//            completion(nil, error)
//        }
//    }
//    
//    task.resume()
//}
