//
//  GestureRecognitionFunc.swift
//  CameraTest
//
//  Created by Cyrus Wu on 2023/8/11.
//

import Foundation

class GestureRecognitionService {
    
    // Encode Base64 characters for a URL-encoded form body
    func base64ToBase64url(base64: String) -> String {
        let base64url = base64
            .replacingOccurrences(of: "+", with: "%2B")
            .replacingOccurrences(of: "/", with: "%2F")
            .replacingOccurrences(of: "=", with: "%3D")
        return base64url
    }
    
    func recognizeGestureJson(base64Image: String, accessToken: String, completion: @escaping (RecognitionResult?) -> Void) {
        let url = URL(string: "https://aip.baidubce.com/rest/2.0/image-classify/v1/gesture?access_token=\(accessToken)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // URL-encode the Base64 image
        let encodedBase64 = base64ToBase64url(base64: base64Image)
        let bodyData = "image=\(encodedBase64)"
            // Print the request body for debugging
        print(bodyData)

        
        
        request.httpBody = bodyData.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil, let data = data else {
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(RecognitionResult.self, from: data)
                completion(result)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
            
//            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                completion(json)
//            } else {
//                completion(nil)
//            }
        }
        
        task.resume()

    }
}
