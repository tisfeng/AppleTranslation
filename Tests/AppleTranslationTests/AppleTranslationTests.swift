import Testing
import Translation

@testable import AppleTranslation

@MainActor
@available(macOS 15.0, *)
@Test func appleOfflineTranslation() async throws {
    // English -> Chinese
    let translationService = TranslationService(
        configuration: .init(
            source: .init(languageCode: .english),
            target: .init(languageCode: .chinese)
        )
    )

    #expect(try await translationService.translate(text: "Hello, world!").targetText == "你好，世界！")
    #expect(try await translationService.translate(text: "good").targetText == "利益")

    // Chinese -> English
    translationService.configuration = .init(
        source: .init(languageCode: .chinese),
        target: .init(languageCode: .english)
    )

    #expect(try await translationService.translate(text: "你好").targetText == "Hello")
    #expect(try await translationService.translate(text: "利益").targetText == "Interest")
}

@MainActor
@available(macOS 15.0, *)
@Test func translateSameLanguage() async throws {
    // English -> English
    let translationService = TranslationService()
    translationService.enableTranslateSameLanguage = true
    let response = try await translationService.translate(
        text: "good",
        sourceLanguage: .init(languageCode: .english),
        targetLanguage: .init(languageCode: .english)
    )
    #expect(response.targetText == "good")
}

/// Need to download the french language pack, hard to test without UI.
@MainActor
@available(macOS 15.0, *)
@Test func showDownloadLangaugePackUI() async throws {
    let translationService = TranslationService()
    let response = try await translationService.translate(
        text: "Vite",
        sourceLanguage: .init(languageCode: .french),
        targetLanguage: .init(languageCode: .english)
    )
    #expect(response.targetText == "Quickly")
}
