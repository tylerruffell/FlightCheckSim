# Directories
SRC := src
BUILD := build

# Target executable
TARGET := $(BUILD)/jet_sim

# Default target
all: $(TARGET)

# Build the main program
$(TARGET): $(SRC)/main.adb
	@mkdir -p $(BUILD)
	gnatmake -o $(TARGET) $(SRC)/main.adb -Isrc -D$(BUILD)

# Clean up build artifacts
clean:
	rm -rf $(BUILD)

# Run the program
run: $(TARGET)
	./$(TARGET)
