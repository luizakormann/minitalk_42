/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   server.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: luiza <luiza@student.42.fr>                +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/01/13 23:47:35 by lukorman          #+#    #+#             */
/*   Updated: 2025/03/12 21:54:59 by luiza            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../include/minitalk.h"

t_byte_assembler	g_msg = {0, 0};

void	process_signal(int signal, siginfo_t *siginfo, void *context)
{
	(void)context;
	if (signal == SIGUSR1)
		g_msg.c &= ~(1 << g_msg.i);
	else if (signal == SIGUSR2)
		g_msg.c |= (1 << g_msg.i);
	g_msg.i++;
	if (g_msg.i == 8)
	{
		if (g_msg.c == '\0')
			write(1, "\n", 1);
		else
			write(1, &g_msg.c, 1);
		g_msg.c = 0;
		g_msg.i = 0;
	}
	if (kill(siginfo->si_pid, SIGUSR1))
		exit(EXIT_FAILURE);
}

int	main(void)
{
	struct sigaction	sign_server;
	int					pid;

	sigemptyset(&sign_server.sa_mask);
	sign_server.sa_sigaction = process_signal;
	sign_server.sa_flags = SA_SIGINFO;
	pid = getpid();
	ft_printf("*** THE SERVER HAS BEEN STARTED ***\n\n");
	ft_printf("Now copy it's PID number into the client so we can talk :)\n");
	ft_printf("This server's PID is: %d\n", pid);
	ft_printf("\n", 1);
	sigaction(SIGUSR1, &sign_server, NULL);
	sigaction(SIGUSR2, &sign_server, NULL);
	ft_printf("Waiting for message...\n");
	while (TRUE)
		pause();
	return (0);
}
