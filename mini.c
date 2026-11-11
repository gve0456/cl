
#include <stdio.h>

int main() {
    int n, m, nf, nt;
    int dt[50][20] = {0};     // DFA transition table: dt[state][symbol_index] = next_state
    int final[50] = {0};      // 1 if final, 0 otherwise
    char alpha[20];
    int p[50], old[50];
    int changed;

    // 1. Input alphabets
    printf("Enter number of alphabets: ");
    scanf("%d", &m);

    printf("Enter alphabets: ");
    for (int i = 0; i < m; i++)
        scanf(" %c", &alpha[i]);

    // 2. Input DFA states
    printf("Enter number of DFA states: ");
    scanf("%d", &n);

    // 3. Input final states
    printf("Enter number of final states: ");
    scanf("%d", &nf);

    printf("Enter final states (0-indexed integer IDs): ");
    for (int i = 0; i < nf; i++) {
        int f;
        scanf("%d", &f);
        final[f] = 1;
    }

    // 4. Input DFA transitions
    printf("Enter number of transitions: ");
    scanf("%d", &nt);

    printf("Enter transitions (from_state symbol to_state):\n");
    for (int i = 0; i < nt; i++) {
        int a, b;
        char ch;
        scanf("%d %c %d", &a, &ch, &b);

        for (int j = 0; j < m; j++) {
            if (alpha[j] == ch)
                dt[a][j] = b;
        }
    }

    // 5. Initial partition P0 (0: Non-final, 1: Final)
    for (int i = 0; i < n; i++) {
        p[i] = final[i] ? 1 : 0;
    }

    // 6. Refine partitions until no changes occur
    do {
        for (int i = 0; i < n; i++)
            old[i] = p[i];

        int next = 0;

        for (int i = 0; i < n; i++) {
            int found = 0;

            for (int j = 0; j < i; j++) {
                // States i and j must be in the same group initially
                if (old[i] != old[j])
                    continue;

                // Check if both states transition into equivalent groups for all symbols
                int equivalent = 1;
                for (int symbol = 0; symbol < m; symbol++) {
                    int next_i = dt[i][symbol];
                    int next_j = dt[j][symbol];

                    if (old[next_i] != old[next_j]) {
                        equivalent = 0;
                        break;
                    }
                }

                if (equivalent) {
                    p[i] = p[j];
                    found = 1;
                    break;
                }
            }

            if (!found)
                p[i] = next++;
        }

        // Check if partition mapping changed
        changed = 0;
        for (int i = 0; i < n; i++) {
            if (p[i] != old[i]) {
                changed = 1;
                break;
            }
        }

    } while (changed);

    // 7. Find group representatives
    int rep[50];
    for (int i = 0; i < n; i++) rep[i] = -1;

    for (int i = 0; i < n; i++) {
        if (rep[p[i]] == -1) {
            rep[p[i]] = i;
        }
    }

    // 8. Print equivalent states
    printf("\nEQUIVALENT STATES\n");
    int has_eq = 0;
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (p[i] == p[j]) {
                printf("q%d = q%d\n", i, j);
                has_eq = 1;
            }
        }
    }
    if (!has_eq) printf("None (DFA is already minimal)\n");

    // 9. Print Minimized DFA Transition Table
    printf("\nMINIMIZED DFA TRANSITION TABLE\n");
    printf("State\t");
    for (int j = 0; j < m; j++)
        printf("%c\t", alpha[j]);
    printf("\n");

    for (int i = 0; i < n; i++) {
        // Only print the representative state for each partition group
        if (rep[p[i]] == i) {
            printf("q%d\t", i);

            for (int j = 0; j < m; j++) {
                int target = dt[i][j];
                int rep_target = rep[p[target]];
                printf("q%d\t", rep_target);
            }
            printf("\n");
        }
    }

    return 0;
}

