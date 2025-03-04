#include <stdio.h>

int main() {
    // Definimos la variable ecuacion
    int ecuacion;

    // Ciclos anidados para x, y, z
    for (int x = 1; x < 256; x++) {
        for (int y = 1; y < 256; y++) {
            for (int z = 1; z < 256; z++){
                ecuacion = 5*(x + x*y + x*y*z) + 10;

                // Condición para verificar si ecuacion es igual a 16000
                if (ecuacion == 16000000) {
                    // Imprime los valores de x, y, z cuando la condición se cumple
                    printf("x = %d, y = %d, z = %d\n", x, y, z);
                }
            }
        }
    }

    return 0;
}
