# Get a list of all .cpp files in the root directory and its subdirectories
SRCS := $(shell find . -name "*.cpp" -print0 | xargs -0)

# Set the output file name
OUTPUT := main.out

# Set the compiler and compiler flags
CC := g++
CFLAGS := -std=c++17

# Add DEBUG macro to CFLAGS
ifdef DEBUG
CFLAGS += -DDEBUG -Wall -Wextra -g
CFLAGS += -Wno-unused-variable -Wno-unused-parameter -Wno-reorder
endif

# Build rule
build: $(OUTPUT)

# Linking rule
$(OUTPUT): $(SRCS)
	$(CC) $(CFLAGS) $^ -o $@

test: $(OUTPUT)
	chmod +x test.sh
	./test.sh

# Clean rule
clean:
	rm -f $(OUTPUT)
