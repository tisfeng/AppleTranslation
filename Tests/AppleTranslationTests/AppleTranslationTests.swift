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
@Test func autoDetectSourceLanguage() async throws {
    // Auto detect source language, and target language is based on the system language.
    let translationService = TranslationService()
    let response = try await translationService.translate(text: "good")
    print(response.targetText)
    #expect(response.targetText == "利益")
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

@MainActor
@available(macOS 15.0, *)
@Test func translateChinese() async throws {
    // English -> English
    let translationService = TranslationService()
    var response = try await translationService.translate(
        text: "開門",
        sourceLanguage: .init(identifier: "zh"),
        targetLanguage: .init(identifier: "en")
    )
    #expect(response.targetText == "Open the door")

    response = try await translationService.translate(
        text: "開門",
        sourceLanguage: .init(identifier: "zh-Hans"),
        targetLanguage: .init(identifier: "en")
    )
    #expect(response.targetText == "Open the door")

    response = try await translationService.translate(
        text: "開門",
        sourceLanguage: .init(identifier: "zh-Hant"),
        targetLanguage: .init(identifier: "en")
    )
    #expect(response.targetText == "Open the door")

    do {
        response = try await translationService.translate(
            text: "開門",
            sourceLanguage: .init(identifier: "zh-Hant"),
            targetLanguage: .init(identifier: "zh-Hans")
        )
    } catch {
        let err = error as! TranslationError
        if case err = TranslationError.unsupportedLanguagePairing {
            #expect(true)
        } else {
            #expect(Bool(false))
        }
    }
}

/// Need to download the french language pack, hard to test without UI.
@MainActor
@available(macOS 15.0, *)
@Test func showDownloadLangaugeUI() async throws {
    let translationService = TranslationService()
    _ = try? await translationService.translate(
        text: "Vite",
        sourceLanguage: .init(languageCode: .french),
        targetLanguage: .init(languageCode: .english)
    )
}
