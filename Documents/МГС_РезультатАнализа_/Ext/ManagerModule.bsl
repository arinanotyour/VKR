﻿Функция ПечатьПаспортКачества(МассивОбъектов, ОбъектыПечати, ПараметрыПечати) Экспорт
	
	ТабДок = Новый ТабличныйДокумент;
	ТабДок.АвтоМасштаб			= Истина;
	ТабДок.ПолеСверху			= 10;
	ТабДок.ПолеСнизу			= 10;
	ТабДок.ПолеСправа			= 0;
	ТабДок.ОриентацияСтраницы	= ОриентацияСтраницы.Портрет;
	ТабДок.КлючПараметровПечати	= "ПАРАМЕТРЫ_ПЕЧАТИ_Партии";
	ТабДок.ДвусторонняяПечать = ТипДвустороннейПечати.ПереворотВлево;
	ТабДок.Очистить();
	
	Макет = Документы.МГС_РезультатАнализа.ПолучитьМакет("ПаспортКачества");
	
	Для каждого ТекущаяОтгрузка Из  МассивОбъектов Цикл
		ТабДокСертификат = Новый ТабличныйДокумент;
		
		ТипОтгрузки ="Медицинский";// ПолучитьТипОтгрузкиПоНоменклатуре(ТекущаяОтгрузка. Номенклатура) ; 
		Если ТипОтгрузки =  "Медицинский" Тогда
			//Если ТекущаяОтгрузка.Контрагент.СтранаРегистрации= Справочники.СтраныМира.НайтиПоНаименованию("БЕЛАРУСЬ") Тогда
			//	ОбластьШапка = Макет.ПолучитьОбласть("Шапка_МЗА_РБ");
			//	ОбластьТехническиеТребования = Макет.ПолучитьОбласть("ТехническиеТребованияМЗА_РБ");
			//Иначе
			ОбластьШапка = Макет.ПолучитьОбласть("Шапка_МЗА");
			ОбластьТехническиеТребования = Макет.ПолучитьОбласть("ТехническиеТребованияМЗА");			
			//КонецЕсли;
		ИначеЕсли ТипОтгрузки =  "Технический" Тогда	
			ОбластьШапка = Макет.ПолучитьОбласть("Шапка_ТЗА");
			ОбластьТехническиеТребования = Макет.ПолучитьОбласть("ТехническиеТребованияТЗА");
		Иначе  	
			ОбластьШапка = Макет.ПолучитьОбласть("Шапка_ПЗА");
			ОбластьТехническиеТребования = Макет.ПолучитьОбласть("ТехническиеТребованияПЗА");
		КонецЕсли;
		
		//	ОбластьШапка = Макет.ПолучитьОбласть("Шапка");
		ОбластьСерияПартия = Макет.ПолучитьОбласть("СерияПартия");
		//	ОбластьТехническиеТребования = Макет.ПолучитьОбласть("ТехническиеТребования");
		
		
		
		Запрос = Новый Запрос;
		Запрос.Текст =
		"ВЫБРАТЬ
		|	МГС_РезультатАнализаСертификация.Ссылка КАК Ссылка,
		|	МГС_РезультатАнализаСертификация.НомерСтроки КАК НомерСтроки,
		|	МГС_РезультатАнализаСертификация.Баллон КАК Баллон,
		|	МГС_РезультатАнализаСертификация.НеконденсирующиесяГазы КАК НеконденсирующиесяГазы,
		|	МГС_РезультатАнализаСертификация.ВодяныеПары КАК ВодяныеПары,
		|	МГС_РезультатАнализаСертификация.ОксидыАзота КАК ОксидыАзота,
		|	МГС_РезультатАнализаСертификация.СО КАК СО,
		|	МГС_РезультатАнализаСертификация.СО2 КАК СО2,
		|	МГС_РезультатАнализаСертификация.Галогены КАК Галогены,
		|	МГС_РезультатАнализаСертификация.Кислотность КАК Кислотность,
		|	МГС_РезультатАнализаСертификация.ОсновноеВещество КАК ОсновноеВещество,
		|	МГС_РезультатАнализаСертификация.Ссылка.Дата КАК ДатаАнализа
		|ИЗ
		|	Документ.МГС_РезультатАнализа.Сертификация КАК МГС_РезультатАнализаСертификация
		|ГДЕ
		|	МГС_РезультатАнализаСертификация.Ссылка = &Ссылка";
		
		
		Запрос.Параметры.Вставить("Ссылка", ТекущаяОтгрузка);
		Выборка = Запрос.Выполнить().Выбрать();
		
		
		//	ОбластьШапка.Параметры.номер = ПрефиксацияОбъектовКлиентСервер.НомерНаПечать(Текущаяотгрузка.Номер, Истина, Ложь);
		
		ТабДокСертификат.Вывести(ОбластьШапка);
		
		
		ЗапросБаллоны = Новый Запрос;
		ЗапросБаллоны.Текст = 
		//"ВЫБРАТЬ
		//|	МГС_ВыпускБаллоновПартииБаллоны.НомерСтроки КАК НомерСтроки,
		//|	МГС_ВыпускБаллоновПартииБаллоны.ссылка КАК Выпуск,
		//|	МГС_ВыпускБаллоновПартииБаллоны.НомерПартии КАК Партия
		//|ИЗ
		//|	Документ.МГС_ВыпускБаллонов.ПартииБаллоны КАК МГС_ВыпускБаллоновПартииБаллоны
		//|ГДЕ
		//|	МГС_ВыпускБаллоновПартииБаллоны.Ссылка = &Ссылка
		//|ИТОГИ ПО
		//|	Выпуск,
		//|	Партия";
		
		
		
		"ВЫБРАТЬ
		|	МГС_ВыпускБаллонов.Баллон КАК Баллон,
		|	МГС_ВыпускБаллонов.Партия КАК Партия,
		|	МГС_ВыпускБаллонов.Выпуск КАК Выпуск
		|ПОМЕСТИТЬ ВТ_ВыпущенныеБаллоны
		|ИЗ
		|	РегистрСведений.МГС_ВыпускБаллонов КАК МГС_ВыпускБаллонов
		|ГДЕ
		|	МГС_ВыпускБаллонов.Выпуск = &Выпуск
		|	И МГС_ВыпускБаллонов.Состояние = &СостояниеВыпущено
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	МГС_ВыпускБаллонов.Баллон КАК Баллон
		|ПОМЕСТИТЬ Вт_Забракованные
		|ИЗ
		|	РегистрСведений.МГС_ВыпускБаллонов КАК МГС_ВыпускБаллонов
		|ГДЕ
		|	МГС_ВыпускБаллонов.Выпуск = &Выпуск
		|	И МГС_ВыпускБаллонов.Баллон В
		|			(ВЫБРАТЬ
		|				ВТ_ВыпущенныеБаллоны.Баллон
		|			ИЗ
		|				ВТ_ВыпущенныеБаллоны КАК ВТ_ВыпущенныеБаллоны)
		|	И МГС_ВыпускБаллонов.Состояние = &СостояниеЗабракованно
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВТ_ВыпущенныеБаллоны.Баллон КАК Баллон,
		|	ВТ_ВыпущенныеБаллоны.Партия КАК Партия,
		|	ВТ_ВыпущенныеБаллоны.Выпуск КАК Выпуск
		|ИЗ
		|	ВТ_ВыпущенныеБаллоны КАК ВТ_ВыпущенныеБаллоны
		|		ЛЕВОЕ СОЕДИНЕНИЕ Вт_Забракованные КАК Вт_Забракованные
		|		ПО ВТ_ВыпущенныеБаллоны.Баллон = Вт_Забракованные.Баллон
		|ГДЕ
		|	Вт_Забракованные.Баллон ЕСТЬ NULL
		|
		|УПОРЯДОЧИТЬ ПО
		|	Выпуск,
		|	Партия,
		|	Баллон
		|ИТОГИ ПО
		|	Выпуск,
		|	Партия";
		
		ЗапросБаллоны.УстановитьПараметр("Выпуск", ТекущаяОтгрузка.ДокументВыпуск);
		ЗапросБаллоны.УстановитьПараметр("СостояниеВыпущено", Перечисления.МГС_СостояниеБаллона.Выпущено);
		ЗапросБаллоны.УстановитьПараметр("СостояниеЗабракованно", Перечисления.МГС_СостояниеБаллона.Забракованно);
		
		РезультатЗапросаБаллоны = ЗапросБаллоны.Выполнить();
		
		ВыборкаВыпуск = РезультатЗапросаБаллоны.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
		КоличествоБаллонов= 0;
		Пока ВыборкаВыпуск.Следующий() Цикл
			// Вставить обработку выборки ВыборкаВыпуск
			ОбластьСерияПартия.Параметры.Серия = Документы.МГС_ВыпускБаллонов.ПолучитьНомерСерии( ВыборкаВыпуск.Выпуск.ТипВыпуска,ВыборкаВыпуск.Выпуск.Номер);
			ТекстПартии = "";
			ВыборкаПартия = ВыборкаВыпуск.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
			
			Пока ВыборкаПартия.Следующий() Цикл
				КоличествоБаллоновВПартии =0;
				ВыборкаДетальная = ВыборкаПартия.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);				
				Пока ВыборкаДетальная.Следующий() Цикл
					КоличествоБаллоновВПартии=КоличествоБаллоновВПартии+1
				КонецЦикла;
				КоличествоБаллонов= КоличествоБаллонов+КоличествоБаллоновВПартии;
				ТекстПоБаллонам = "";
				Если КоличествоБаллоновВПартии<>20 Тогда
					ТекстПоБаллонам = "("+Строка(КоличествоБаллоновВПартии)+")"			
				КонецЕсли;
				
			
				ТекстПартии = ТекстПартии+Строка(ВыборкаПартия.Партия)+ТекстПоБаллонам+", ";
				// Вставить обработку выборки ВыборкаПартия
				
				//		ВыборкаДетальныеЗаписи = ВыборкаПартия.Выбрать();
				//
				//		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
				//			// Вставить обработку выборки ВыборкаДетальныеЗаписи
				//		КонецЦикла;
			КонецЦикла;
			Если СтрЗаканчиваетсяНа(ТекстПартии,", ") Тогда			
				ТекстПартии = Лев(ТекстПартии,СтрДлина(ТекстПартии)-2);
			КонецЕсли;	
		//	ОбластьСерияПартия.Параметры.ТекстПартии =ТекстПартии;
			ОбластьСерияПартия.Параметры.КоличествоБаллонов = КоличествоБаллонов;

			ТабДокСертификат.Вывести(ОбластьСерияПартия);
		КонецЦикла;
		
		
		//ОбластьСтрока = Макет.ПолучитьОбласть("Строка");
		Кислотность	="";	
		ОксидыАзота	=  0;	
		СО2		=  0;		
		СО		=  0;	
		НеконденсирующиесяГазы		=  0;	
		ВодяныеПары			=  0;
		Галогены =истина;		
		ОсновноеВещество = 100;
		ВставлятьРазделительСтраниц = Ложь;
		ДатаАнализаНачало = '22220101000000';
		ДатаАнализаКонец = '00010101000000';
		Пока Выборка.Следующий() Цикл
			
			Если Кислотность = ""	Тогда
				Кислотность = Выборка.Кислотность;
			ИначеЕсли Выборка.Кислотность <> "соответствует"
				и Выборка.Кислотность <> "Соответствует"
				и Выборка.Кислотность <> "нейтральная" 	Тогда
				Кислотность = Выборка.Кислотность;
			КонецЕсли;			
			Если Выборка.ОксидыАзота > ОксидыАзота Тогда
				ОксидыАзота = Выборка.ОксидыАзота;
			КонецЕсли;			
			Если Выборка.СО2 > СО2 Тогда
				СО2 = Выборка.СО2;
			КонецЕсли;			
			Если Выборка.СО > СО Тогда
				СО = Выборка.СО;
			КонецЕсли;			
			Если Выборка.НеконденсирующиесяГазы > НеконденсирующиесяГазы Тогда
				НеконденсирующиесяГазы = Выборка.НеконденсирующиесяГазы;
			КонецЕсли;			
			Если Выборка.ВодяныеПары > ВодяныеПары Тогда
				ВодяныеПары = Выборка.ВодяныеПары;
			КонецЕсли;		
			Если Не Выборка.Галогены Тогда
				Галогены = Ложь;
			КонецЕсли;		
			
			Если Выборка.ОсновноеВещество < ОсновноеВещество Тогда
				ОсновноеВещество = Выборка.ОсновноеВещество;
			КонецЕсли;	
			
			Если Выборка.ДатаАнализа>ДатаАнализаКонец  Тогда
				ДатаАнализаКонец = НачалоДня(Выборка.ДатаАнализа)
			КонецЕсли;	
			
			Если Выборка.ДатаАнализа<ДатаАнализаНачало  Тогда
				ДатаАнализаНачало = НачалоДня(Выборка.ДатаАнализа)
			КонецЕсли;	
			
		КонецЦикла;
		
		Если Кислотность = "соответствует" Тогда
			Кислотность =  "Соответствует"		
		КонецЕсли; 
		
		ОбластьТехническиеТребования.Параметры.ОксидыАзота = ОксидыАзота;
		ОбластьТехническиеТребования.Параметры.СО2 = СО2;
		ОбластьТехническиеТребования.Параметры.СО = СО;
		ОбластьТехническиеТребования.Параметры.НеконденсирующиесяГазы = НеконденсирующиесяГазы;
		ОбластьТехническиеТребования.Параметры.ВодяныеПары = ВодяныеПары;
		ОбластьТехническиеТребования.Параметры.Кислотность = Кислотность;
		
		//Если Кислотность Тогда 
		//	ОбластьТехническиеТребования.Параметры.Кислотность = "Соответствует"
		//иначе
		//	ОбластьТехническиеТребования.Параметры.Кислотность = "Не соответствует"
		//КонецЕсли;
		
		Если Галогены Тогда 
			ОбластьТехническиеТребования.Параметры.Галогены = "Отсутствие опалесценции"
		иначе
			ОбластьТехническиеТребования.Параметры.Галогены = "Появление опалесценции"
		КонецЕсли;
		
		Если ОксидыАзота = 0.00001 Тогда 
			ОбластьТехническиеТребования.Параметры.ОксидыАзота = "<0,00001"
		КонецЕсли;
		Если СО = 0.0001 Тогда 
			ОбластьТехническиеТребования.Параметры.СО = "<0,0001"
		КонецЕсли;		
		Если СО2 <= 0 Тогда 
			ОбластьТехническиеТребования.Параметры.СО2 =  "отсутствие мути"
		КонецЕсли;		
		
		Если НеконденсирующиесяГазы <= 0.05 Тогда 
			ОбластьТехническиеТребования.Параметры.НеконденсирующиесяГазы =  "<0,05"
		КонецЕсли;
		
		Если ВодяныеПары <= 0.0011 Тогда 
			ОбластьТехническиеТребования.Параметры.ВодяныеПары =  "<0,0011"
		КонецЕсли;
		
		
		Если ТипОтгрузки <>   "Медицинский" Тогда
			ОбластьТехническиеТребования.Параметры.ОсновноеВещество = ОсновноеВещество;
			Если ОсновноеВещество >= 99.79 Тогда 
				ОбластьТехническиеТребования.Параметры.ОсновноеВещество = ">99,79"
			КонецЕсли;	
		КонецЕсли;	
		//КоличествоБаллонов = ТекущаяОтгрузка.ДокументВыпуск.КоличествоБаллоновВВыпуске;		
		//ОбластьТехническиеТребования.Параметры.КоличествоБаллонов = КоличествоБаллонов;
		
		Если ДатаАнализаНачало = ДатаАнализаКонец Тогда 
			ТекстДатаАнализа = Формат(ДатаАнализаНачало,"ДФ=dd.MM.yyyy")
		иначе
			ТекстДатаАнализа = Формат(ДатаАнализаНачало,"ДФ=dd.MM.yyyy")+"-"+Формат(ДатаАнализаКонец,"ДФ=dd.MM.yyyy")
		КонецЕсли;	
