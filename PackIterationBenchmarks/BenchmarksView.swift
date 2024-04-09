//
//  SwiftUIView.swift
//  PackIterationBenchmarks
//
//  Created by Sima Nerush on 2/27/24.
//

import SwiftUI
import Charts

struct BenchmarksView: View {
  let benchmarkResults: [Benchmark]
  var benchmarkName: BenchmarkName { benchmarkResults.first!.name }

  var body: some View {
    ScrollView {
      Text(benchmarkName.rawValue)
        .font(.largeTitle)
      ForEach(Metrics.allCases, id: \.rawValue) { metricName in
        BenchmarkChart(
          benchmarkResults: benchmarkResults,
          metricsName: metricName,
          benchmarkName: benchmarkName,
          yAxisLabel: {
            switch metricName {
            case .compileTime: "Compile Time (s)"
            case .runTime: "Run Time (s)"
            case .binarySize: "Binary Size (KB)"
            case .compileTimeO: "Compile Time (-O) (s)"
            case .runTimeO: "Run Time (-O) (s)"
            case .binarySizeOsize: "Binary Size (-Osize) (KB)"
            }
          }())
      }
    }
  }
}
