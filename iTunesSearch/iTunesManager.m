//
//  iTunesManager.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "iTunesManager.h"
#import "Entidades/Filme.h"
#import "Music.h"
#import "Podcast.h"
#import "Ebook.h"
#import <UIKit/UIKit.h>

@implementation iTunesManager

static iTunesManager *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];    
    });
    
    return SINGLETON;
}


- (NSArray *)buscarMidias:(NSString *)termo {
    if (!termo) {
        termo = @"";
    }
    
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=all", termo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"^[ A-Z0-9a-z._%+-]{1,100}$" options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSTextCheckingResult *match = [regular firstMatchInString:termo options:0 range:NSMakeRange(0, [termo length])];

    if (!match) {
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Erro" message:@"Nao foi possível realizar a busca, verifique os termos que voce utilizou na busca." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
        return nil;
    }
    
    
    
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&error];
    if (error) {
        NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
        return nil;
    }
    
    NSArray *resultados = [resultado objectForKey:@"results"];
    NSMutableArray *filmes = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in resultados) {
        Filme *filme = [[Filme alloc] init];
        [filme setMidia:[item objectForKey:@"kind"]];
        [filme setNome:[item objectForKey:@"trackName"]];
        [filme setTrackId:[item objectForKey:@"trackId"]];
        [filme setArtista:[item objectForKey:@"artistName"]];
        [filme setDuracao:[item objectForKey:@"trackTimeMillis"]];
        [filme setGenero:[item objectForKey:@"primaryGenreName"]];
        [filme setPais:[item objectForKey:@"country"]];
        [filmes addObject:filme];
        [filme setImagem:[item objectForKey:@"artworkUrl100"]];
        [filmes addObject:filme];
        
    }
    
    return filmes;
}


#pragma mark - Busca filmes

- (NSArray *)buscarFilme:(NSString *)termo{
    if (!termo) {
        termo = @"";
    }
    
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=movie", termo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"^[ A-Z0-9a-z._%+-]{1,100}$" options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSTextCheckingResult *match = [regular firstMatchInString:termo options:0 range:NSMakeRange(0, [termo length])];
    
    if (!match) {
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Erro" message:@"Nao foi possível realizar a busca, verifique os termos que voce utilizou na busca." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
        return nil;
    }
    
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&error];
    if (error) {
        UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Erro!" message:@"Não foi possível fazer a busca." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
        return nil;
    }
    
    NSArray *resultados = [resultado objectForKey:@"results"];
    NSMutableArray *filmes = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in resultados) {
        Filme *filme = [[Filme alloc] init];
        [filme setMidia:[item objectForKey:@"kind"]];
        [filme setNome:[item objectForKey:@"trackName"]];
        [filme setTrackId:[item objectForKey:@"trackId"]];
        [filme setArtista:[item objectForKey:@"artistName"]];
        [filme setDuracao:[item objectForKey:@"trackTimeMillis"]];
        [filme setGenero:[item objectForKey:@"primaryGenreName"]];
        [filme setPais:[item objectForKey:@"country"]];
        [filme setImagem:[item objectForKey:@"artworkUrl100"]];
        [filmes addObject:filme];
    }
    
    return filmes;
}

#pragma mark - Busca musicas

- (NSArray *)buscarMusicas:(NSString *)termo{
    if (!termo) {
        termo = @"";
    }
    
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=music", termo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"^[ A-Z0-9a-z._%+-]{1,100}$" options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSTextCheckingResult *match = [regular firstMatchInString:termo options:0 range:NSMakeRange(0, [termo length])];
    
    if (!match) {
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Erro" message:@"Nao foi possível realizar a busca, verifique os termos que voce utilizou na busca." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
        return nil;
    }
    
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&error];
    if (error) {
        UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Erro!" message:@"Não foi possível fazer a busca." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
        return nil;
    }
    
    NSArray *resultados = [resultado objectForKey:@"results"];
    NSMutableArray *musicas = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in resultados) {
        Music *song = [[Music alloc] init];
        [song setMidia:[item objectForKey:@"kind"]];
        [song setNome:[item objectForKey:@"trackName"]];
        [song setTrackId:[item objectForKey:@"trackId"]];
        [song setArtista:[item objectForKey:@"artistName"]];
        [song setGenero:[item objectForKey:@"primaryGenreName"]];
        [song setPais:[item objectForKey:@"country"]];
        [song setImagem:[item objectForKey:@"artworkUrl100"]];
        [musicas addObject:song];
    }
    
    return musicas;
}

#pragma mark - Busca podcast

- (NSArray *)buscarPodcast:(NSString *)termo{
    if (!termo) {
        termo = @"";
    }
    
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=podcast", termo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    
//    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"^[ A-Z0-9a-z._%+-]{1,100}$" options:NSRegularExpressionCaseInsensitive error:&error];
//    
//    NSTextCheckingResult *match = [regular firstMatchInString:termo options:0 range:NSMakeRange(0, [termo length])];
//    
//    if (!match) {
//        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Erro" message:@"Nao foi possível realizar a busca, verifique os termos que voce utilizou na busca." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alerta show];
//        return nil;
//    }
    
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&error];
    if (error) {
        UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Erro!" message:@"Não foi possível fazer a busca." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
        return nil;
    }
    
    NSArray *resultados = [resultado objectForKey:@"results"];
    NSMutableArray *podcasts = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in resultados) {
        Podcast *podcast = [[Podcast alloc] init];
        [podcast setMidia:[item objectForKey:@"kind"]];
        [podcast setNome:[item objectForKey:@"trackName"]];
        [podcast setTrackId:[item objectForKey:@"trackId"]];
        [podcast setArtista:[item objectForKey:@"artistName"]];
        [podcast setGenero:[item objectForKey:@"primaryGenreName"]];
        [podcast setPais:[item objectForKey:@"country"]];
        [podcast setImagem:[item objectForKey:@"artworkUrl100"]];
        [podcasts addObject:podcast];
    }
    
    return podcasts;
}

#pragma mark - Busca ebook

- (NSArray *)buscarEbook:(NSString *)termo{
    if (!termo) {
        termo = @"";
    }
    
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=ebook", termo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"^[ A-Z0-9a-z._%+-]{1,100}$" options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSTextCheckingResult *match = [regular firstMatchInString:termo options:0 range:NSMakeRange(0, [termo length])];
    
    if (!match) {
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Erro" message:@"Nao foi possível realizar a busca, verifique os termos que voce utilizou na busca." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
        return nil;
    }
    
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&error];
    if (error) {
        UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Erro!" message:@"Não foi possível fazer a busca." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
        return nil;
    }
    
    NSArray *resultados = [resultado objectForKey:@"results"];
    NSMutableArray *ebooks = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in resultados) {
        Ebook *ebook = [[Ebook alloc] init];
        [ebook setMidia:[item objectForKey:@"kind"]];
        [ebook setNome:[item objectForKey:@"trackName"]];
        [ebook setTrackId:[item objectForKey:@"trackId"]];
        [ebook setArtista:[item objectForKey:@"artistName"]];
        [ebook setGenero:[item objectForKey:@"primaryGenreName"]];
        [ebook setPais:[item objectForKey:@"country"]];
        [ebook setImagem:[item objectForKey:@"artworkUrl100"]];
        [ebooks addObject:ebook];
    }
    
    return ebooks;
}



#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[iTunesManager alloc] init];
}

- (id)mutableCopy
{
    return [[iTunesManager alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    return self;
}


@end
