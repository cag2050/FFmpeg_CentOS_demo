#include <cstdlib>
#include <iostream>
#include <string>

std::string say_hello() {
    return std::string("Hello world!");
}

int main(int argc, char **argv) {
    std::cout << say_hello() << std::endl;
    return EXIT_SUCCESS;
}
