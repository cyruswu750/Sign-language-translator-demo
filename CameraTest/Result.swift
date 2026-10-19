//
//  Result.swift
//  CameraTest
//
//  Created by Cyrus Wu on 2023/8/15.
//

import Foundation


struct RecognitionResult: Codable {
    var log_id: Int64
    var result_num: Int
    var result: [DetectedObject]
}

struct DetectedObject: Codable,Hashable {
    var probability: Float?
    var top: Int?
    var height: Int?
    var classname: String?
    var width: Int?
    var left: Int?
}

class DataManager: ObservableObject {
    static let shared = DataManager()

    @Published var recognitionResult = RecognitionResult(log_id: 0, result_num: 0, result: [])

    private init() {}
}
