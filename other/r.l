#include <stdio.h>

#define MAX 20

int n, m, t, nf, start;
char alpha[MAX];
int trans[MAX+1][MAX][MAX+1], final[MAX+1];

unsigned int states[1 << MAX];
int visited[1 << MAX], count = 0;

int findalpha(char c)
{
    for(int i = 0; i < m; i++)
        if(alpha[i] == c) return i;
    return -1;
}

void printstate(unsigned int s)
{
    int first = 1;
    printf("{");

    for(int i = 1; i <= n; i++)
        if(s & (1u << (i-1)))
        {
            if(!first) printf(",");
            printf("q%d", i);
            first = 0;
        }

    printf("}");
}

void insert(unsigned int s)
{
    if(!visited[s])
    {
        visited[s] = 1;
        states[count++] = s;
    }
}

int main()
{
    int i, j, k, from, to;
    char c;
    unsigned int curr, next;

    printf("Number of alphabets: ");
    scanf("%d", &m);

    printf("Enter the alphabets:\n");
    for(i = 0; i < m; i++)
        scanf(" %c", &alpha[i]);

    printf("Enter the number of states: ");
    scanf("%d", &n);

    printf("Enter the start state: ");
    scanf("%d", &start);

    printf("Enter the number of final states: ");
    scanf("%d", &nf);

    printf("Enter the final states:\n");
    for(i = 0; i < nf; i++)
    {
        scanf("%d", &j);
        final[j] = 1;
    }

    printf("Enter number of transitions: ");
    scanf("%d", &t);

    printf("\nEnter transitions in the form: state alphabet state\n");

    for(i = 0; i < t; i++)
    {
        scanf("%d %c %d", &from, &c, &to);
        k = findalpha(c);

        if(k == -1 || from < 1 || from > n || to < 1 || to > n)
        {
            printf("Invalid transition!\n");
            return 1;
        }

        trans[from][k][to] = 1;
    }

    insert(1u << (start-1));

    printf("\nDFA Transitions\n");
    printf("--------------------------\n");

    for(i = 0; i < count; i++)
    {
        curr = states[i];

        for(k = 0; k < m; k++)
        {
            next = 0;

            for(j = 1; j <= n; j++)
                if(curr & (1u << (j-1)))
                    for(int p = 1; p <= n; p++)
                        if(trans[j][k][p])
                            next |= (1u << (p-1));

            insert(next);

            printstate(curr);
            printf(" --%c--> ", alpha[k]);
            printstate(next);
            printf("\n");
        }
    }

    printf("\nStates of DFA:\n");
    for(i = 0; i < count; i++)
    {
        printstate(states[i]);
        printf("\n");
    }

    printf("\nStart State:\n");
    printstate(states[0]);

    printf("\n\nFinal States:\n");
    for(i = 0; i < count; i++)
    {
        for(j = 1; j <= n; j++)
            if((states[i] & (1u << (j-1))) && final[j])
            {
                printstate(states[i]);
                printf("\n");
                break;
            }
    }

    return 0;
}
