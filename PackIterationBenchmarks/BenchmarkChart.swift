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
              .opacity(0.6)
              .lineStyle(StrokeStyle(lineWidth: 6.0))
              .symbol(by: .value("state", benchmark.state))
              .symbolSize(120)
            }
          }
            .chartForegroundStyleScale([
              "Before": Color.red,
              "After": Color.green
            ])
            .chartXAxis {
              AxisMarks(values: .automatic(desiredCount: 10)) { val in
                AxisValueLabel()
                  .font(.system(.largeTitle, design: .serif))
                  .foregroundStyle(Color.black)
                AxisTick(length: 5.0, stroke: StrokeStyle(lineWidth: 2.0, dashPhase: 0))
                  .foregroundStyle(Color.black)
                if val.index == 10 {
                  AxisGridLine(stroke: StrokeStyle(lineWidth: 2.0, dashPhase: 0))
                    .foregroundStyle(Color.black)
                }
              }
            }
            .chartYAxis {
              AxisMarks(values: .automatic(desiredCount: 6)) { val in
                AxisValueLabel()
                  .font(.system(.largeTitle, design: .serif))
                  .foregroundStyle(Color.black)
                AxisTick(length: 5.0, stroke: StrokeStyle(lineWidth: 2.0, dashPhase: 0))
                  .foregroundStyle(Color.black)
                if val.index == .zero {
                  AxisGridLine(stroke: StrokeStyle(lineWidth: 2.0, dashPhase: 0))
                    .foregroundStyle(Color.black)
                }
              }
            }
            .chartXAxisLabel(position: .bottom, alignment: .center) {
              Text("Number of Elements (n)")
                .font(.system(size: 48, design: .serif))
                .fontWeight(.semibold)
                .foregroundStyle(Color.black)
            }
            .chartYAxisLabel(position: .trailing, alignment: .center) {
              Text(yAxisLabel)
                .font(.system(size: 48, design: .serif))
                .fontWeight(.semibold)
                .foregroundStyle(Color.black)
            }
            .chartLegend(position: .topLeading) {
              VStack(alignment: .leading) {
                HStack {
                  Circle()
                    .foregroundStyle(Color.red)
                    .frame(width: 15, height: 15)
                  Text("Before")
                    .font(.system(size: 48, design: .serif))
                    .foregroundStyle(Color.black)
                }
                HStack {
                  Rectangle()
                    .foregroundStyle(Color.green)
                    .frame(width: 15, height: 15)
                  Text("After")
                    .font(.system(size: 48, design: .serif))
                    .foregroundStyle(Color.black)
                }
              }
            }
            .padding(40)
            .frame(minHeight: 750)

              benchmarkChart

              ShareLink(item: benchmarkChart.frame(width: 1000, height: 750).render(
                benchmarkName, metricsName)) {
                  Label("Export as PDF", systemImage: "square.and.arrow.up")
                }
            }
        }
      } else {
        EmptyView()
      }
    }
  }
