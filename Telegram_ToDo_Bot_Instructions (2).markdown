# Creating a To-Do List Bot on Telegram: Step-by-Step Instructions

This guide provides detailed instructions for creating a Telegram bot that allows users to manage a to-do list. The bot will support adding tasks, listing tasks, marking tasks as complete, and deleting tasks, using Python and the `python-telegram-bot` library. Follow these steps to set up and deploy your bot.

## Prerequisites
- A Telegram account.
- Basic knowledge of Python programming.
- Python 3.7+ installed on your computer.
- A text editor (e.g., VS Code, PyCharm, or Notepad).
- A free Heroku account (or another hosting platform) for deployment.
- Telegram app installed on your device.

## Step 1: Set Up Your Telegram Bot
1. **Open Telegram and Find BotFather**:
   - Search for `@BotFather` in Telegram.
   - Start a chat and send `/start`.

2. **Create a New Bot**:
   - Send `/newbot` to BotFather.
   - Follow the prompts to name your bot (e.g., `@MyToDoBot`) and set a username ending in "Bot".
   - BotFather will provide an **API token**. Save this token securely; you’ll need it for coding.

3. **Set Bot Commands**:
   - Send `/setcommands` to BotFather.
   - Choose your bot and provide the following commands:
     ```
     start - Start the to-do list bot
     add - Add a new task
     list - List all tasks
     done - Mark a task as complete
     delete - Delete a task
     help - Show help message
     ```

