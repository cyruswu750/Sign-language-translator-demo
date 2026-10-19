//
//  ContentView.swift
//  CameraTest
//
//  Created by Cyrus Wu on 2023/8/10.
//

import SwiftUI

struct ContentView: View {
    //    let gestureService = GestureRecognitionService()
    @State var recognitionResult: RecognitionResult? = nil
    @ObservedObject var dataManager = DataManager.shared
    var body: some View {
        VStack {
            Text("手势识别")
            Divider()
                .padding(.bottom, 18.637)
            
            ZStack(alignment: .center) {
                CameraView()
                    .frame(width: 370.0, height: 370.0)
                    .background(Color.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                
                ForEach(dataManager.recognitionResult.result, id: \.self) { detectedObject in
                    Rectangle()
                        .stroke(Color.red, lineWidth: 2)
                        .frame(
                            width: CGFloat(detectedObject.width ?? 0),
                            height: CGFloat(detectedObject.height ?? 0)
                        )
                        .position(
                            x: CGFloat(detectedObject.left ?? 0) + CGFloat(detectedObject.width ?? 0) / 2,
                            y: CGFloat(detectedObject.top ?? 0) + CGFloat(detectedObject.height ?? 0) / 2
                        )
                        .alignmentGuide(.center) { d in
                            d[.vertical]
                        }
                }
            }
            .aspectRatio(contentMode: .fit)
            RecognitionView()
            
            
            
            
            
            Spacer()
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
