# AppleTranslation

AppleTranslation is a wrapper for the [Apple Translation API](https://developer.apple.com/documentation/Translation/translating-text-within-your-app).

## Usage

```swift
import AppleTranslation

// English -> Chinese
let translationService = TranslationService(
    configuration: .init(
        source: .init(languageCode: .english),
        target: .init(languageCode: .chinese)
    )
)
var response = try await translationService.translate(text: "Hello, world!")
print(response.targetText)

// Chinese -> English
response = try await translationService.translate(
    text: "你好",
    sourceLanguage: .init(languageCode: .chinese),
    targetLanguage: .init(languageCode: .english)
)
print(response.targetText)
```