//		ОбластьТехническиеТребования.Параметры.ТекстДатаАнализа =ТекстДатаАнализа;		
		ТабДокСертификат.Вывести(ОбластьТехническиеТребования);
		
		ОбластьПодвал =  Макет.ПолучитьОбласть("Подвал");
		УстановитьПривилегированныйРежим(Истина);
		ДанныеПодписант = ОбщегоНазначенияБПВызовСервера.ДанныеФизЛица(Текущаяотгрузка.Организация, Текущаяотгрузка.Ответственный.ФизическоеЛицо, Текущаяотгрузка.Дата);
		ОбластьПодвал.Параметры.ФИОПодписант =      ДанныеПодписант.Представление;
		ОбластьПодвал.Параметры.ДолжностьПодписант = "Начальник сектора контроля готового продукта";//ДанныеПодписант.Должность;
		УстановитьПривилегированныйРежим(Ложь);
		//ДанныеПодписант2 = ОбщегоНазначенияБПВызовСервера.ДанныеФизЛица(Текущаяотгрузка.Организация, Текущаяотгрузка.Подписант2, Текущаяотгрузка.Дата);
		//ОбластьПодвал.Параметры.ФИОПодписант2 =      ДанныеПодписант2.Представление;
		//ОбластьПодвал.Параметры.ДолжностьПодписант2 = ДанныеПодписант2.Должность;
		//
		//ДанныеПодписант3 = ОбщегоНазначенияБПВызовСервера.ДанныеФизЛица(Текущаяотгрузка.Организация, Текущаяотгрузка.Подписант3, Текущаяотгрузка.Дата);
		//ОбластьПодвал.Параметры.ФИОПодписант3	=      ДанныеПодписант3.Представление;
		//ОбластьПодвал.Параметры.ДолжностьПодписант3 = ДанныеПодписант3.Должность;
		
		ОбластьПодвал.Параметры.Дата = Формат(Текущаяотгрузка.Дата,"ДФ='dd MMMM yyyy'");
		ТабДокСертификат.Вывести(ОбластьПодвал);
		ТабДок.Вывести(ТабДокСертификат);
		
		//ТабДок.ВывестиГоризонтальныйРазделительСтраниц();
		//ОбластьШапкаСертификат = Макет.ПолучитьОбласть("ШапкаСертификат");
		//ОбластьШапкаСертификат.Параметры.Номер =ПрефиксацияОбъектовКлиентСервер.НомерНаПечать(Текущаяотгрузка.Номер, Истина, Ложь);
		//ОбластьШапкаСертификат.Параметры.КоличествоБаллонов =КоличествоБаллонов;
		//ТабДок.Вывести(ОбластьШапкаСертификат);
		//ВыборкаВыпуск = РезультатЗапросаБаллоны.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);		
		//Пока ВыборкаВыпуск.Следующий() Цикл
		//	ВыборкаПартия = ВыборкаВыпуск.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);	
		//	НомерПартииНаЛисте = 1;
		//	Пока ВыборкаПартия.Следующий() Цикл
		//		ОбластьПартия = Макет.ПолучитьОбласть("Партия");
		//		// Вставить обработку выборки ВыборкаВыпуск
		//		ОбластьПартия.Параметры.Партия =ВыборкаПартия.Партия;
		//		// Вставить обработку выборки ВыборкаПартия
		//		НомерБаллона = 1;
		//		ВыборкаДетальныеЗаписи = ВыборкаПартия.Выбрать();				//
		//		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		//			// Вставить обработку выборки ВыборкаДетальныеЗаписи
		//			ОбластьПартия.Параметры["Баллон"+НомерБаллона] = ВыборкаДетальныеЗаписи.Баллон;
		//			НомерБаллона = НомерБаллона+1;
		//		КонецЦикла;
		//		ТабДок.Вывести(ОбластьПартия);
		//		НомерПартииНаЛисте = НомерПартииНаЛисте+1;
		//		Если НомерПартииНаЛисте >10 тогда
		//			ТабДок.ВывестиГоризонтальныйРазделительСтраниц();
		//			ТабДок.Вывести(ТабДокСертификат);
		//			ТабДок.ВывестиГоризонтальныйРазделительСтраниц();
		//			НомерПартииНаЛисте =1;
		//		КонецЕсли;	
		//	КонецЦикла;
		//КонецЦикла;
	КонецЦикла;
	
	Возврат ТабДок;
