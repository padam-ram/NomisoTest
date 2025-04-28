//
//  ContentView.swift
//  NomisoTest
//
//  Created by sai sitaram on 28/04/25.
//

import SwiftUI

struct MoviesView: View {
    
    @StateObject private var viewModel : MoviesViewModel
    @State private var showErrorAlert = false
    
    init(viewModel: MoviesViewModel = MoviesViewModel(apiService: NetworkLayer())) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(viewModel.moviesList, id: \.self) { movieInfo in
                    NavigationLink(destination: MovieDetailView(movie: movieInfo)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Movie Name: \(movieInfo.title ?? "")")
                                    .font(.headline)
                                Text("Run Time: \(movieInfo.runtime ?? "")")
                                    .font(.subheadline)
                                Text("Release Year: \(movieInfo.year ?? "")")
                                    .font(.subheadline)
                            }
                            Spacer()
                            AsyncImage(url: URL(string: movieInfo.poster ?? "")) { displayImage in
                                displayImage.image?.resizable()
                            }
                            .frame(maxWidth: 100, maxHeight: 100)
                            .cornerRadius(12)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .blur(radius: viewModel.isLoading ? 3 : 0)
                
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                }
            }
            .navigationTitle("Movies")
        }
        .task {
            await viewModel.fetchMoviesList()
        }
        .alert("Error", isPresented: $showErrorAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.error?.localizedDescription ?? "Unknown error occurred.")
        }
        .onReceive(viewModel.$error) { error in
            showErrorAlert = error != nil
        }
        .task {
            await viewModel.fetchMoviesList()
        }
        .alert("Error", isPresented: $showErrorAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.error?.localizedDescription ?? "Unknown error occurred.")
        }
        .onReceive(viewModel.$error) { error in
            showErrorAlert = error != nil
        }
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        MoviesView()
//    }
//}
