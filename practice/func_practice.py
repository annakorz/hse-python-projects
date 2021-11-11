# **Задача 1.**  Напишите генератор названий компаний (почти как генератор паролей). 
# Пусть в названии компании будет 6 частей, рандомно выбирающихся из списка names.

# Сделайте это функцией

# генератор названий компаний

import random

names = ["пром","агро","торг","урал","север","юг","техно",
"экспо","метал","нефть","сельхоз","фарм","строй",
"кредит","алмаз","-девелопмент","развитие","мос",
"рос","кубань","сибирь","восток","нано","софт",
"микро","онлайн","инвест","текстиль","цемент"]

# Ваш код ниже
def company_name_generator(seq):
    '''Function takes in a sequence and returns a random name of a company'''
    companies = random.sample(seq,6)
    new_companies = []
    for c in companies:
        c = c.capitalize()
        new_companies.append(c)
    return "".join(new_companies)

print(company_name_generator(names))


# **Задача 2.** Генератор паролей

# Пароли, получаемые в результате, должны удовлетворять следующим условиям: 
#      - в пароле есть 3 заглавные буквы (любые, в любом месте пароля)
#      - в пароле есть 4 цифры (любые, в любом месте)
#      - оставшиеся символы пароля - строчные латинские буквы
     
# Создайте функцию, которая генерирует пароли, пользователь задает число символов в пароле (как аргумент функции)

import random
import string

def password_setup(num,num_cap_letters = 3,num_digits = 4):
    '''Function takes in a number and returns a generated password that must consist of 3 capital letters, 4 numbers and any number of other lowercase letters'''
    # random.sample(seq, num of elements to be picked) returns a list of unique elements vs. random.choice(seq) returns a list of random elements (i.e. elements can be repeated)
    capital_letters = random.sample(string.ascii_uppercase, num_cap_letters)
    numbers = random.sample(string.digits,num_digits)
    lowercase_letters = [random.choice(string.ascii_lowercase) for x in range(num+1-num_cap_letters-num_digits)]
    symbols = numbers + lowercase_letters + capital_letters
    password = "".join(random.sample(symbols, len(symbols)))

    return password

print(password_setup(11))