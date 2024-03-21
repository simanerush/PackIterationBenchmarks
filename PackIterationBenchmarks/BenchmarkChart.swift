//
//  BenchmarkChart.swift
//  PackIterationBenchmarks
//
//  Created by Sima Nerush on 3/18/24.
//

import SwiftUI
import Charts

struct BenchmarkChart: View {

  let benchmarkResults: [Benchmark]
  let metricsName: Metrics
  let benchmarkName: BenchmarkName
  let yAxisLabel: String

  var shouldDisplayChart: Bool {
    switch benchmarkName {
    case .closure:
      switch metricsName {
      case .compileTimeO, .runTimeO, .binarySizeOsize:
        false
      default:
        true
      }
    default:
      true
    }
  }

  var body: some View {
    if shouldDisplayChart {
      GroupBox(metricsName.rawValue) {
       VStack {
         let benchmarkChart = Chart(benchmarkResults, id: \.state) { benchmark in
           // Get corresponding data points depending on the metrics displayed.
           var dataPoints: Array<DataPoint> {
             switch metricsName {
             case .compileTime:
               benchmark.compileTimes
             case .runTime:
               benchmark.runTimes
             case .binarySize:
               benchmark.binarySizes
             case .compileTimeO:
               benchmark.compileTimesO
             case .runTimeO:
               benchmark.runTimesO
             case .binarySizeOsize:
               benchmark.binarySizesOsize
             }
           }
           ForEach(dataPoints) { data in
             LineMark(x: .value("Number of Elements", data.elementCount),
                      y: .value(metricsName.rawValue, data.observed))
             .foregroundStyle(by: .value("State", benchmark.state))
             .symbol(by: .value("state", benchmark.state))
           }
         }
           .chartXAxisLabel("Number of Elements")
           .chartYAxisLabel(yAxisLabel)
           .chartForegroundStyleScale()
           .padding(40)
           .frame(minHeight: 750)

         benchmarkChart

         ShareLink(item: benchmarkChart.frame(width: 1000, height: 750).render()) {
           Label("Export as PDF", systemImage: "square.and.arrow.up")
         }
       }
     }
    } else {
      EmptyView()
    }
  }
}
