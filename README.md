# Signer — iOS Gesture Recognition Prototype

An iOS prototype built with SwiftUI and AVFoundation that recognizes individual hand gestures using Baidu's cloud API and displays labels, confidence scores, and detection overlays.

## How It Works

1. Capture front-camera video and sample the latest frame once per second.
2. Encode the frame as JPEG/Base64 and send it to Baidu's gesture-recognition API using an access token.
3. Decode the JSON response and display the results in SwiftUI.

## Getting Started

Requires a Mac with Xcode 15+, a physical iPhone running iOS 16+, and Baidu credentials with gesture-recognition access.

1. Clone this repository and open `CameraTest.xcodeproj`.
2. Select your development team under **Signing & Capabilities**.
3. In `CameraTest/TokenManager.swift`, configure your own `client_id` (API Key) and `client_secret` (Secret Key) locally. Never commit real credentials.
4. Set a non-empty **Privacy - Camera Usage Description** (`NSCameraUsageDescription`) in the target settings.
5. Build and run on your iPhone, then allow camera access. If `Result.swift` reports missing `ObservableObject` or `Published` definitions, add `import Combine`. If `#Preview` causes a deployment-target error, replace it with a compatible `PreviewProvider`.

## Possible Next Steps

- Improve detection-box alignment across preview sizes and orientations.
- Add token refresh, error handling, and capture-session cleanup.
- Explore on-device hand-pose detection and a gesture classifier.
