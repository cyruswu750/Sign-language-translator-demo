//
//  ResultOverlayView.swift
//  CameraTest
//
//  Created by Cyrus Wu on 2023/8/17.
//

import SwiftUI

struct DetectionOverlayView: View {
    @ObservedObject var dataManager = DataManager.shared
    let cameraViewSize: CGSize

    init(cameraViewSize: CGSize) {
        self.cameraViewSize = cameraViewSize
    }

    var body: some View {
        ForEach(self.dataManager.recognitionResult.result, id: \.self) { detectedObject in
            let convertedRect = self.convert(detectedObject: detectedObject, to: cameraViewSize)
            Path { path in
                path.addRect(convertedRect)
            }
            .stroke(Color.red, lineWidth: 2)
        }
    }

    private func convert(detectedObject: DetectedObject, to size: CGSize) -> CGRect {
        let x = CGFloat(detectedObject.left ?? 0) * size.width
        let y = CGFloat(detectedObject.top ?? 0) * size.height
        let width = CGFloat(detectedObject.width ?? 0) * size.width
        let height = CGFloat(detectedObject.height ?? 0) * size.height
        return CGRect(x: x, y: y, width: width, height: height)
    }
}