КонецФункции

Функция ПечатьЖурнал(МассивОбъектов, ОбъектыПечати, ПараметрыПечати) Экспорт
	
	ТабДок = Новый ТабличныйДокумент;
	ТабДок.АвтоМасштаб			= Истина;
	ТабДок.ПолеСверху			= 10;
	ТабДок.ПолеСнизу				= 10;
	ТабДок.ПолеСправа			= 0;
	ТабДок.ОриентацияСтраницы	= ОриентацияСтраницы.Ландшафт;
	ТабДок.КлючПараметровПечати	= "ПАРАМЕТРЫ_ПЕЧАТИ_Партии";
	
	//{{_КОНСТРУКТОР_ПЕЧАТИ(Печать)
	Макет = Документы.МГС_РезультатАнализа.ПолучитьМакет("Журнал");
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	МГС_РезультатАнализаСертификация.Ссылка КАК Ссылка,
	|	МГС_РезультатАнализаСертификация.НомерСтроки КАК НомерСтроки,
	|	МГС_РезультатАнализаСертификация.Баллон КАК Баллон,
	|	МГС_РезультатАнализаСертификация.НеконденсирующиесяГазы КАК НеконденсирующиесяГазы,
	|	МГС_РезультатАнализаСертификация.ВодяныеПары КАК ВодяныеПары,
	|	МГС_РезультатАнализаСертификация.ОксидыАзота КАК ОксидыАзота,
	|	МГС_РезультатАнализаСертификация.СО КАК СО,
	|	МГС_РезультатАнализаСертификация.СО2 КАК СО2,
	|	МГС_РезультатАнализаСертификация.Галогены КАК Галогены,
	|	МГС_РезультатАнализаСертификация.Кислотность КАК Кислотность,
	|	МГС_РезультатАнализаСертификация.ОсновноеВещество КАК ОсновноеВещество,
	|	МГС_РезультатАнализаСертификация.Ссылка.ДокументВыпуск КАК ДокументВыпуск,
	|	МГС_РезультатАнализаСертификация.Ссылка.Дата КАК Дата,
	|	МГС_РезультатАнализаСертификация.Ссылка.Ответственный КАК Ответственный,
	|	МГС_РезультатАнализаСертификация.Ссылка.Организация КАК Организация,
	|	МГС_РезультатАнализаСертификация.ДатаАнализа КАК ДатаАнализа
	|ИЗ
	|	Документ.МГС_РезультатАнализа.Сертификация КАК МГС_РезультатАнализаСертификация
	|ГДЕ
	|	МГС_РезультатАнализаСертификация.Ссылка В(&Ссылки)";
	
	//Запрос.УстановитьПараметр("МассивОбъектов", МассивОбъектов);
	Запрос.Параметры.Вставить("Ссылки", МассивОбъектов);
	Выборка = Запрос.Выполнить().Выбрать();
	
	// ОбластьЗаголовок = Макет.ПолучитьОбласть("Заголовок");
	// ОбластьШапка = Макет.ПолучитьОбласть("Шапка");
	// ОбластьДокументыОтгрузкиШапка = Макет.ПолучитьОбласть("ДокументыОтгрузкиШапка");
	//ОбластьСтрока = Макет.ПолучитьОбласть("Строка");
	//ОбластьПодвал = Макет.ПолучитьОбласть("Подвал");
	
	ТабДок.Очистить();
	ТипВыпуска = МассивОбъектов[0].ДокументВыпуск.ТипВыпуска ; 
	Если ТипВыпуска =  Справочники.МГС_ТипыВыпускаБаллонов.Медицинский Тогда
		ОбластьШапка = Макет.ПолучитьОбласть("ШапкаМЗА");
		ОбластьСтрока = Макет.ПолучитьОбласть("СтрокаМЗА");
		//ИначеЕсли ТипВыпуска =  Справочники.МГС_ТипыВыпускаБаллонов.Технический Тогда	
		//    ОбластьШапка = Макет.ПолучитьОбласть("ШапкаТЗА");
	Иначе  	
		ОбластьШапка = Макет.ПолучитьОбласть("ШапкаПЗА");
		ОбластьСтрока = Макет.ПолучитьОбласть("СтрокаПЗА");
	КонецЕсли;
	
	ТабДок.Вывести(ОбластьШапка);
	
	
	ВставлятьРазделительСтраниц = Ложь;
	Пока Выборка.Следующий() Цикл
		Если ВставлятьРазделительСтраниц Тогда
			ТабДок.ВывестиГоризонтальныйРазделительСтраниц();
		КонецЕсли;
		ОбластьСтрока.Параметры.Заполнить(Выборка);
		Если Выборка.ОксидыАзота = 0.00001 Тогда 
			ОбластьСтрока.Параметры.ОксидыАзота = "<0.00001"
		КонецЕсли;
		Если Выборка.СО = 0.0001 Тогда 
			ОбластьСтрока.Параметры.СО = "<0.0001"
		КонецЕсли;
		
		Если Выборка.СО2 = 0 Тогда 
			ОбластьСтрока.Параметры.СО2 = "отсутствие мути"
		КонецЕсли;
		Если ТипВыпуска <>  Справочники.МГС_ТипыВыпускаБаллонов.Медицинский Тогда
			Если Выборка.ОсновноеВещество >= 99.79 Тогда 
				ОбластьСтрока.Параметры.ОсновноеВещество = ">99.79"
			КонецЕсли;
		КонецЕсли;
		//Если Выборка.Кислотность Тогда 
		//    ОбластьСтрока.Параметры.Кислотность = "Соответствует"
		//иначе
		//    ОбластьСтрока.Параметры.Кислотность = "Не соответствует"
		//КонецЕсли;
		
		Если Выборка.Галогены Тогда 
			ОбластьСтрока.Параметры.Галогены = "Отсутствие опалесценции"
		иначе
			ОбластьСтрока.Параметры.Галогены = "Появление опалесценции"
		КонецЕсли;
		Для каждого СтрокаПартииБаллоныВыпуска Из Выборка.ДокументВыпуск.ПартииБаллоны Цикл
			Для н = 1 по 20 Цикл
				Если Выборка.Баллон = СтрокаПартииБаллоныВыпуска["Баллон"+н] Тогда
					ОбластьСтрока.Параметры.НомерПартии  =СтрокаПартииБаллоныВыпуска.НомерПартии;
					Прервать;
				КонецЕсли;
			КонецЦикла;		  
		КонецЦикла;
		
		ДанныеПодписант = ОбщегоНазначенияБПВызовСервера.ДанныеФизЛица(Выборка.Организация, Выборка.Ответственный.ФизическоеЛицо, Выборка.Дата);
		ОбластьСтрока.Параметры.Лаборант =      ДанныеПодписант.Представление;
		
		
		ТабДок.Вывести(ОбластьСтрока);
		
		// ВставлятьРазделительСтраниц = Истина;
	КонецЦикла;
	
	Возврат ТабДок;
