//
//  ContentView.swift
//  PackIterationBenchmarks
//
//  Created by Sima Nerush on 2/27/24.
//

import SwiftUI

struct ContentView: View {
  let benchmarks = Benchmarks().allBenchmarks()
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(benchmarks, id: \.self) { b in
          if case .before = b.state {
            NavigationLink {
              BenchmarksView(benchmarkResults: benchmarks.filter { $0.name == b.name })
            } label: {
              Text(b.name.rawValue)
                .font(.title2)
                .bold()
                .padding()
            }
          }
        }
      }
      .navigationTitle("Benchmarks")
    }
    
  }
}

#Preview {
  ContentView()
}
