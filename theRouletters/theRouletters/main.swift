import Foundation

var player1: String = "Игрок 1"
var player2: String = "Игрок 2"
var turn = true //true == player1, false == player2
var life1 = 3, life2 = 3, item_number: Int
var choise = "-1"//0 взять оружие, 1 стрельба во врага, 2 стрельба в себя
var inv1: [String] = ["-", "-", "-", "-"]
var inv2: [String] = ["-", "-", "-", "-"]
var action = 7
var currentCamora = 0
var holdGun = false

var armor1 = false, armor2 = false, double_damage = false
var baraban: [Bool] = [false, false, false, false, false, false]
var item_list: [String] = ["Аптечка", "Ножовка", "Броня"]

func clearConsole(){
    print("\u{001b}[2J")
    print("\u{001b}[H")
}

func addItems(){
    var count = 0
    for _ in 1...2{
        for j in 1...4{
            if inv1[j] == "-"{
                inv1[j] = item_list[Int.random(in: 0...2)]
                break
            }
        }
    }
    for _ in 1...2{
        for j in 1...4{
            if inv2[j] == "-"{
                inv2[j] = item_list[Int.random(in: 0...2)]
                break
            }
        }
    }
}

func reloadBaraban(){
    for i in 0...5{
        baraban[i] = false
    }
    let bullets = Int.random(in: 1...4)
    for _ in 1...bullets{
        while true{
            let camora = Int.random(in: 0...5)
            if baraban[camora] == false{
                baraban[camora] = true
                break
            }
        }
    }
    currentCamora = 0
    print("Сегодня патронов у нас будет:", bullets)
    sleep(1)
}

func rotate_baraban(){
    currentCamora += 1
}


func printInterface(){
    if turn == true{
        clearConsole()
        print("Очередь", player1, "нажать на спуск\n")
        print(player2, "\tHP =", life2)
        if armor2 == true{
            print("\tARM")
        }
        print("")
        for i in 0...3{
            print(i+1, ":", inv2[i], ";", terminator: "")
        }
        if choise == "-1"{
            print("\n\nНажми 0 чтобы взять пушку\n\n")
        }
        else if choise == "0" && holdGun == true{
            print("\n\nНажми 1 чтобы стрельнуть в опонента\n", "\nНажми 2 чтобы стрельнуть в себя")
        }
        else if choise == "1" && holdGun == true{
            
        }
        else if choise == "2" && holdGun == true{
            
        }
        print(player1, "HP =", life1, terminator: "")
        if armor1 == true{
            print("\tARM", terminator: "")
        }
        if double_damage == true{
            print("\tDMG+")
        }
        print("")
        for i in 0...3{
            print(i+1, ":", inv1[i], ";", terminator: "")
        }
        print("")
    }
    else{
        
    }
}

func game(){
    inv1[0] = item_list[Int.random(in: 0...2)];inv1[1] = "-";inv1[2] = "-";inv1[3] = "-";
    inv2[0] = item_list[Int.random(in: 0...2)];inv2[1] = "-";inv2[2] = "-";inv2[3] = "-";
    life1 = 3; life2 = 3
    reloadBaraban()
    turn = true
    while true{
        action = 7
        choise = "-1"
        if life1 == 0{
            clearConsole()
            print("Поздравляю ", player2, " с его победой")
            sleep(3)
            return
        }
        else if life2 == 0{
            clearConsole()
            print("Поздравляю ", player1, " с его победой")
            sleep(3)
            return
        }
        if currentCamora >= 6{
            print("Кхм, вы сделали 6 выстрелов и ещё живы?\nВремя нового раунда")
            addItems()
            reloadBaraban()
        }
        if turn == true{
            while choise != "0"{
                printInterface()
                choise = readLine() ?? "-1"
                
            }
            holdGun = true
        }
        else{
            
        }
    }
}

func players(){
    clearConsole()
    print("Введите имя для игрока 1")
    player1 = readLine() ?? "Игрок 1"
    if player1 == ""{
        player1 = "Игрок 1"
    }
    print("Введите имя для игрока 2")
    player2 = readLine() ?? "Игрок 2"
    if player2 == ""{
        player2 = "Игрок 2"
    }
    game()
}

func information(){
    clearConsole()
    print("Добро пожаловать в игру путник",
          "\n Данная игра рассчитана на не более двух игроков",
          "\n\n  Правила:",
          "\n Стрельба: в игре вы можете направить пушку как на себя так и на соперника.",
          "\nВыстрел в себя хоть и является риском но дает сделать еще один выстрел.",
          "\nВыстрел во врага и так понятно чем полезен.",
          "\nПеред выстрелом вы можете использовать бонусы, но после взятия пушки в руки этого сделать нельзя.",
          "\n Бонусы: полезные предметы позволяющие склонить победу в свою сторону ну или наоборот.",
          "\n! Бонусы можно получить по окончанию раунда, т.е. когда закончатся каморы в барабане !",
          "\nАптечка - позволяет восстановить 1 жизнь, максимальное количество жизней 3.",
          "\nНожовка - позволяет укоротить длину пушки и удвоить урон. применяется один раз за ход.",
          "\nБроня - выдает игроку защиту от одного выстрела по нему или снизит урон от усиленого выстрела.",
          "\nЭто все удачи в игре путник.")
    print("\n\n  **Чтобы продолжить введите любой символ**")
    readLine()
}

