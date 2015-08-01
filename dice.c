#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <time.h>
#define NUM_FACES 6


typedef int32_t Face;
typedef struct Die{
    Face faces[NUM_FACES];
} Die;


Face* new_die(){
    return malloc(sizeof(Die));
}

void free_die(Die* d){
    free(d);
}

uint32_t randN(const int32_t N){
    static bool seeded = false;
    if(!seeded){
        srand((unsigned int)time(NULL));
        rand();
        seeded = true;
    }

    const uint32_t x = (RAND_MAX + 1u) / N;
	const uint32_t y = x * N;
	uint32_t r;
	do {
		r = rand();
	} while(r >= y);
	return r / x;
}

int32_t randrange(int32_t lower, int32_t upper){
    return lower + randN(upper - lower);
}

int32_t minimum(int32_t a, int32_t b){
    return a <= b ? a : b;
}

static Face choose(const Die* d){
    return d->faces[randN(NUM_FACES)];
}

int8_t simulate_game(const Die* d1, const Die* d2, int32_t max_score){
    int32_t sx = 0, sy = 0;
    Face x, y;
    do{
        x = choose(d1);
        y = choose(d2);

        if(x > y){
            sx += x - y;
            if(sx > max_score){
                return 1;
            }
        }
        else if(y > x){
            sy += y - x;
            if(sy > max_score){
                return 2;
            }
        }
    } while(true);
}

void get_die(Die* d, Face lower, Face upper, Face total){
    int32_t r = total;
    for(size_t i=0; i < NUM_FACES - 1; i++){
        r -= d->faces[i] = randrange(lower, minimum(upper, r));
    }
    d->faces[NUM_FACES - 1] = r;
}
