# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lukorman <lukorman@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/10/16 17:11:20 by lukorman          #+#    #+#              #
#    Updated: 2025/02/05 19:45:23 by lukorman         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# **************************************************************************** #
#                               configuration                                  #
# **************************************************************************** #

CC	= cc
CFLAGS	= -Wall -Wextra -Werror
RM	= rm -rf
NAME	= $(BIN_DIR)libft.a

# **************************************************************************** #
#                                    paths                                     #
# **************************************************************************** #

OBJ_DIR	= obj/
SRC_DIR = src/
BIN_DIR = bin/
INC_DIR = include/

# **************************************************************************** #
#                                   files                                      #
# **************************************************************************** #

SRC_FILES	= $(addprefix $(SRC_DIR), ft_isalpha.c ft_isdigit.c ft_isalnum.c ft_isascii.c ft_isprint.c\
ft_strlen.c ft_memset.c ft_bzero.c ft_memcpy.c ft_memmove.c ft_strlcpy.c\
ft_strlcat.c ft_toupper.c ft_tolower.c ft_strchr.c ft_strrchr.c ft_strncmp.c\
ft_memchr.c ft_memcmp.c ft_strnstr.c ft_atoi.c ft_calloc.c ft_strdup.c\
ft_substr.c ft_strjoin.c ft_strtrim.c ft_split.c ft_itoa.c ft_strmapi.c\
ft_striteri.c ft_putchar_fd.c ft_putstr_fd.c ft_putendl_fd.c ft_putnbr_fd.c)
SRC_BONUS	= $(addprefix $(SRC_DIR), ft_lstnew_bonus.c ft_lstadd_front_bonus.c ft_lstsize_bonus.c\
ft_lstlast_bonus.c ft_lstadd_back_bonus.c ft_lstdelone_bonus.c\
ft_lstclear_bonus.c ft_lstiter_bonus.c ft_lstmap_bonus.c)
OBJS_FILES	= $(notdir $(SRC_FILES:.c=.o))
OBJS_BONUS	= $(notdir $(SRC_BONUS:.c=.o))
ALL_OBJS	= $(OBJS_FILES) $(OBJS_BONUS)

# **************************************************************************** #
#                              compile commands                                #
# **************************************************************************** #

AR	:= ar -rcs
COMPILE_LIB_FILES	= $(AR) $(NAME) $(addprefix $(OBJ_DIR), $(OBJS_FILES))
COMPILE_LIB_BONUS	= $(AR) $(NAME) $(addprefix $(OBJ_DIR), $(ALL_OBJS))
CREATE_LIB	= $(AR) $(NAME) $(addprefix $(OBJ_DIR), $(OBJS_FILES))

# **************************************************************************** #
#                                 check relink                                 #
# **************************************************************************** #

ifeq ($(findstring bonus,$(MAKECMDGOALS)),bonus)
	OBJS += $(OBJS_BONUS)
endif

# **************************************************************************** #
#                                  targets                                     #
# **************************************************************************** #

all: $(NAME)

%.o: $(SRC_DIR)%.c
	mkdir -p $(OBJ_DIR)
	$(CREATE_LIB)

$(NAME): $(OBJS_FILES)
	mkdir -p $(BIN_DIR)
	$(COMPILE_LIB_FILES)

bonus: $(ALL_OBJS)
	$(COMPILE_LIB_BONUS)

clean:
	$(RM) $(OBJ_DIR)

fclean: clean
	$(RM) $(BIN_DIR)

re: fclean all

.PHONY: all clean fclean re
