#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>

int main(void)
{
	char frase_in[100], frase_out[100];
	pid_t pid_filho;
	int fd[2];	// Descritores do pipe
	pipe(fd); // Cria o pipe
	pid_filho = fork();
	if(pid_filho==0)
	{
		strcpy(frase_out, "Pai, qual é a verdadeira essência da sabedoria?");
		write(fd[1], frase_out, 100);
		sleep(1);
		read(fd[0], frase_in, 100);
		printf("PAI: %s\n", frase_in);
		strcpy(frase_out, "Mas até uma criança de três anos sabe disso!");
		write(fd[1], frase_out, 100);
		sleep(1);
		read(fd[0], frase_in, 100);
		printf("PAI: %s\n", frase_in);
	}
	else
	{
		read(fd[0], frase_in, 100);
		printf("FILHO: %s\n", frase_in);
		strcpy(frase_out, "Não façais nada violento, praticai somente aquilo que é justo e equilibrado.");
		write(fd[1], frase_out, 100);
		sleep(1);
		read(fd[0], frase_in, 100);
		printf("FILHO: %s\n", frase_in);
		strcpy(frase_out, "Sim, mas é uma coisa difícil de ser praticada até mesmo por um velho como eu...");
		write(fd[1], frase_out, 100);
		sleep(1);
	}
	return 0;
}