КонецФункции

Функция ПечатьПереченьБаллонов(МассивОбъектов, ОбъектыПечати, ПараметрыПечати) Экспорт
	
	ТабДок = Новый ТабличныйДокумент;
	ТабДок.АвтоМасштаб			= Истина;
	ТабДок.ПолеСверху			= 10;
	ТабДок.ПолеСнизу			= 10;
	ТабДок.ПолеСправа			= 10;
	ТабДок.ОриентацияСтраницы	= ОриентацияСтраницы.Портрет;
	ТабДок.КлючПараметровПечати	= "ПАРАМЕТРЫ_ПЕЧАТИ_Партии";
	ТабДок.ДвусторонняяПечать = ТипДвустороннейПечати.ПереворотВлево;
	ТабДок.Очистить();
	
	Макет = Документы.МГС_РезультатАнализа.ПолучитьМакет("ПереченьБаллонов");
	
	Для каждого ТекущаяОтгрузка Из  МассивОбъектов Цикл
		
		
		Запрос = Новый Запрос;
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	МГС_РезультатАнализа.ДокументВыпуск КАК ДокументВыпуск
		|ПОМЕСТИТЬ Вт_Выпуски
		|ИЗ
		|	Документ.МГС_РезультатАнализа КАК МГС_РезультатАнализа
		|ГДЕ
		|	МГС_РезультатАнализа.Ссылка В(&МассивОбъектов)
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	МГС_ВыпускБаллоновПартииБаллоны.НомерПартии КАК НомерПартии,
		|	МГС_ВыпускБаллоновПартииБаллоны.ТипБаллона КАК ТипБаллона,
		|	МГС_ВыпускБаллоновПартииБаллоны.ДатаПартии КАК ДатаПартии,
		|	МГС_ВыпускБаллоновПартииБаллоны.Баллон1 КАК Баллон1,
		|	МГС_ВыпускБаллоновПартииБаллоны.Баллон2 КАК Баллон2,
		|	МГС_ВыпускБаллоновПартииБаллоны.Баллон3 КАК Баллон3,
		|	МГС_ВыпускБаллоновПартииБаллоны.Баллон4 КАК Баллон4,
		|	МГС_ВыпускБаллоновПартииБаллоны.Баллон5 КАК Баллон5,
		|	МГС_ВыпускБаллоновПартииБаллоны.Баллон6 КАК Баллон6,
		|	МГС_ВыпускБаллоновПартииБаллоны.Баллон7 КАК Баллон7,
		|	МГС_ВыпускБаллоновПартииБаллоны.Баллон8 КАК Баллон8,
		|	МГС_ВыпускБаллоновПартииБаллоны.Баллон9 КАК Баллон9,
		|	МГС_ВыпускБаллоновПартииБаллоны.Баллон10 КАК Баллон10,
		|	МГС_ВыпускБаллоновПартииБаллоны.Баллон11 КАК Баллон11,
		|	МГС_ВыпускБаллоновПартииБаллоны.Баллон13 КАК Баллон13,
		|	МГС_ВыпускБаллоновПартииБаллоны.Баллон14 КАК Баллон14,
		|	МГС_ВыпускБаллоновПартииБаллоны.Баллон15 КАК Баллон15,
		|	МГС_ВыпускБаллоновПартииБаллоны.Баллон17 КАК Баллон17,
		|	МГС_ВыпускБаллоновПартииБаллоны.Баллон18 КАК Баллон18,
		|	МГС_ВыпускБаллоновПартииБаллоны.Баллон19 КАК Баллон19,
		|	МГС_ВыпускБаллоновПартииБаллоны.Баллон20 КАК Баллон20,
		|	МГС_ВыпускБаллоновПартииБаллоны.Баллон12 КАК Баллон12,
		|	МГС_ВыпускБаллоновПартииБаллоны.Баллон16 КАК Баллон16,
		|	МГС_ВыпускБаллоновПартииБаллоны.Ссылка КАК Выпуск
		|ИЗ
		|	Документ.МГС_ВыпускБаллонов.ПартииБаллоны КАК МГС_ВыпускБаллоновПартииБаллоны
		|ГДЕ
		|	МГС_ВыпускБаллоновПартииБаллоны.Ссылка В
		|			(ВЫБРАТЬ
		|				Вт_Выпуски.ДокументВыпуск
		|			ИЗ
		|				Вт_Выпуски КАК Вт_Выпуски)";
		
		Запрос.УстановитьПараметр("МассивОбъектов", МассивОбъектов);
		
		
		
		РезультатЗапросаБаллоны = Запрос.Выполнить();
		
		НомерПартииНаЛисте =1;
		Выборка = РезультатЗапросаБаллоны.Выбрать();		
		Пока Выборка.Следующий() Цикл			
			
			ОбластьПартия = Макет.ПолучитьОбласть("Партия");
			ЗаполнитьЗначенияСвойств(ОбластьПартия.Параметры,Выборка);
			// Вставить обработку выборки ВыборкаВыпуск
			
			ТабДок.Вывести(ОбластьПартия);
			НомерПартииНаЛисте = НомерПартииНаЛисте+1;
			Если НомерПартииНаЛисте >10 тогда
				ТабДок.ВывестиГоризонтальныйРазделительСтраниц();
				НомерПартииНаЛисте =1;
			КонецЕсли;	
		КонецЦикла;
	КонецЦикла;	
	Возврат ТабДок;
