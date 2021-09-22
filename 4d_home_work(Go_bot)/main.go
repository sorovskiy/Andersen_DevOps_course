package main

import (
	"github.com/Syfaro/telegram-bot-api"
	"log"
)

var (
	// глобальная переменная в которой храним токен
	telegramBotToken string
)

func main() {
	// используя токен создаем новый инстанс бота
	telegramBotToken = "2035768299:AAHHpAJxKlCSpY4HAFrh2goN1tuqVt2txC4"
	bot, err := tgbotapi.NewBotAPI(telegramBotToken)
	if err != nil {
		log.Panic(err)
	}

	log.Printf("Authorized on account %s", bot.Self.UserName)

	// u - структура с конфигом для получения апдейтов
	u := tgbotapi.NewUpdate(0)
	u.Timeout = 60

	// используя конфиг u создаем канал в который будут прилетать новые сообщения
	updates, err := bot.GetUpdatesChan(u)

	// в канал updates прилетают структуры типа Update
	// вычитываем их и обрабатываем
	for update := range updates {
		// универсальный ответ на любое сообщение
		reply := "No such command"
		if update.Message == nil {
			continue
		}

		// логируем от кого какое сообщение пришло
		log.Printf("[%s] %s", update.Message.From.UserName, update.Message.Text)

		// свитч на обработку комманд
		switch update.Message.Command() {
		case "start":
			reply = "Hi! Enter the command."
		case "git":
			reply = "https://github.com/sorovskiy/Andersen_DevOps_course"
		case "tasks":
			reply = " 1. Create own repo + Til blog \n 2. Flask service + Ansible \n 3. Bash script \n 4. Telegram bot"
		case "task1":
			reply = "https://github.com/sorovskiy/Andersen_DevOps_course/tree/main/1st_home_work"
		case "task2":
			reply = "https://github.com/sorovskiy/Andersen_DevOps_course/tree/main/2d_home_work(Ansible)"
		case "task3":
			reply = "https://github.com/sorovskiy/Andersen_DevOps_course/tree/main/3d_home_work(Bash_script)"
		case "task4":
			reply = "https://github.com/sorovskiy/Andersen_DevOps_course/tree/main/4d_home_work(Go_bot)"
		}

		// создаем ответное сообщение
		msg := tgbotapi.NewMessage(update.Message.Chat.ID, reply)
		// отправляем
		bot.Send(msg)
	}
}
