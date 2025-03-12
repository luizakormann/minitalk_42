# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: luiza <luiza@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/13 21:14:14 by lukorman          #+#    #+#              #
#    Updated: 2025/03/12 20:28:43 by luiza            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# **************************************************************************** #
#                               configuration                                  #
# **************************************************************************** #

# common comp
CC	= cc
CFLAGS	= -Wall -Wextra -Werror -I$(LIB_DIR)/libft/include
RM	= rm -rf

# link libft
LIBFT = $(LIB_DIR)/bin/libft.a
FINDLIBFT = -L$(LIB_DIR)/bin
LINKLIB = -lft

# **************************************************************************** #
#                                directories                                   #
# **************************************************************************** #

# common
INC_DIR	= include/
LIB_DIR = libft/libft/
OBJ_DIR	= obj/

# mandatory
SRC_DIR_SERVER	= src/server/
SRC_DIR_CLIENT	= src/client/
OBJ_DIR_SERVER	= obj/server/
OBJ_DIR_CLIENT	= obj/client/
BIN_DIR	= bin/mandatory/

# bonus
SRC_DIR_BONUS	= src/bonus/
BIN_DIR_BONUS	= bin/bonus/
OBJ_DIR_BONUS	= obj/bonus/

# **************************************************************************** #
#                                   files                                      #
# **************************************************************************** #

# headers
HEADERS = $(shell find $(INC_DIR) -name '*.h')

# executables mandatory
NAME_SERVER	= $(BIN_DIR)server
NAME_CLIENT	= $(BIN_DIR)client

# executables bonus
NAME_S_BONUS	= $(BIN_DIR_BONUS)b_server
NAME_C_BONUS	= $(BIN_DIR_BONUS)b_client

# sources
SRC_SERVER	= $(addprefix $(SRC_DIR_SERVER), server.c)
SRC_CLIENT	= $(addprefix $(SRC_DIR_CLIENT), client.c)
SRC_B_SERVER	= $(addprefix $(SRC_DIR_BONUS)/, server_bonus.c)
SRC_B_CLIENT	= $(addprefix $(SRC_DIR_BONUS), client_bonus.c)

# objects
OBJS_SERVER = $(addprefix $(OBJ_DIR_SERVER)/, $(notdir $(SRC_SERVER:.c=.o)))
OBJS_CLIENT = $(addprefix $(OBJ_DIR_CLIENT)/, $(notdir $(SRC_CLIENT:.c=.o)))
OBJS_B_CLIENT	= $(addprefix $(OBJ_DIR_BONUS)/, $(notdir $(SRC_B_CLIENT:.c=.o)))
OBJS_B_SERVER	= $(addprefix $(OBJ_DIR_BONUS)/, $(notdir $(SRC_B_SERVER:.c=.o)))

# **************************************************************************** #
#                              compile commands                                #
# **************************************************************************** #

COMP_OBJS	= $(CC) $(CFLAGS) -c $< -o $@
COMP_SERVER	= $(CC) $(CFLAGS) $(FINDLIBFT) $(OBJS_SERVER) $(LINKLIB) \
	-o $(NAME_SERVER)
COMP_CLIENT	= $(CC) $(CFLAGS) $(FINDLIBFT) $(OBJS_CLIENT) $(LINKLIB) \
	-o $(NAME_CLIENT)

# **************************************************************************** #
#                                 verifications                                #
# **************************************************************************** #

# bonus
ifdef BONUS_TIME
	NAME_SERVER	= $(NAME_S_BONUS)
	NAME_CLIENT	= $(NAME_C_BONUS)
	SRC_SERVER	= $(SRC_B_SERVER)
	SRC_CLIENT	= $(SRC_B_CLIENT)
	OBJS_SERVER	= $(OBJS_B_SERVER)
	OBJS_CLIENT	= $(OBJS_B_CLIENT)
endif

# **************************************************************************** #
#                                  defines                                     #
# **************************************************************************** #

define time_for_bonus
	$(MAKE) $(MAKEFLAGS) BONUS_TIME=TRUE
endef

# **************************************************************************** #
#                                  targets                                     #
# **************************************************************************** #

all: git_submodule $(LIBFT) $(NAME_SERVER) $(NAME_CLIENT)

$(OBJ_DIR_SERVER)%.o: $(SRC_DIR_SERVER)%.c $(HEADERS)
	mkdir -p $(OBJ_DIR_SERVER)
	$(COMP_OBJS)

$(OBJ_DIR_CLIENT)%.o: $(SRC_DIR_CLIENT)%.c $(HEADERS)
	mkdir -p $(OBJ_DIR_CLIENT)
	$(COMP_OBJS)

$(NAME_SERVER): $(LIBFT) $(OBJS_SERVER)
	mkdir -p $(BIN_DIR)
	$(COMP_SERVER)

$(NAME_CLIENT): $(LIBFT) $(OBJS_CLIENT)
	mkdir -p $(BIN_DIR)
	$(COMP_CLIENT)

$(LIBFT):
	$(MAKE) -C $(LIB_DIR) all

git_submodule:
	git submodule update --init --recursive

bonus:
	$(call time_for_bonus)

clean:
	$(RM) $(OBJ_DIR)

fclean: clean
	$(RM) $(BIN_DIR)
	$(MAKE) -C $(LIB_DIR) fclean

re: fclean all

.PHONY: all clean fclean re bonus
