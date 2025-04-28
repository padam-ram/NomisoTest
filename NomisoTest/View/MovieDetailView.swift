//
//  MovieDetailView.swift
//  NomisoTest
//
//  Created by sai sitaram on 28/04/25.
//

import SwiftUI

struct MovieDetailView: View {
    
    let movie: MoviesModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                
                HStack {
                    Spacer()
                    AsyncImage(url: URL(string: movie.poster ?? "")) { displayImage in
                        displayImage.image?
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(width: 100, height: 100)
                    .cornerRadius(12)
                    Spacer()
                }
                
                Text(movie.title ?? "Unknown Title")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Divider()
                
                DetailRow(label: "Run Time", value: "\(movie.runtime ?? "")")
                DetailRow(label: "Year", value: movie.year ?? "N/A")
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.2))
                    .shadow(radius: 3)
            )
            .padding(.horizontal)
        }
        
    }
}

struct DetailRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text("\(label):")
                .font(.headline)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.body)
                .foregroundColor(.primary)
        }
    }
}

//struct MovieDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailView(movie: MoviesModel(title: "Indhra", runtime: "186", year: "2002",poster: "https://picsum.photos/200/300"))
//    }
//}
