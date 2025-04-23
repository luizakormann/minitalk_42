/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client_bonus.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lukorman <lukorman@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/01/13 23:47:44 by lukorman          #+#    #+#             */
/*   Updated: 2025/04/23 17:33:48 by lukorman         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../../include/minitalk.h"

int	g_bit_received = FALSE;

int	validate_pid(int pid)
{
	if (pid <= 0)
	{
		ft_printf("Error: Invalid PID (non-positive)\n");
		return (FALSE);
	}
	if (kill(pid, 0) == -1)
	{
		ft_printf("Cannot send signal. Check if server is running.\n");
		return (FALSE);
	}
	return (TRUE);
}

void	handler(int sign)
{
	if (sign == SIGUSR1)
		g_bit_received = TRUE;
}

void	transmit_message(int pid, char *str, size_t len_str)
{
	size_t		i_str;
	int			bit_from_caracter;

	i_str = 0;
	while (i_str <= len_str)
	{
		bit_from_caracter = 0;
		while (bit_from_caracter < 8)
		{
			if ((str[i_str] >> bit_from_caracter) & 1)
				kill(pid, SIGUSR2);
			else
				kill(pid, SIGUSR1);
			bit_from_caracter++;
			sleep(100);
			while (!g_bit_received)
				pause();
			g_bit_received = FALSE;
		}
		i_str++;
	}
}

int	main(int argc, char **argv)
{
	int					pid_server;
	struct sigaction	sign_client;

	if (argc == 3)
	{
		pid_server = ft_atoi(argv[1]);
		if (!validate_pid(pid_server))
			return (1);
		ft_printf("Sending message...\n");
		sign_client.sa_handler = handler;
		sign_client.sa_flags = 0;
		sigemptyset(&sign_client.sa_mask);
		sigaction(SIGUSR1, &sign_client, NULL);
		transmit_message(pid_server, argv[2], ft_strlen(argv[2]));
		ft_printf("Message sent successfully!\n");
	}
	else
	{
		ft_printf("Something is missing!\n");
		ft_printf("The correct init: ./client, <server's PID>, <message>\n");
	}
	return (0);
}
