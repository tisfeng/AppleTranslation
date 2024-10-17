import Testing
import Translation

@testable import AppleTranslation

@MainActor
@available(macOS 15.0, *)
@Test func appleOfflineTranslation() async throws {
    let translationService = TranslationService(
        configuration: .init(
            source: .init(languageCode: .english),
            target: .init(languageCode: .chinese)
        )
    )

    #expect(try await translationService.translate(text: "Hello, world!").targetText == "你好，世界！")
    #expect(try await translationService.translate(text: "good").targetText == "利益")

    let response = try await translationService.translate(
        text: "你好",
        sourceLanguage: .init(languageCode: .chinese),
        targetLanguage: .init(languageCode: .english)
    )
    #expect(response.targetText == "Hello")
}

/// Need to download the french language pack, hard to test without UI.
@MainActor
@available(macOS 15.0, *)
@Test func showDownloadLangaugePackUI() async throws {
    let translationService = TranslationService(
        configuration: .init(
            source: .init(languageCode: .english),
            target: .init(languageCode: .chinese)
        )
    )

    #expect(try await translationService.translate(text: "Hello, world!").targetText == "你好，世界！")
    #expect(try await translationService.translate(text: "good").targetText == "利益")

    var response = try await translationService.translate(
        text: "你好",
        sourceLanguage: .init(languageCode: .chinese),
        targetLanguage: .init(languageCode: .english)
    )
    #expect(response.targetText == "Hello")

    response = try await translationService.translate(
        text: "Vite",
        sourceLanguage: .init(languageCode: .french),
        targetLanguage: .init(languageCode: .english)
    )
    #expect(response.targetText == "Quickly")
}
