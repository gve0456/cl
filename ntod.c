x#include <stdio.h>

int main() {
    int n, m, start, nf, nt;
    int nfa[20][20][20] = {0};
    int dfa[500][20] = {0};
    int dt[500][20] = {0};
    int final[20] = {0};
    char alpha[20];
    int count = 1;

    // 1. Input alphabets
    printf("Enter number of alphabets: ");
    scanf("%d", &m);

    printf("Enter alphabets: ");
    for (int i = 0; i < m; i++)
        scanf(" %c", &alpha[i]);

    // 2. Input states
    printf("Enter number of states: ");
    scanf("%d", &n);

    printf("Enter initial state: ");
    scanf("%d", &start);

    // 3. Input final states
    printf("Enter number of final states: ");
    scanf("%d", &nf);

    printf("Enter final states: ");
    for (int i = 0; i < nf; i++) {
        int f;
        scanf("%d", &f);
        final[f] = 1;
    }

    // 4. Input transitions
    printf("Enter number of transitions: ");
    scanf("%d", &nt);

    printf("Enter transitions (from symbol to):\n");

    for (int i = 0; i < nt; i++) {
        int a, b;
        char ch;
        scanf("%d %c %d", &a, &ch, &b);

        for (int j = 0; j < m; j++) {
            if (alpha[j] == ch)
                nfa[a][j][b] = 1;
        }
    }

    // 5. NFA to DFA conversion
    dfa[0][start] = 1;

    for (int i = 0; i < count; i++) {
        for (int j = 0; j < m; j++) {

            int temp[20] = {0};

            // Find all destination states
            for (int k = 0; k < n; k++) {
                if (dfa[i][k]) {
                    for (int p = 0; p < n; p++) {
                        if (nfa[k][j][p])
                            temp[p] = 1;
                    }
                }
            }

            // Check whether the set already exists
            int found = -1;

            for (int x = 0; x < count; x++) {
                int same = 1;

                for (int k = 0; k < n; k++) {
                    if (dfa[x][k] != temp[k])
                        same = 0;
                }

                if (same) {
                    found = x;
                    break;
                }
            }

            // Create a new DFA state if needed
            if (found == -1) {
                found = count;

                for (int k = 0; k < n; k++)
                    dfa[count][k] = temp[k];

                count++;
            }

            dt[i][j] = found;
        }
    }

    // 6. Print DFA transition table
    printf("\nDFA TRANSITION TABLE\n");
    printf("State\t");

    for (int j = 0; j < m; j++)
        printf("%c\t", alpha[j]);

    printf("\n");

    for (int i = 0; i < count; i++) {
        printf("{");

        for (int k = 0; k < n; k++)
            if (dfa[i][k])
                printf("q%d ", k);

        printf("}\t")
        ;

        for (int j = 0; j < m; j++) {
            int x = dt[i][j];

            printf("{");

            for (int k = 0; k < n; k++)
                if (dfa[x][k])
                    printf("q%d ", k);

            printf("}\t");
        }

        printf("\n");
    }

    // Print initial state
    printf("\nInitial state: {q%d}\n", start);

    // Print final states
    printf("Final states: ");

    for (int i = 0; i < count; i++) {
        int isFinal = 0;

        for (int k = 0; k < n; k++)
            if (dfa[i][k] && final[k])
                isFinal = 1;

        if (isFinal) {
            printf("{");

            for (int k = 0; k < n; k++)
                if (dfa[i][k])
                    printf("q%d ", k);

            printf("} ");
        }
    }

    printf("\n");

    return 0;
}


nfa to dfa code
