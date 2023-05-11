//
//  MovieCell.swift
//  MovieList
//
//  Created by Poka TM on 11/5/23.
//

import SwiftUI

struct MovieCell: View {
    
    //MARK: - Data
    
    @State var movie: Movie

    //MARK: - View
    
    var body: some View {
        VStack{
            HStack{
                AsyncImage(url: URL(string: RequestClient.Endpoints.imagePath+movie.posterPath)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 200)
                } placeholder: {
                    Image("PosterPlaceholder")
                }
                .frame(width: 150, height: 200)
                
                Spacer()
                VStack{
                    Text(movie.title)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.black)
                    Text(movie.overview)
                        .font(.body)
                        .foregroundColor(.black)
                    Spacer()
                }//VStack
                Spacer()

            }//HStack
        }//VStack
        
    }
}

struct MovieCell_Previews: PreviewProvider {
    static var previews: some View {
        MovieCell(movie: Movie())
    }
}
