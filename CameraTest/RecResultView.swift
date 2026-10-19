//
//  RecResultView.swift
//  CameraTest
//
//  Created by Cyrus Wu on 2023/8/15.
//

import SwiftUI



struct RecognitionView: View {
    @StateObject private var data = DataManager.shared
    //var recognitionResult = data.recognitionResult

    var body: some View {
        VStack {
            //Text("Log ID: \(data.recognitionResult.log_id)")
            //    .font(.headline)
            Text("Number of Results: \(data.recognitionResult.result_num)")
                .font(.subheadline)
            List(data.recognitionResult.result.indices, id: \.self) { index in
                DetectedObjectView(object: data.recognitionResult.result[index])
            }
        }
        .padding()
    }
}

struct DetectedObjectView: View {
    var object: DetectedObject

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Classname: \(object.classname ?? "Unknown")")
                .font(.headline)
            Text("Probability: \(String(format: "%.2f", object.probability ?? 0))")
        }
    }
}

struct RecognitionView_Previews: PreviewProvider {
    static var previews: some View {
//        let object = DetectedObject(probability: 0.9, top: 10, height: 100, classname: "Car", width: 200, left: 50)
//        let recognitionResult = RecognitionResult(log_id: 123456, result_num: 1, result: [object])
        RecognitionView()
    }
}


