//
//  Benchmark.swift
//  PackIterationBenchmarks
//
//  Created by Sima Nerush on 2/27/24.
//

import Foundation
import Charts

struct DataPoint: Hashable, Identifiable {
  let id = UUID()
  let elementCount: Int
  let observed: Double

  init(_ elementCount: Int, _ observed: Double) {
    self.elementCount = elementCount
    self.observed = observed
  }
}

public enum Metrics: String, CaseIterable {
  case compileTime = "Compile Time"
  case runTime = "Run Time"
  case binarySize = "Binary Size"
  case compileTimeO = "Compile Time (`-O`)"
  case runTimeO = "Run Time (`-O`)"
  case binarySizeOsize = "Binary Size (`-Osize`)"
}

public enum BenchmarkName: String {
  case tuple = "Tuple"
  case lookup = "Lookup"
  case result = "Result<Success, Failure>"
  case closure = "Closure"
}

struct Benchmark: Hashable {
  let name: BenchmarkName
  let state: State

  let data100: [Double]
  let data200: [Double]
  let data300: [Double]
  let data400: [Double]
  let data500: [Double]
  let data600: [Double]
  let data700: [Double]
  let data800: [Double]
  let data900: [Double]
  let data1000: [Double]

  var compileTimes: Array<DataPoint> {
    [DataPoint(100, data100[0]),
    DataPoint(200, data200[0]),
    DataPoint(300, data300[0]),
    DataPoint(400, data400[0]),
    DataPoint(500, data500[0]),
    DataPoint(600, data600[0]),
    DataPoint(700, data700[0]),
    DataPoint(800, data800[0]),
    DataPoint(900, data900[0]),
    DataPoint(1000, data1000[0])]
  }

  var runTimes: Array<DataPoint> {
    [DataPoint(100, data100[1]),
    DataPoint(200, data200[1]),
    DataPoint(300, data300[1]),
    DataPoint(400, data400[1]),
    DataPoint(500, data500[1]),
    DataPoint(600, data600[1]),
    DataPoint(700, data700[1]),
    DataPoint(800, data800[1]),
    DataPoint(900, data900[1]),
    DataPoint(1000, data1000[1])]
  }

  var binarySizes: Array<DataPoint> {
    [DataPoint(100, data100[2]),
    DataPoint(200, data200[2]),
    DataPoint(300, data300[2]),
    DataPoint(400, data400[2]),
    DataPoint(500, data500[2]),
    DataPoint(600, data600[2]),
    DataPoint(700, data700[2]),
    DataPoint(800, data800[2]),
    DataPoint(900, data900[2]),
    DataPoint(1000, data1000[2])]
  }

  var compileTimesO: Array<DataPoint> {
    [DataPoint(100, data100[3]),
    DataPoint(200, data200[3]),
    DataPoint(300, data300[3]),
    DataPoint(400, data400[3]),
    DataPoint(500, data500[3]),
    DataPoint(600, data600[3]),
    DataPoint(700, data700[3]),
    DataPoint(800, data800[3]),
    DataPoint(900, data900[3]),
    DataPoint(1000, data1000[3])]
  }

  var runTimesO: Array<DataPoint> {
    [DataPoint(100, data100[4]),
    DataPoint(200, data200[4]),
    DataPoint(300, data300[4]),
    DataPoint(400, data400[4]),
    DataPoint(500, data500[4]),
    DataPoint(600, data600[4]),
    DataPoint(700, data700[4]),
    DataPoint(800, data800[4]),
    DataPoint(900, data900[4]),
    DataPoint(1000, data1000[4])]
  }

  var binarySizesOsize: Array<DataPoint> {
    [DataPoint(100, data100[5]),
    DataPoint(200, data200[5]),
    DataPoint(300, data300[5]),
    DataPoint(400, data400[5]),
    DataPoint(500, data500[5]),
    DataPoint(600, data600[5]),
    DataPoint(700, data700[5]),
    DataPoint(800, data800[5]),
    DataPoint(900, data900[5]),
    DataPoint(1000, data1000[5])]
  }
}

enum State: String, Plottable {
  case before = "Before"
  case after = "After"
}

