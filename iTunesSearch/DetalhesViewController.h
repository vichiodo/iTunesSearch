//
//  DetalhesViewController.h
//  iTunesSearch
//
//  Created by Vivian Chiodo Dias on 15/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetalhesViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imagem;
@property (weak, nonatomic) IBOutlet UILabel *titulo;
@property (weak, nonatomic) IBOutlet UILabel *artista;
@property (weak, nonatomic) IBOutlet UILabel *ano;
@property (weak, nonatomic) IBOutlet UILabel *preco;

@property NSInteger *row;
@property NSInteger *section;

@end
