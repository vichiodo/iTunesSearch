//
//  ViewController.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "iTunesManager.h"
#import "Entidades/Filme.h"
#import "Entidades/Musica.h"
#import "Entidades/Podcast.h"
#import "Entidades/Ebook.h"

@interface TableViewController () {
    NSArray *midias;
    NSArray *tipos;
}

@end

@implementation TableViewController
@synthesize termo, botao, tipo;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    iTunesManager *itunes = [iTunesManager sharedInstance];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
#warning Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
    self.tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableview.bounds.size.width, 50.0f)];
    
    
    termo = [[UITextField alloc] initWithFrame:CGRectMake(10.0f, 25.0f, 180.0f, 25.0f)];
    [termo setBorderStyle:UITextBorderStyleRoundedRect];
    
    
//    tipo = [[UITableView alloc] initWithFrame:CGRectMake(10.0f, 70.0f, 150.0f, 25.0f)];
//    [tipo setBackgroundColor:[UIColor brownColor]];
//    tipos = @[@"movie", @"music"];
    
    
    botao = [[UIButton alloc] initWithFrame:CGRectMake(220.0f, 25.0f, 60.0f, 25.0f)];
    [botao setTitle:@"Procurar" forState:UIControlStateNormal];
    [botao setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [botao setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [botao addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableview.tableHeaderView addSubview:termo];
    [self.tableview.tableHeaderView addSubview:botao];
//    [self.tableview.tableHeaderView addSubview:tipo];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [midias count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[midias objectAtIndex:section]count];
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"Filmes";
        case 1:
            return @"Musicas";
        case 2:
            return @"Podcasts";
        case 3:
            return @"eBooks";
    }
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    Filme *filme = [midias objectAtIndex:indexPath.row];
    Musica *musica = [midias objectAtIndex:indexPath.row];
    Podcast *podcast = [midias objectAtIndex:indexPath.row];
    Ebook *ebook = [midias objectAtIndex:indexPath.row];

    
    switch (indexPath.section) {
        case 0:
            [celula.nome setText:filme.nome];
            [celula.tipo setText:@"Filme"];
            [celula.genero setText:filme.genero];
            break;
        case 1:
            [celula.nome setText:musica.nome];
            [celula.tipo setText:@"Musica"];
            [celula.genero setText:musica.genero];
            break;
        case 2:
            [celula.nome setText:podcast.nome];
            [celula.tipo setText:@"Podcast"];
            [celula.genero setText:podcast.genero];
        case 3:
            [celula.nome setText:ebook.nome];
            [celula.tipo setText:@"eBook"];
            [celula.genero setText:ebook.genero];
    }
    
    return celula;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}


-(IBAction)search:(id)sender{
    iTunesManager *itunes = [iTunesManager sharedInstance];
    _texto = termo.text;
    
    
    _texto = [_texto stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    midias = [itunes buscarMidias:_texto];
    
    [self.tableview reloadData];
    
    [termo resignFirstResponder];
    
    

}


@end