struct Benchmarks {
  func allBenchmarks() -> [Benchmark] {
    [ Benchmark(name: .tuple,
                state: .before,
                data100: [1.60, 0.04, 53, 3.61, 0.02,  53],
                data200: [5.30, 0.06, 53, 7.56, 0.04, 53],
                data300: [11.95, 0.09, 69, 14.58, 0.05, 53],
                data400: [25.05, 0.11, 69, 27.63, 0.07, 53],
                data500: [42.75, 0.13, 69, 46.18, 0.08,69],
                data600: [64.81, 0.15, 86, 67.98, 0.10, 69],
                data700: [93.75, 0.17, 86, 100.03, 0.10, 69],
                data800: [151.68, 0.19, 86, 155.08, 0.11, 69],
                data900: [198.81, 0.20, 86, 202.84, 0.11, 69],
                data1000: [264.88, 0.22, 102, 270.33, 0.13, 86]
               ),
      Benchmark(name: .tuple,
                state: .after,
                data100: [1.55, 0.04, 34, 3.47, 0.02, 51],
                data200: [5.22, 0.06, 34, 7.39, 0.03, 51],
                data300: [12.08, 0.08, 51, 14.43, 0.05, 51],
                data400: [25.15, 0.10, 51, 27.87, 0.07, 51],
                data500: [41.84, 0.12, 51, 45.21, 0.08, 67],
                data600: [64.62, 0.14, 51, 67.21, 0.08, 67],
                data700: [93.76, 0.16, 67, 95.99, 0.10, 67],
                data800: [144.99, 0.18, 67, 152.75, 0.11, 67],
                data900: [201.93, 0.19, 67, 207.87, 0.12, 67],
                data1000: [269.69, 0.21, 84, 271.50, 0.13, 84]
               ),
      Benchmark(name: .lookup,
                state: .before,
                data100: [0.53, 0.01, 35 , 2.30, 0.01, 34],
                data200: [1.02, 0.02, 35 , 2.88, 0.01, 34],
                data300: [1.74, 0.03, 35 , 3.69, 0.01, 34],
                data400: [2.74, 0.04, 35, 4.84, 0.02, 34],
                data500: [3.93, 0.05, 51, 6.14, 0.02, 34],
                data600: [5.31, 0.06, 51, 7.59, 0.02, 34],
                data700: [6.89, 0.06, 51, 9.34, 0.02, 34],
                data800: [8.87, 0.07, 51, 11.66, 0.03, 34],
                data900: [10.99, 0.07, 51, 13.76, 0.03, 34],
                data1000: [13.48, 0.09, 51, 16.48, 0.03, 34]
               ),
      Benchmark(name: .lookup,
                state: .after,
                data100: [0.54, 0.01, 35 , 2.28, 0.01, 34],
                data200: [1.03, 0.02, 35 , 2.87, 0.01, 34],
                data300: [1.74, 0.03, 35 , 3.67, 0.01, 34],
                data400: [2.78, 0.04, 35, 4.78, 0.02, 34],
                data500: [3.91, 0.04, 51, 6.07, 0.02, 34],
                data600: [5.28, 0.04, 51, 7.69, 0.02, 34],
                data700: [6.94, 0.05, 51, 9.26, 0.02, 34],
                data800: [8.83, 0.06, 51, 11.39, 0.03, 34],
                data900: [10.91, 0.06, 51, 10.95, 0.03, 34],
                data1000: [13.19, 0.06, 51, 15.99, 0.03, 34]
               ),
      Benchmark(name: .result,
                state: .before,
                data100: [0.92, 0.14, 54 , 3.69, 0.09, 56],
                data200: [1.65, 0.25, 71 , 4.68, 0.15, 56],
                data300: [2.62, 0.36, 71 , 5.94, 0.23, 56],
                data400: [3.85, 0.47, 87, 7.45, 0.39, 72],
                data500: [5.66, 0.57, 87, 9.61, 0.53, 72],
                data600: [7.40, 0.69, 104, 11.65, 0.60, 72],
                data700: [9.30, 0.78, 104, 13.87, 0.70, 72],
                data800: [11.44, 0.90, 120, 16.38, 0.81, 72],
                data900: [13.70, 0.99, 120, 19.12, 0.84, 72],
                data1000: [16.80, 1.14, 137, 22.13, 0.96, 72]
               ),
      Benchmark(name: .result,
                state: .after,
                data100: [0.93, 0.07, 54 , 3.68, 0.04, 55],
                data200: [1.64, 0.12, 70 , 4.59, 0.08, 55],
                data300: [2.73, 0.17, 70 , 5.74, 0.10, 55],
                data400: [4.33, 0.22, 87, 7.76, 0.24, 55],
                data500: [5.70, 0.27, 87, 9.31, 0.27, 72],
                data600: [7.44, 0.32, 103, 11.31, 0.35, 72],
                data700: [9.30, 0.37, 103, 13.49, 0.37, 72],
                data800: [11.45, 0.41, 120, 15.98, 0.45, 72],
                data900: [13.78, 0.45, 120, 18.56, 0.49, 72],
                data1000: [16.20, 0.52, 136, 21.29, 0.5, 72]
               ),
      Benchmark(name: .closure,
                state: .before,
                data100: [2.26,  2.25,  62, 0, 0, 0],
                data200: [6.44,  8.76, 84, 0, 0, 0],
                data300: [13.35,  19.79, 89, 0, 0, 0],
                data400: [23.66, 35.00, 111, 0, 0, 0],
                data500: [37.57,  54.54,  116, 0, 0, 0],
                data600: [54.43,  77.81, 138, 0, 0, 0],
                data700: [74.16,  105.03, 143, 0, 0, 0],
                data800: [103.05, 139.64, 165, 0, 0, 0],
                data900: [137.9, 178.5, 170, 0, 0, 0],
                data1000: [172.70, 221, 192, 0, 0, 0]
               ),
      Benchmark(name: .closure,
                state: .after,
                data100: [2.18,  2.26,  58, 0, 0, 0],
                data200: [6.36, 8.72,  80, 0, 0, 0],
                data300: [13.38,  19.69, 85, 0, 0, 0],
                data400: [23.62, 34.74, 107, 0, 0, 0],
                data500: [38.61, 54.35, 112, 0, 0, 0],
                data600: [55.43, 79.93, 134, 0, 0, 0],
                data700: [75.32, 106.10, 139, 0, 0, 0],
                data800: [103.67, 140.88, 160, 0, 0, 0],
                data900: [136.67, 177.3, 166, 0, 0, 0],
                data1000: [175.88, 220.61, 187, 0, 0, 0]
               )
    ]
  }
}
