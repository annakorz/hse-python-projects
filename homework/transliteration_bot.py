# с помощью словаря создайте простой транслитератор: нужно, чтобы программа принимала с клавиатуры (у нас есть специальный оператор ввода с клавиатуры) слова, записанные кириллицей, и печатала результат латиницей. 

# Пример: *собака >> sobaka*

word = input("Привет! Напиши своё слово: ")

def transliteration(wrd):
    '''Function takes in a string and returns its transliteration'''
    characters = {"а": "a", "б": "b", "в": "v", "г": "g", "д": "d", "е": "e", "ё": "yo", "ж": "zh", "з": "z", "и": "i", "й": "j", "к": "k", "л": "l", "м": "m", "н": "n", "о": "o", "п": "p", "р": "r", "с": "s", "т": "t", "у": "u", "ф": "f", "х": "h", "ц": "ts", "ч": "tch", "ш": "sh", "щ": "shch", "ь": "'", "ы": "y", "ъ": "'", "э": "e", "ю": "yu", "я": "ya"}
    new_word = []
    for char in wrd:
        new_word.append(characters[char])
    
    return "".join(new_word)

print(transliteration(word))

