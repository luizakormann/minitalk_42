/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   minitalk.h                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: luiza <luiza@student.42.fr>                +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/01/13 23:44:30 by lukorman          #+#    #+#             */
/*   Updated: 2025/03/11 19:15:23 by luiza            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef MINITALK_H
#define MINITALK_H

# define _POSIX_C_SOURCE 199309L
# include <unistd.h>
# include <signal.h>
# include <stdlib.h>
# include "../libft/libft/include/libft.h"
# include "../libft/libft/include/ft_printf.h"
# include "../libft/libft/include/get_next_line.h"

# define TRUE 1
# define FALSE 0

typedef struct s_byte_assembler
{
	unsigned char	c;
	int				i;
}t_byte_assembler;

#endif
