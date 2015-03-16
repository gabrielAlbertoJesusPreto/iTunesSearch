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
#import "Music.h"
#import "Ebook.h"
#import "Podcast.h"

@interface TableViewController () {
    NSArray *musicas;
    NSArray *filmes;
    NSArray *ebooks;
    NSArray *podcasts;
    NSUserDefaults *persistencia;
}

@end

@implementation TableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    _headerSearch.frame = CGRectMake(0, 0, CGRectGetWidth(self.tableview.frame), 100);
    self.headerSearch = _headerSearch;
    
    [_buttonBusca setTitle:NSLocalizedString(@"Buscar",nil) forState:UIControlStateNormal];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
    iTunesManager *itunes = [iTunesManager sharedInstance];
    
#warning Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
    //self.tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableview.bounds.size.width, 15.f)];

    self.tableview.contentInset = UIEdgeInsetsMake(20.0, 0, 0, 0);
    
    persistencia = [NSUserDefaults standardUserDefaults];
    NSString *last = [persistencia objectForKey:@"last"];
    
    musicas = [itunes buscarMusicas:last];
    filmes = [itunes buscarFilme:last];
    podcasts = [itunes buscarPodcast:last];
    ebooks = [itunes buscarEbook:last];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(musicas == nil && filmes == nil && podcasts == nil && ebooks == nil){
        return 0;
    }
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==0){
        return [musicas count];
    }
    else if(section==1){
        return [filmes count];
    }
    else if(section==2){
        return [podcasts count];
    }
    else if(section==3){
        return [ebooks count];
    }
    
    else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
    if(indexPath.section == 0){
        Music *musica = [musicas objectAtIndex:indexPath.row];
        
        [celula.nome setText:musica.nome];
        [celula.artista setText:musica.artista];
        [celula.genero setText:musica.genero];
        [celula.pais setText:musica.pais];
        NSURL *imageURL = [NSURL URLWithString:musica.imagem];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        [celula.imagem setImage:[UIImage imageWithData:imageData]];
        
        return celula;
    }
    
    else if (indexPath.section == 1){
        if(filmes==nil){
            return nil;
        }
    
        Filme *filme = [filmes objectAtIndex:indexPath.row];
    
        [celula.nome setText:filme.nome];
        [celula.artista setText:filme.artista];
        [celula.genero setText:filme.genero];
        [celula.pais setText:filme.pais];
        NSURL *imageURL = [NSURL URLWithString:filme.imagem];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        [celula.imagem setImage:[UIImage imageWithData:imageData]];
        
        return celula;
    }
    
    else if (indexPath.section == 2){
        
        if(podcasts == nil){
            return nil;
        }
        
        Podcast *podcast = [podcasts objectAtIndex:indexPath.row];
        
        [celula.nome setText:podcast.nome];
        [celula.artista setText:podcast.artista];
        [celula.genero setText:podcast.genero];
        [celula.pais setText:podcast.pais];
        NSURL *imageURL = [NSURL URLWithString:podcast.imagem];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        [celula.imagem setImage:[UIImage imageWithData:imageData]];
        
        return celula;
    }
    
    else if (indexPath.section == 3){
        
        Ebook *ebook = [ebooks objectAtIndex:indexPath.row];
        
        [celula.nome setText:ebook.nome];
        [celula.artista setText:ebook.artista];
        [celula.genero setText:ebook.genero];
        [celula.pais setText:ebook.pais];
        NSURL *imageURL = [NSURL URLWithString:ebook.imagem];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        [celula.imagem setImage:[UIImage imageWithData:imageData]];
        
        return celula;
    }
    
    else{
        return nil;
    }
    
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section==0){
        return @"Musicas";
    }
    else if(section==1){
        return @"Filmes";
    }
    else if(section==2){
        return @"Podcasts";
    }
    else if(section==3){
        return @"Ebooks";
    }
    else{
        return @"Outros";
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerIcon = [[UIView alloc] initWithFrame:CGRectMake(10, -20, tableView.frame.size.width, 20)];
    headerIcon.backgroundColor = [UIColor redColor];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 18, 18)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(35, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:14]];
    label.textColor = [UIColor whiteColor];
    
    if(section == 0){
        [label setText:@"Musicas"];
        [image setImage:[UIImage imageNamed:@"music"]];
    }
    else if(section == 1){
        [label setText:@"Filmes"];
        [image setImage:[UIImage imageNamed:@"movie"]];
    }
    else if(section == 2){
        [label setText:@"Podcasts"];
        [image setImage:[UIImage imageNamed:@"podcast"]];
    }
    else if(section == 3){
        [label setText:@"Ebooks"];
        [image setImage:[UIImage imageNamed:@"ebook"]];
    }
    
    else{
        return nil;
    }
    
    [headerIcon addSubview:label];
    [headerIcon addSubview:image];
    
    return headerIcon;
}


- (IBAction)buscar:(id)sender {
    iTunesManager *itunes = [iTunesManager sharedInstance];
    
    filmes = [itunes buscarMidias:_textBusca.text];
    musicas = [itunes buscarMidias:_textBusca.text];
    ebooks = [itunes buscarMidias:_textBusca.text];
    podcasts = [itunes buscarMidias:_textBusca.text];
    
    [persistencia setObject:_textBusca.text forKey:@"last"];
    
    [self.textBusca endEditing:true];
    [self.tableview reloadData];
}

@end
