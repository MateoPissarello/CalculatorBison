# Definir variables
GCC = gcc
BISON = bison
FLEX = flex
OUTPUT = fb1-5
BISON_FILE = fb1-5.y
FLEX_FILE = fb1-5.l
BISON_C = fb1-5.tab.c
FLEX_C = lex.yy.c
LIBS = -lfl

# Regla principal (target)
all: $(OUTPUT)

# Regla para generar el archivo ejecutable
$(OUTPUT): $(BISON_C) $(FLEX_C)
	$(GCC) -o $@ $(BISON_C) $(FLEX_C) $(LIBS)

# Regla para generar el archivo de Bison
$(BISON_C): $(BISON_FILE)
	$(BISON) -d $(BISON_FILE)

# Regla para generar el archivo de Flex
$(FLEX_C): $(FLEX_FILE)
	$(FLEX) $(FLEX_FILE)

# Limpiar archivos generados
clean:
	rm -f $(OUTPUT) $(BISON_C) $(BISON_C:.c=.h) $(FLEX_C)

# Regla "phony" para evitar conflictos con archivos que se llamen "clean" o "all"
.PHONY: clean all
