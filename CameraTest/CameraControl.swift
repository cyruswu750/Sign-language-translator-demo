//
//  CameraControl.swift
//  CameraTest
//
//  Created by Cyrus Wu on 2023/8/11.
//

import Foundation
import SwiftUI
import AVFoundation



struct CameraView: UIViewRepresentable {
    typealias UIViewType = PreviewView
    
    func makeUIView(context: Context) -> PreviewView {
        let view = PreviewView()
        view.startCaptureSession()
        return view
    }
    
    func updateUIView(_ uiView: PreviewView, context: Context) { }
}

class PreviewView: UIView {
    private var captureSession: AVCaptureSession?
    private var videoOutput: AVCaptureVideoDataOutput?
    
    var currentFrame: UIImage?
    
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    override var layer: AVCaptureVideoPreviewLayer {
        return super.layer as! AVCaptureVideoPreviewLayer
    }
    
    func startCaptureSession() {
        captureSession = AVCaptureSession()
        layer.session = captureSession
        layer.videoGravity = .resizeAspectFill
        
        let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
        guard let device = captureDevice else { return }
        let deviceInput = try! AVCaptureDeviceInput(device: device)
        
        if captureSession!.canAddInput(deviceInput) {
            captureSession!.addInput(deviceInput)
        }
        
        videoOutput = AVCaptureVideoDataOutput()
        videoOutput?.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession?.addOutput(videoOutput!)
        
        captureSession!.startRunning()
        //DispatchQueue.global().async {
            // 每隔1秒捕获一次帧并转换为BASE64
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                if let image = self.currentFrame {
                    let base64String = self.convertImageToBase64(image: image)
                    let gestureService = GestureRecognitionService()
                    
                    gestureService.recognizeGestureJson(base64Image: base64String, accessToken: TokenManager.shared.accessToken!) { result in
                        //DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            DataManager.shared.recognitionResult = result!
                        //}
                        
                        // 在你的网络请求完成的回调中：
                        print(DataManager.shared.recognitionResult as Any)
                        //                    if let json = jsonResponse {
                        //                        print(json)
                        //
                        //                    } else {
                        //                        print("Error occurred or no valid JSON received.")
                        //                    }
                    }
                }
            }
        //}
    }
    
    func convertImageToBase64(image: UIImage) -> String {
        let imageData = image.jpegData(compressionQuality: 0.005)!
        return imageData.base64EncodedString()
    }
}

extension PreviewView: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let ciImage = CIImage(cvPixelBuffer: imageBuffer)
        let context = CIContext()
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return }
        currentFrame = UIImage(cgImage: cgImage)
    }
}