КонецФункции

Функция ПечатьРазрешениеНаВыпуск(МассивОбъектов, ОбъектыПечати, ПараметрыПечати) Экспорт
	
	ТабДок = Новый ТабличныйДокумент;
	ТабДок.АвтоМасштаб			= Истина;
	ТабДок.ПолеСверху			= 10;
	ТабДок.ПолеСнизу			= 10;
	ТабДок.ПолеСправа			= 10;
	ТабДок.ОриентацияСтраницы	= ОриентацияСтраницы.Портрет;
	ТабДок.КлючПараметровПечати	= "ПАРАМЕТРЫ_ПЕЧАТИ_Партии";
	ТабДок.ДвусторонняяПечать = ТипДвустороннейПечати.ПереворотВлево;
	ТабДок.Очистить();
	
	Макет = Документы.МГС_РезультатАнализа.ПолучитьМакет("РазрешениеНаВыпуск");
	
	Для каждого ТекущаяОтгрузка Из  МассивОбъектов Цикл
		
		
		Запрос = Новый Запрос;
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	МГС_РезультатАнализа.ДокументВыпуск КАК Выпуск,
		|	МГС_РезультатАнализа.Организация.НаименованиеСокращенное КАК Организация,
		|	МГС_РезультатАнализа.ДокументВыпуск.КоличествоБаллоновВВыпуске КАК КоличествоБаллонов
		|ИЗ
		|	Документ.МГС_РезультатАнализа КАК МГС_РезультатАнализа
		|ГДЕ
		|	МГС_РезультатАнализа.Ссылка В(&МассивОбъектов)";
		
		Запрос.УстановитьПараметр("МассивОбъектов", МассивОбъектов);
		
		
		
		РезультатЗапросаБаллоны = Запрос.Выполнить();
		
		НомерПартииНаЛисте =1;
		Выборка = РезультатЗапросаБаллоны.Выбрать();		
		Пока Выборка.Следующий() Цикл			
			
			ОбластьРазрешение = Макет.ПолучитьОбласть("Разрешение");
			ЗаполнитьЗначенияСвойств(ОбластьРазрешение.Параметры,Выборка);
			//ОбластьРазрешение.Параметры.Организация  = Выборка.Организация;
			ОбластьРазрешение.Параметры.Серия = Документы.МГС_ВыпускБаллонов.ПолучитьНомерСерии( Выборка.Выпуск.ТипВыпуска,Выборка.Выпуск.Номер);  
			//ОбластьРазрешение.Параметры.КоличествоБаллонов  = ВыборкаВыпуск.КоличествоБаллоновВВыпуске;
			ОбластьРазрешение.Параметры.ЛекарственноеСредство  = "АЗОТА ЗАКИСЬ, газ сжатый";
			ОбластьРазрешение.Параметры.ТекущаяДата = Формат( ТекущаяДатаСеанса() ,"ДФ=dd.MM.yyyy");    
			ДанныеПодписант = ОбщегоНазначенияБПВызовСервера.ДанныеФизЛица(Текущаяотгрузка.Организация, Текущаяотгрузка.Ответственный.ФизическоеЛицо, Текущаяотгрузка.Дата);
			ОбластьРазрешение.Параметры.ФИОПодписант =      ДанныеПодписант.Представление;
			
			ТабДок.Вывести(ОбластьРазрешение);
		КонецЦикла;
	КонецЦикла;	
	Возврат ТабДок;
