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
#import "DetalhesViewController.h"

@interface TableViewController () {
    NSArray *midias;
    NSArray *tipos;
    NSUserDefaults * ultimoTermo;
}

@end

@implementation TableViewController
@synthesize termo, procurar;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
    
    ultimoTermo = [NSUserDefaults standardUserDefaults];
    
    if(ultimoTermo != 0){
        iTunesManager *itunes = [iTunesManager sharedInstance];
        NSString *novoTermo = [[ultimoTermo stringForKey:@"keyToLookupString"] stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        midias = [itunes buscarMidias:novoTermo];
    }
//    else{
//        iTunesManager *itunes = [iTunesManager sharedInstance];
//        midias = [itunes buscarMidias:@"queen"];
//    }
    
//    iTunesManager *itunes = [iTunesManager sharedInstance];
//    midias = [itunes buscarMidias:@"bee"];
    
//#warning Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
//    self.tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableview.bounds.size.width, 100.0f)];
//    
//    
//    [self.tableview.tableHeaderView addSubview:termo];
//
//    
//    termo = [[UITextField alloc] initWithFrame:CGRectMake(10.0f, 25.0f, 180.0f, 25.0f)];
//    [termo setBorderStyle:UITextBorderStyleRoundedRect];
//    
    
//    tipo = [[UITableView alloc] initWithFrame:CGRectMake(10.0f, 70.0f, 150.0f, 25.0f)];
//    [tipo setBackgroundColor:[UIColor brownColor]];
//    tipos = @[@"movie", @"music"];
    
//    
//    botao = [[UIButton alloc] initWithFrame:CGRectMake(220.0f, 25.0f, 60.0f, 25.0f)];
//    [botao setTitle:@"Procurar" forState:UIControlStateNormal];
//    [botao setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [botao setFont:[UIFont boldSystemFontOfSize:12.0f]];
//    [botao addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.tableview.tableHeaderView addSubview:termo];
//    [self.tableview.tableHeaderView addSubview:botao];
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
    return @"tchau";
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
    tipos =[[NSArray alloc] initWithArray:[midias objectAtIndex:indexPath.section]];
    
    Filme *filme;
    Musica *musica;
    Podcast *podcast;
    Ebook *ebook;
    
    long row = [indexPath row];
    
    switch (indexPath.section) {
        case 0:
            filme =[tipos objectAtIndex:row];
            [celula.nome setText:filme.nome];
            [celula.genero setText:filme.genero];
            [celula.artista setText: filme.artista];
            [celula.foto setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:filme.foto]]]];
            [celula.preco setText:filme.preco];
            break;
        case 1:
            musica = [tipos objectAtIndex:row];
            [celula.nome setText:musica.nome];
            [celula.genero setText:musica.genero];
            [celula.artista setText:musica.artista];
            [celula.foto setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:musica.foto]]]];
            [celula.preco setText:musica.preco];
            break;
        case 2:
            podcast = [ tipos objectAtIndex:row];
            [celula.nome setText:podcast.nome];
            [celula.genero setText:podcast.genero];
            [celula.artista setText:podcast.artista];
            [celula.foto setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:podcast.foto]]]];
            [celula.preco setText:podcast.preco];
            break;
        case 3:
            ebook = [tipos objectAtIndex:row];
            [celula.nome setText:ebook.nome];
            [celula.genero setText:ebook.genero];
            [celula.artista setText:ebook.autor];
            [celula.foto setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:ebook.foto]]]];
            [celula.preco setText:ebook.preco];
            break;
        default:
            break;
    }
    
    return celula;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


-(IBAction)search:(id)sender{
    iTunesManager *itunes = [iTunesManager sharedInstance];
    _texto = termo.text;
    _texto = [_texto stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    
    
    midias = [itunes buscarMidias:_texto];
    
    [self.tableview reloadData];
    
    [termo resignFirstResponder];
    
    [ultimoTermo setObject:termo.text forKey:@"keyToLookupString"];

}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    DetalhesViewController *view = [[DetalhesViewController alloc]init];
//    
//    view.row = [indexPath row];
//    view.section = [indexPath section];
//    
//    [self.navigationController pushViewController:view animated:YES];
//}


@end
