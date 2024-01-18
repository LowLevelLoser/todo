#!/bin/sh

TODO_FILE="$HOME/scriptz/todo.txt" #change this path to where you want the todo file

while getopts "a:r:d:ch" opt; do
  case $opt in
    a)
      echo "$OPTARG" >> "$TODO_FILE"
      echo "Added: $OPTARG"
      ;;
    r)
      sed -i "${OPTARG}d" "$TODO_FILE"
      echo "Removed item at line $OPTARG"
      ;;
    d)
      sed -i "${OPTARG}s/\(.*\)/\x1b[9m\1\x1b[0m/" "$TODO_FILE"
      echo "Marked item at line $OPTARG as done"
      ;;
    c)
      > "$TODO_FILE"
      echo "Cleared the todo list"
      ;;
    h)
      echo "Usage:"
      echo "  -a <task>: Add a new task (must be in quotes)"
      echo "  -r <number>: Remove task at the specified line number"
      echo "  -d <number>: Mark task at the specified line number as done"
      echo "  -c: Clear todo list"
      echo "  -h: Show this help Message"
      ;;
    \?)
      echo "Invalid option" >&2
      echo "Try 'todo -h' for more information"
      exit 1
      ;;
  esac
done

if [ $OPTIND -eq 1 ]; then
  cat -n "$TODO_FILE"
fi