КонецФункции



//   	// ВставлятьРазделительСтраниц = Истина;
//    КонецЦикла;
//    
//   Возврат ТабДок;
//КонецФункции
//
// Сформировать печатные формы объектов
//
// ВХОДЯЩИЕ:
//   ИменаМакетов    - Строка    - Имена макетов, перечисленные через запятую
//   МассивОбъектов  - Массив    - Массив ссылок на объекты которые нужно распечатать
//   ПараметрыПечати - Структура - Структура дополнительных параметров печати
//
// ИСХОДЯЩИЕ:
//   КоллекцияПечатныхФорм - Таблица значений - Сформированные табличные документы
//   ПараметрыВывода       - Структура        - Параметры сформированных табличных документов
//
Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт

Если УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "Журнал") Тогда
	УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(КоллекцияПечатныхФорм, "Журнал", "Журнал", 
	ПечатьЖурнал(МассивОбъектов, ОбъектыПечати, ПараметрыПечати),,"Документ.МГС_РезультатАнализа.Журнал");
КонецЕсли;

Если УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "ПаспортКачества") Тогда
	УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(КоллекцияПечатныхФорм, "ПаспортКачества", "Паспорт качества", 
	ПечатьПаспортКачества(МассивОбъектов, ОбъектыПечати, ПараметрыПечати),,"Документ.МГС_РезультатАнализа.ПаспортКачества");
