//
//  ContentView.swift
//  AppleTranslationExample
//
//  Created by tisfeng on 2024/11/10.
//

import SwiftUI
import AppleTranslation

struct ContentView: View {
    var body: some View {
        VStack {
            TextField("", text: $sourceText)
                .textFieldStyle(.roundedBorder)

            Button("Translate") {
                Task {
                    try? await translate()
                }
            }

            Text(translatedText)
        }
        .padding()
        .task {
            try? await translate()
        }
    }

    @State private var sourceText: String = "Hello, world!"
    @State private var translatedText = ""

    private func translate() async throws {
        let translationService = TranslationService(
            configuration: .init(
                source: .init(languageCode: .english),
                target: .init(languageCode: .chinese)
            )
        )
        let response = try await translationService.translate(text: sourceText)
        translatedText = response.targetText
    }
}

#Preview {
    ContentView()
}