func menu(){
    while true{
        clearConsole()
        print("  _   _          ___          _     _   \n",
              " | |_| |_  ___  | _ \\___ _  _| |___| |_ \n",
              " |  _| ' \\/ -_) |   / _ \\ || | / -_)  _|\n",
              "  \\__|_||_\\___| |_|_\\___/\\_,_|_\\___|\\__|\n",
              "                                        ")
        print("   1  * Приступим *", "\n   2  *  Памятка  *", "\n   3  *   Выход   *")
        let function = readLine()
        if function == "1" || function=="Приступим" || function=="приступим" || function=="ПРИСТУПИМ"{
            players()
        }
        else if function == "2" || function=="Памятка" || function=="памятка" || function=="ПАМЯТКА"{
            information()
        }
        else if function == "3" || function=="Выход" || function=="выход" || function=="ВЫХОД"{
            return
        }
    }
}


clearConsole()
print("\n⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣷⣾⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀\n",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣿⣯⣽⡙⠿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀\n",
      "⠀⠀⠀⠀⠀⠀⢠⣾⣿⡗⡞⣭⠭⡘⠋⠋⠀⣰⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n",
      "⠀⠀⠀⠀⣀⣤⣿⣿⣿⣿⣿⠔⠃⠀⢀⣤⡶⠋⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀\n",
      "⠀⢀⣴⣾⣿⣿⣿⣿⣷⣮⡐⠀⠀⣰⣯⠟⠡⢀⣼⣆⡀⠀⠀⠀⠀⠀⠀⠀⠀\n",
      "⣰⣿⣿⣿⣿⣿⣛⠿⣿⣽⢿⣦⣨⡷⠋⠀⢸⣾⣿⣹⡾⢧⣀⠀⠀⠀⠀⠀⠀\n",
      "⣿⣿⡿⣻⣿⣿⣿⣷⣎⢻⣞⣿⡟⠀⡄⠀⣼⢿⣧⣿⣿⣷⣦⠛⣦⡀⠀⠀⠀\n",
      "⣿⣿⡇⣿⣿⣿⣿⣿⣿⡄⣿⣿⣇⠀⣷⣾⣟⣼⣿⣿⣿⣿⣿⣏⡤⠽⠦⡀⠀\n",
      "⣿⣿⣧⡻⣿⣿⣿⣿⡿⣸⣯⣿⣇⡜⢹⣷⣿⣿⣿⣿⣿⣿⡟⢛⠀⠀⠀⠐⡄\n",
      "⠈⢻⡿⣿⣾⣿⣿⣿⣾⣿⣿⣿⠋⣰⡿⠛⠻⣿⣿⣿⣿⡿⠈⠀⠀⠀⠀⢠⠃\n",
      "⠀⠈⣿⣳⣯⣿⠾⣳⢯⣿⠟⢁⣼⣿⢡⠖⠓⠲⣝⣿⣿⡏⢀⡠⣀⣀⡼⠃⠀\n",
      "⠀⠀⣿⣟⣿⣿⣿⣎⢟⣽⢀⣾⣿⣴⢸⣄⠀⠀⣸⣽⣿⡃⠎⠀⠀⡽⠁⠀⠀\n",
      "⠀⢀⣿⣟⢿⣿⣿⡟⣼⡟⣾⣿⢯⣿⠺⠽⠷⡾⠷⢏⠛⢧⡘⠢⣀⠇⠀⠀⠀\n",
      "⠀⠸⣿⣝⠷⣿⣽⠾⢟⣽⣿⣿⡿⠃⠀⠀⠀⠀⠀⠀⠉⢨⠿⠷⠚⠀⠀⠀⠀\n",
      "⠀⠀⢹⣿⣿⣶⣶⣾⣿⣿⡟⢁⡀⢀⠀⢀⠀⠀⠀⠀⠀⡽⣂⠀⠀⠀⠀⠀⠀\n",
      "⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣷⣦⣜⣢⡉⢆⠂⣀⣀⡤⠞⢑⠇⠀⠀⠀⠀⠀⠀\n",
      "⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⡍⠉⠉⠉⠉⠉⠉⠀⠀⠀⡼⠀⠀⠀⠀⠀⠀⠀\n",
      "⠀⠀⠀⠻⣿⣿⣿⣿⣿⣿⣿⡌⣄⠢⢄⠠⡀⠀⠀⢀⣰⠃⠀⠀⠀⠀⠀⠀⠀\n",
      "⠀⠀⠀⠀⠈⢻⣿⣿⣿⡿⣿⠿⣴⢧⣮⠴⡥⠶⢚⣩⠆⠀⠀⠀⠀⠀⠀⠀⠀\n",
      "⠀⠀⠀⠀⠀⠀⢻⣿⣿⡖⢠⢐⡀⢀⠀⠄⠀⠀⡼⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀\n",
      "⠀⠀⠀⠀⠀⠀⠀⠙⢿⣟⣲⢦⣽⢒⡌⣌⡴⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n")
for _ in 1...30{
    print("#", terminator: "")
    usleep(50000)
}
print("\n\n**Запуск**")
sleep(1)
clearConsole()
menu()