КонецЕсли;	

Если УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "ПереченьБаллонов") Тогда
	УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(КоллекцияПечатныхФорм, "ПереченьБаллонов", "Перечень баллонов", 
	ПечатьПереченьБаллонов(МассивОбъектов, ОбъектыПечати, ПараметрыПечати),,"Документ.МГС_РезультатАнализа.ПереченьБаллонов");
КонецЕсли;	

Если УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "РазрешениеНаВыпуск") Тогда
	УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(КоллекцияПечатныхФорм, "РазрешениеНаВыпуск", "Разрешение на выпуск", 
	ПечатьРазрешениеНаВыпуск(МассивОбъектов, ОбъектыПечати, ПараметрыПечати),,"Документ.МГС_РезультатАнализа.РазрешениеНаВыпуск");
КонецЕсли;	

//		
//	Если УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "ОтчетПоПартии")Тогда
//		УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(КоллекцияПечатныхФорм, "ОтчетПоПартии", "Отчет по партии", 
//			ОтчетПоПартии(МассивОбъектов, ОбъектыПечати, ПараметрыПечати),,"Документ.МГС_ВыпускБаллонов.ОтчетПоПартии");
//	КонецЕсли;

ОбщегоНазначенияБП.ЗаполнитьДополнительныеПараметрыПечати(МассивОбъектов,
КоллекцияПечатныхФорм,
ОбъектыПечати,
ПараметрыВывода);

