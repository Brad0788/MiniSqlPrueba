#include <stdio.h>
#include <dirent.h>
#include <vector>
#include <string.h>
#include <string>
using namespace std;

extern FILE * yyin;
//int yylval;
int yyparse();
//int yylex();

bool checkIfSQL(char * file){
    int tam = strlen(file);
    if (file[tam-1] == 'l' && file[tam-2] == 'q' && file[tam-3] == 's' && file[tam-4] == '.')
    {
        return true;
    }
    return false;
    
}

int main(int argc, char*argv[]){

    /*if (argc != 2)
    {
        fprintf(stderr, "Missing input file %s \n", argv[0]);
        return 1;
    }*/
    
    DIR *d;
    struct dirent *dir;
    d = opendir(argv[1]);
    char files[256][256]; 
    int size = 0;
    if (d)
    {
        int j=0;
        int cantSQLS = 0;
        while ((dir = readdir(d)) != NULL)
        {
            //printf("%s\n", dir->d_name);
            if (checkIfSQL(dir->d_name))
            {
                //printf("Si es %s\n", dir->d_name);
                //strcpy(files[j], dir->d_name);
                printf("Revisando archivo: %s\n", dir->d_name);
                string fullnam(argv[1]);
                fullnam.append(dir->d_name);
                FILE * f = fopen(fullnam.c_str(), "r");
                if (f == NULL)
                {
                    fprintf(stderr, "Couldn't open file %s \n", dir->d_name);
                    return 1;
                }

                yyin = f;

                yyparse();
                cantSQLS++;
            }
            j++;
            
        }
        size = cantSQLS;
        closedir(d);
    }

    
    //for (size_t i = 0; i < size; i++)
    //{
        /*printf("Revisando archivo: %s\n", files[0]);
        FILE * f = fopen(files[0], "r");
        if (f == NULL)
        {
            fprintf(stderr, "Couldn't open file %s \n", argv[1]);
            return 1;
        }

        yyin = f;

        yyparse();*/
    //}
    
    

    /*FILE * f = fopen(argv[1], "r");
    if (f == NULL)
    {
        fprintf(stderr, "Couldn't open file %s \n", argv[1]);
        return 1;
    }
    
    yyin = f;

    yyparse();*/
    /*int token;
    while (token = yylex())
    {
        printf("Token type: %d\n",token);
    }*/
    

    return 0;
}