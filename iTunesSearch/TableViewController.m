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

@interface TableViewController () {
    NSArray *midias;
}

@end

@implementation TableViewController
@synthesize termo, botao;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
    iTunesManager *itunes = [iTunesManager sharedInstance];
    
    
#warning Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
    self.tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableview.bounds.size.width, 50.f)];
    termo = [[UITextField alloc] initWithFrame:CGRectMake(10.0f, 25.0f, 180.0f, 25.0f)];
    [termo setBorderStyle:UITextBorderStyleRoundedRect];
    
    
    
    
    botao = [[UIButton alloc] initWithFrame:CGRectMake(220.0f, 25.0f, 60.0f, 25.0f)];
    [botao setTitle:@"Procurar" forState:UIControlStateNormal];
    [botao setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [botao setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [botao addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableview.tableHeaderView addSubview:termo];
    [self.tableview.tableHeaderView addSubview:botao];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [midias count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
    Filme *filme = [midias objectAtIndex:indexPath.row];
    
    [celula.nome setText:filme.nome];
    [celula.tipo setText:@"Filme"];
    [celula.genero setText:filme.genero];
    
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
