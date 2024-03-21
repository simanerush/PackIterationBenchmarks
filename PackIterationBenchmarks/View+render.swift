//
//  View+render.swift
//  PackIterationBenchmarks
//
//  Created by Sima Nerush on 3/12/24.
//

import SwiftUI

extension View {
  @discardableResult
  @MainActor
  func render(_ benchmarkName: BenchmarkName, _ metricsName: Metrics) -> URL {
    let renderer = ImageRenderer(content: self)

    let url = URL.documentsDirectory.appending(path: "\(benchmarkName.rawValue)_\(metricsName.rawValue).pdf")

    renderer.render { size, context in
      var box = CGRect(x: 0, y: 0, width: size.width, height: size.height)

      guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else {
        return
      }

      pdf.beginPDFPage(nil)
      context(pdf)
      pdf.endPDFPage()
      pdf.closePDF()
    }

    print("Saved to \(url.path())")
    return url
  }
}