## Step 2: Set Up Your Development Environment
1. **Install Python**:
   - Ensure Python 3.7+ is installed. Check by running:
     ```bash
     python --version
     ```
   - If not installed, download from [python.org](https://www.python.org).

2. **Install Required Libraries**:
   - Open a terminal and install the `python-telegram-bot` library:
     ```bash
     pip install python-telegram-bot
     ```

3. **Create a Project Folder**:
   - Create a folder (e.g., `ToDoBot`) and navigate to it:
     ```bash
     mkdir ToDoBot
     cd ToDoBot
     ```

## Step 3: Write the Bot Code
1. **Create a Python Script**:
   - Create a file named `todo_bot.py` in your project folder.
   - Copy and paste the following code, replacing `YOUR_BOT_TOKEN` with the API token from BotFather:

```python
from telegram import Update
from telegram.ext import (
    Application,
    CommandHandler,
    ContextTypes,
    ConversationHandler,
    MessageHandler,
    filters,
)

# States for conversation handler
ADD_TASK, DELETE_TASK, MARK_DONE = range(3)

# Dictionary to store tasks per user
tasks = {}

async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text(
        "Welcome to your To-Do List Bot! Use /add to add a task, /list to see tasks, /done to mark a task as complete, /delete to remove a task, or /help for instructions."
    )

async def help_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text(
        "Commands:\n/add - Add a new task\n/list - List all tasks\n/done - Mark a task as complete\n/delete - Delete a task\n/help - Show this message"
    )

async def add(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text("Please enter the task to add:")
    return ADD_TASK

async def add_task(update: Update, context: ContextTypes.DEFAULT_TYPE):
    user_id = update.message.from_user.id
    task = update.message.text
    if user_id not in tasks:
        tasks[user_id] = []
    tasks[user_id].append({"task": task, "done": False})
    await update.message.reply_text(f"Task added: {task}")
    return ConversationHandler.END

async def list_tasks(update: Update, context: ContextTypes.DEFAULT_TYPE):
    user_id = update.message.from_user.id
    if user_id not in tasks or not tasks[user_id]:
        await update.message.reply_text("No tasks found.")
        return
    task_list = "\n".join(
        f"{i+1}. {t['task']} {'✔' if t['done'] else ''}" for i, t in enumerate(tasks[user_id])
    )
    await update.message.reply_text(f"Your tasks:\n{task_list}")

async def done(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text("Enter the task number to mark as done:")
    return MARK_DONE

async def mark_done(update: Update, context: ContextTypes.DEFAULT_TYPE):
    user_id = update.message.from_user.id
    try:
        task_num = int(update.message.text) - 1
        if user_id in tasks and 0 <= task_num < len(tasks[user_id]):
            tasks[user_id][task_num]["done"] = True
            await update.message.reply_text(f"Task {task_num + 1} marked as done!")
        else:
            await update.message.reply_text("Invalid task number.")
    except ValueError:
        await update.message.reply_text("Please enter a valid number.")
    return ConversationHandler.END

async def delete(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text("Enter the task number to delete:")
    return DELETE_TASK

async def delete_task(update: Update, context: ContextTypes.DEFAULT_TYPE):
    user_id = update.message.from_user.id
    try:
        task_num = int(update.message.text) - 1
        if user_id in tasks and 0 <= task_num < len(tasks[user_id]):
            task = tasks[user_id].pop(task_num)
            await update.message.reply_text(f"Task deleted: {task['task']}")
        else:
            await update.message.reply_text("Invalid task number.")
    except ValueError:
        await update.message.reply_text("Please enter a valid number.")
    return ConversationHandler.END

def main():
    # Replace 'YOUR_BOT_TOKEN' with your actual bot token
    application = Application.builder().token("YOUR_BOT_TOKEN").build()

    # Conversation handler for adding tasks
    add_conv = ConversationHandler(
        entry_points=[CommandHandler("add", add)],
        states={ADD_TASK: [MessageHandler(filters.TEXT & ~filters.COMMAND, add_task)]},
        fallbacks=[],
    )

    # Conversation handler for marking tasks as done
    done_conv = ConversationHandler(
        entry_points=[CommandHandler("done", done)],
        states={MARK_DONE: [MessageHandler(filters.TEXT & ~filters.COMMAND, mark_done)]},
        fallbacks=[],
    )

    # Conversation handler for deleting tasks
    delete_conv = ConversationHandler(
        entry_points=[CommandHandler("delete", delete)],
        states={DELETE_TASK: [MessageHandler(filters.TEXT & ~filters.COMMAND, delete_task)]},
        fallbacks=[],
    )

    # Add handlers
    application.add_handler(CommandHandler("start", start))
    application.add_handler(CommandHandler("help", help_command))
    application.add_handler(CommandHandler("list", list_tasks))
    application.add_handler(add_conv)
    application.add_handler(done_conv)
    application.add_handler(delete_conv)

    # Start the bot
    application.run_polling()

if __name__ == "__main__":
    main()
```

2. **Test the Bot Locally**:
   - Run the script:
     ```bash
     python todo_bot.py
     ```
   - Open Telegram, start a chat with your bot (e.g., `@MyToDoBot`), and test commands like `/start`, `/add`, `/list`, `/done`, and `/delete`.

## Step 4: Deploy the Bot
1. **Set Up Heroku**:
   - Sign up at [heroku.com](https://www.heroku.com).
   - Install the Heroku CLI:
     ```bash
     heroku login
     ```

2. **Prepare for Deployment**:
   - Create a `requirements.txt` file in your project folder:
     ```bash
     echo "python-telegram-bot==13.7" > requirements.txt
     ```
   - Create a `Procfile` (no file extension):
     ```bash
     echo "worker: python todo_bot.py" > Procfile
     ```

3. **Deploy to Heroku**:
   - Initialize a Git repository:
     ```bash
     git init
     git add .
     git commit -m "Initial commit"
     ```
   - Create a Heroku app:
     ```bash
     heroku create my-todo-bot
     ```
   - Push to Heroku:
     ```bash
     git push heroku main
     ```
   - Set the bot token as an environment variable:
     ```bash
     heroku config:set TELEGRAM_BOT_TOKEN="YOUR_BOT_TOKEN"
     ```
   - Update the code in `todo_bot.py` to use the environment variable:
     ```python
     import os
     application = Application.builder().token(os.getenv("TELEGRAM_BOT_TOKEN")).build()
     ```

4. **Scale the Worker**:
   - Ensure the bot runs:
     ```bash
     heroku ps:scale worker=1
     ```

## Step 5: Test Your Bot on Telegram
- Open Telegram and interact with your bot using the commands:
  - `/start`: Displays a welcome message.
  - `/add`: Prompts you to enter a task, then adds it.
  - `/list`: Shows all tasks with numbers and completion status.
  - `/done`: Prompts for a task number to mark as complete.
  - `/delete`: Prompts for a task number to delete.
  - `/help`: Shows available commands.

## Step 6: Enhance Your Bot (Optional)
- **Add Persistence**: Use a database (e.g., SQLite or Heroku Postgres) to store tasks permanently.
- **Add Reminders**: Implement scheduled messages for task deadlines.
- **Improve UI**: Add inline keyboards for task selection.
- **Error Handling**: Add more robust error messages for invalid inputs.

## Troubleshooting
- **Bot Not Responding**: Check Heroku logs (`heroku logs --tail`) for errors. Ensure the token is correct and the worker is running.
- **Command Issues**: Verify commands are set correctly in BotFather.
- **Deployment Errors**: Ensure `requirements.txt` and `Procfile` are correct.

## Notes
- Keep your bot token secure and never share it publicly.
- Test each command thoroughly before deploying.
- For advanced features, refer to the [python-telegram-bot documentation](https://python-telegram-bot.readthedocs.io).

Now you have a fully functional Telegram to-do list bot! Deploy it, test it, and share it with friends to manage tasks efficiently.