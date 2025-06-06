# 📡 minitalk

Minitalk is a project from **42 São Paulo**  
A small message-based communication system using Unix signals.

## 📖 Overview
The **minitalk** project consists of two programs: a **server** and a **client**.
The **client** sends messages to the **server** using Unix signals (`SIGUSR1` and `SIGUSR2`). Each character from the message is **transmitted bit by bit** through signals, simulating low-level inter-process communication.


## 🏗️ Project Structure
``` bash
├── 📂 bin/          # Will be created with the executable - see how 2 use below
├── 📂 include/      # Header files (.h)
├── 📂 libft/      # gitsubmodule
│   ├── minitalk.h
├── 📂 obj/          # Object files (.o) created during comp. process
├── 📂 src/          # Source files (.c)
│   ├── client/
│   │   ├── client.c
│   ├── server/
│   │   ├── server.c
└── Makefile
```


## ⚙️ Compilation and Usage
### Requirements
 - GCC or another compatible C compiler.
 - UNIX/Linux system recommended (tested in the 42 São Paulo environment).
### 🔨 Compile the project:
Use the `Makefile` to compile and manage the project:
```
make          # you can also use make bonus once both are iddentical. see more @ key learnings section below (1)
```
This will generate the execs in the `bin/` directory:
 - `bin/server`
 - `bin/client`

### Makefile rules:
| Command | Description |
|---------|-----------|
|`make` or `make all`|Recursively updates and compiles the `libft` library and the project executables.|
|`make bonus`|Will trigger `time_for_bonus` macro, compiling with the BONUS_TIME=TRUE flag.|          `#see more @ key learnings section below (2)` 
|`make clean`|Removes object files (`.o`).|
|`make fclean`|Removes obj files and the compiled lib (`libft.a`) and execs.|
|`make re`|Recompiles everything from scratch.|

### How to Use
 1. **Start the server**
  ```
./bin/server
```
The server will display its PID, you must copy it.
> note that the server **must be initialized first** so that you can activete and use one or multiple clients
 2. **Send a message from the client**
```
./bin/client <servers_pid> "message"
```
> if you want to use multiple clients, just open multiple terminal windows 


## 🎓 Key Learnings (author's notes)
This project provided valuable insights into:

 - **UNIX signals** (1) note @ this topic: I learned how to handle signals using functions like `signal()` and `sigaction()`, Signals are **asynchronous and volatile** (they don't guarantee order or delivery), so it’s crucial to control the communication flow (the server confirming it’s “ready to receive the next bit”) to avoid losing/overwriting data - hence, bonus is mandatory ;)
 - **Bitwise Operations in C**: I explored how to use bitwise operators (`<<`, `>>`, `&`, `|`) to efficiently manage individual bits inside a byte. It is a learning process! This improved my sense of how computers "think" and store data at the most granular level.
 - **Binary Logic and Number Systems**: Coming from a humanities background, I’ve been intentionally diving into logic/mathematical related topics. I'm gaining a deeper understanding of numerical systems and positional notation and how values are formed based on the power of a system’s base (base-2 for binary, base-10 for decimal, etc.). It’s been a fascinating journey connecting abstract math to practical computing logic.
 - **Automating Builds with Makefile and Shell Commands** (2) note @ this topic: Throughout this project, I significantly improved my understanding of Makefile logic and automation workflows, particularly involving conditional builds and recursive calls. I created a `time_for_bonus` macro that internally calls `make` again, but now passing a special variable `BONUS_TIME=TRUE`. This triggers a **conditional block** (`ifdef BONUS_TIME`) which reassigns key variables — effectively switching the project to compile the bonus version of the code.

## 👩‍💻 Author
This project was developed by Luiza Kormann (lukorman@student.42.fr) as part of the 42 São Paulo curriculum.
