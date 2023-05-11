//
//  MovieView.swift
//  MovieList
//
//  Created by Poka TM on 11/5/23.
//

import SwiftUI

struct MovieView: View {
    
    //MARK: - Data
    @StateObject var movieVM = MovieViewModel()
    @State var isLoading: Bool = true
    @State var searchText: String = ""
    @State var movieList: [Movie] = []
    
    //MARK: - View
    
    var body: some View {
        
        let bindingText = Binding<String>(get: {
            self.searchText
        }, set: {
            self.searchText = $0
        })
        
        VStack {
            Text("Movie list")
                .font(.title)
                .bold()
                .foregroundColor(.black)
            Divider()
                .background(Color.gray)
            
            TextField("Search Movie", text: bindingText)
                .frame(height: 40)
                .accentColor(.black)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .cornerRadius(5)
                .foregroundColor(.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1.0)
                )
                .padding()
                .onSubmit {
                    self.isLoading = true
                    callApi(searchText: self.searchText)
                }
            
            Divider()
                .background(Color.gray)
            
            ScrollView {
                VStack{
                    if !self.isLoading {
                        LazyVStack{
                            ForEach(0..<movieList.count-1, id: \.self) { i in
                                MovieCell(movie: movieList[i])
                                    .padding(.bottom, 10)
                                Divider()
                                    .background(Color.gray)
                            }
                        }//LazyVStack
                    }else{
                        ProgressView()
                    }

                    Spacer()
                }//VStack
                .frame(maxWidth: .infinity)
            }//ScrollView
            .frame(maxWidth: .infinity)
        }//VStack
        .background(.white)
        .onAppear{
            callApi()
        }
    }
    
    //MARK: -  API Call
    
    private func callApi(searchText: String = "Marvel") {
        DispatchQueue.main.async {
            movieVM.getMovieList(searchText: (searchText == "") ? "Marvel" : searchText) { flag, msg in
                self.isLoading = false
                self.movieList = movieVM.movieList
            }
        }
    }//callApi
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView()
    }
}
