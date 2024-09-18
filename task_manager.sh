#!/bin/bash

TASK_FILE="tasks.txt"

# Function to display usage
function usage() {
    echo "Usage: $0 {add|list|complete|delete} [task_number] [task_description]"
    exit 1
}

# Ensure the tasks file exists
touch "$TASK_FILE"

# Function to add a task
function add_task() {
    local task_description="$*"
    echo "$task_description" >> "$TASK_FILE"
    echo "Task added: $task_description"
}

# Function to list all tasks
function list_tasks() {
    if [[ -s "$TASK_FILE" ]]; then
        cat -n "$TASK_FILE"
    else
        echo "No tasks found."
    fi
}

# Function to mark a task as complete
function complete_task() {
    local task_number="$1"
    if [[ -n "$task_number" && "$task_number" =~ ^[0-9]+$ ]]; then
        sed -i "${task_number}d" "$TASK_FILE"
        echo "Task $task_number marked as complete."
    else
        echo "Invalid task number."
    fi
}

# Function to delete a task
function delete_task() {
    local task_number="$1"
    if [[ -n "$task_number" && "$task_number" =~ ^[0-9]+$ ]]; then
        sed -i "${task_number}d" "$TASK_FILE"
        echo "Task $task_number deleted."
    else
        echo "Invalid task number."
    fi
}

# Main script logic
case "$1" in
    add)
        shift
        add_task "$@"
        ;;
    list)
        list_tasks
        ;;
    complete)
        complete_task "$2"
        ;;
    delete)
        delete_task "$2"
        ;;
    *)
        usage
        ;;
esac
