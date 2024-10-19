//
//  AppleTranslation.swift
//  AppleTranslation
//
//  Created by tisfeng on 2024/10/19.
//

import AppleTranslation

try await test()

@MainActor
func test() async throws {
    if #available(macOS 15.0, *) {
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
    }
}