КонецПроцедуры

// Заполняет список команд печати.
// 
// Параметры:
//   КомандыПечати - ТаблицаЗначений - состав полей см. в функции УправлениеПечатью.СоздатьКоллекциюКомандПечати
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт

// Журнал
КомандаПечати = КомандыПечати.Добавить();
КомандаПечати.Идентификатор = "Журнал";
КомандаПечати.Представление = НСтр("ru = 'Журнал'");
КомандаПечати.Обработчик    = "УправлениеПечатьюБПКлиент.ВыполнитьКомандуПечати";
КомандаПечати.СписокФорм    = "ФормаСписка,ФормаДокумента";
КомандаПечати.Порядок = 10;

// Паспорт качества
КомандаПечати = КомандыПечати.Добавить();
КомандаПечати.Идентификатор = "ПаспортКачества";
КомандаПечати.Представление = НСтр("ru = 'Паспорт качества'");
КомандаПечати.Обработчик    = "УправлениеПечатьюБПКлиент.ВыполнитьКомандуПечати";
КомандаПечати.СписокФорм    = "ФормаСписка,ФормаДокумента";
КомандаПечати.Порядок = 10;

// Перечень Баллонов
КомандаПечати = КомандыПечати.Добавить();
КомандаПечати.Идентификатор = "ПереченьБаллонов";
КомандаПечати.Представление = НСтр("ru = 'Перечень баллонов'");
КомандаПечати.Обработчик    = "УправлениеПечатьюБПКлиент.ВыполнитьКомандуПечати";
КомандаПечати.СписокФорм    = "ФормаСписка,ФормаДокумента";
КомандаПечати.Порядок = 10;

// Разрешение на выпуск
КомандаПечати = КомандыПечати.Добавить();
КомандаПечати.Идентификатор = "РазрешениеНаВыпуск";
КомандаПечати.Представление = НСтр("ru = 'Разрешение на выпуск'");
КомандаПечати.Обработчик    = "УправлениеПечатьюБПКлиент.ВыполнитьКомандуПечати";
КомандаПечати.СписокФорм    = "ФормаСписка,ФормаДокумента";
КомандаПечати.Порядок = 10;

//// ПартияРБ
//КомандаПечати = КомандыПечати.Добавить();
//КомандаПечати.Идентификатор = "ПартияРБ";
//КомандаПечати.Представление = НСтр("ru = 'Партия РБ'");
//КомандаПечати.Обработчик    = "УправлениеПечатьюБПКлиент.ВыполнитьКомандуПечати";
//КомандаПечати.СписокФорм    = "ФормаСписка,ФормаДокумента";
//КомандаПечати.Порядок = 10;
//
//// ПартияПЗА
//КомандаПечати = КомандыПечати.Добавить();
//КомандаПечати.Идентификатор = "ПартияПЗА";
//КомандаПечати.Представление = НСтр("ru = 'Партия ПЗА'");
//КомандаПечати.Обработчик    = "УправлениеПечатьюБПКлиент.ВыполнитьКомандуПечати";
//КомандаПечати.СписокФорм    = "ФормаСписка,ФормаДокумента";
//КомандаПечати.Порядок = 10;


Если ПравоДоступа("Использование", Метаданные.Отчеты.РеестрДокументов) Тогда
	// Реестр документов
	КомандаПечати = КомандыПечати.Добавить();
	КомандаПечати.Идентификатор = "Реестр";
	КомандаПечати.Представление = НСтр("ru = 'Реестр документов'");
	КомандаПечати.ЗаголовокФормы= НСтр("ru = 'Реестр документов ""Реализация (акт, накладная)""'");
	КомандаПечати.Обработчик    = "УправлениеПечатьюБПКлиент.ВыполнитьКомандуПечатиРеестраДокументов";
	КомандаПечати.СписокФорм    = "ФормаСписка";
	КомандаПечати.ДополнительныеПараметры.Вставить("НеВыводитьВКомплекте",Истина);
	КомандаПечати.Порядок       = 160;
КонецЕсли;

КонецПроцедуры

