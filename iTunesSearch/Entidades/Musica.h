//
//  Musica.h
//  iTunesSearch
//
//  Created by Vivian Chiodo Dias on 11/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Musica : NSObject

    @property (nonatomic, strong) NSString *nome;
    @property (nonatomic, strong) NSString *trackId;
    @property (nonatomic, strong) NSString *artista;
    @property (nonatomic, strong) NSString *duracao;
    @property (nonatomic, strong) NSString *genero;
    @property (nonatomic, strong) NSString *pais;
@property (nonatomic, strong) NSString *preco;

@end
