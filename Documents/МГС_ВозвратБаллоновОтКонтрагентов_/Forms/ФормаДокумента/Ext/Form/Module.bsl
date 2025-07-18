﻿&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьДанныеВыбораПоБаллонам(Текст, Период) Экспорт
    
	спВыбора    =    Новый СписокЗначений;
	
	Текст = СтрЗаменить(Текст," ","");
	
	Запрос    =    Новый Запрос;
	Запрос.Текст    =    "ВЫБРАТЬ
	                     |	МГС_Баллоны.Ссылка КАК Ссылка,
	                     |	МГС_Баллоны.ВесТары КАК ВесТары
	                     |ПОМЕСТИТЬ Вт_Баллоны
	                     |ИЗ
	                     |	Справочник.МГС_Баллоны КАК МГС_Баллоны
	                     |ГДЕ
	                     |	МГС_Баллоны.Наименование ПОДОБНО &Наименование
	    //                 |	И МГС_Баллоны.ТипБаллона = &ТипБаллона
	                     |;
	                     |
	                     |////////////////////////////////////////////////////////////////////////////////
	                     |ВЫБРАТЬ
	                     |	МГС_АттестацияБаллоновСрезПоследних.ДатаСледующейАттестации КАК ДатаСледующейАттестации,
	                     |	Вт_Баллоны.Ссылка КАК Ссылка,
	                     |	Вт_Баллоны.Ссылка.Наименование КАК Наименование,
	                     |	Вт_Баллоны.ВесТары КАК ВесТары
	                     |ИЗ
	                     |	Вт_Баллоны КАК Вт_Баллоны
	                     |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.МГС_АттестацияБаллонов.СрезПоследних(
	                     |				&Период,
	                     |				Баллон В
	                     |					(ВЫБРАТЬ
	                     |						Вт_Баллоны.Ссылка
	                     |					ИЗ
	                     |						Вт_Баллоны КАК Вт_Баллоны)) КАК МГС_АттестацияБаллоновСрезПоследних
	                     |		ПО Вт_Баллоны.Ссылка = МГС_АттестацияБаллоновСрезПоследних.Баллон";
	                    
	Запрос.УстановитьПараметр("Период", Период);
	Запрос.УстановитьПараметр("Наименование", Текст);    
	//Запрос.УстановитьПараметр("ТипБаллона", ТипБаллона);   
	Выборка    =    Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл      
	    ПредставлениеБаллона    =    Выборка.Наименование+ " " +Выборка.ВесТары + " (" + Формат(Выборка.ДатаСледующейАттестации,"ДФ='MMMM yyyy'")  +")";	    
	    спВыбора.Добавить(Выборка.Ссылка, 
	                            ПредставлениеБаллона);    	
	КонецЦикла; 
	//спВыбора.Добавить(Текст,  "...ввести новый баллон...");    						
	Если спВыбора.Количество() = 0 Тогда
		спВыбора= Неопределено
	КонецЕсли;
    Возврат спВыбора;

КонецФункции // ПолучитьДанныеВыбораФИО()


&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
		Если ЗначениеЗаполнено(параметры.ЗначениеКопирования) Тогда
		Отказ = истина;
		Возврат;		
	КонецЕсли; 
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	//ОбновитьВидимостьЗакрытияОткрытияАнализа();
	//Вставить содержимое обработчика
КонецПроцедуры


//&НаСервере
//Процедура ОбновитьВидимостьЗакрытияОткрытияАнализа()
//	
//	// Вставить содержимое обработчика.
//	Если Объект.Проведен Тогда	
//		
//		Элементы.АнализОдобрен.Видимость = Ложь;
//		//ЭтаФорма.ТолькоПросмотр = Истина;
//		
//		Для каждого Элемент из ЭтаФорма.Элементы Цикл
//			Если Элемент. имя ="ГруппаСтандартныхКоманд"
//			Или Элемент. имя ="ОткрытьАнализ"
//			Или Элемент. имя ="КоманднаяПанельФормы"
//			Или Элемент. имя ="ФормаКоманднаяПанель"
//			Или СтрНайти(Элемент. имя,"Печат")>0
//			Или СтрНайти(Элемент. имя,"СоздатьНаОсновании")>0
//			или  ТипЗнч(Элемент) = Тип("ДекорацияФормы") Тогда
//				Продолжить;
//			КонецЕсли;
//			Элемент.Доступность=Ложь
//		КонецЦикла;
//		Элементы.ОткрытьАнализ.Видимость = Истина;
//		Элементы.ОткрытьАнализ.Доступность = Истина;
//	Иначе
//		Элементы.АнализОдобрен.Видимость = Истина;
//		Для каждого Элемент из ЭтаФорма.Элементы Цикл
//			Если ТипЗнч(Элемент) = Тип("ДекорацияФормы") Тогда
//				Продолжить;
//			КонецЕсли;
//			Элемент.Доступность=Истина
//		КонецЦикла;
//		Элементы.ОткрытьАнализ.Видимость = Ложь;
//		Элементы.ОткрытьАнализ.Доступность = Ложь;
//	КонецЕсли;
//КонецПроцедуры


&НаКлиенте
Процедура БаллоныБаллонОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, СтандартнаяОбработка)
	// Вставить содержимое обработчика.
	ДанныеВыбора = ПолучитьДанныеВыбораПоБаллонам(Текст, Объект.Дата); 
	СтандартнаяОбработка = Ложь;
КонецПроцедуры

&НаКлиенте
Процедура БаллоныБаллонИзменениеТекстаРедактирования(Элемент, Текст, СтандартнаяОбработка)
	// Вставить содержимое обработчика.
	СтандартнаяОбработка = Ложь
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьНаСервере()
	
	//НачалоПериода  =  НачалоДня(Объект.ДатаНачала-24*60*60);
	//ОкончаниеПериода =   КонецДня(Объект.ДатаОкончания);
	
	// Вставить содержимое обработчика.
	Объект.ДокументыОтгрузки.Очистить();
	
	
		//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	МГС_БаллоныУКонтрагентовОстатки.ТипБаллона КАК ТипБаллона,
//	|	МГС_БаллоныУКонтрагентовОстатки.ДокументОтгрузки КАК ДокументОтгрузки,
	|	МГС_БаллоныУКонтрагентовОстатки.КоличествоОстаток КАК КоличествоОстаток
	|ИЗ
	|	РегистрНакопления.МГС_БаллоныУКонтрагентов.Остатки(
	|			&Граница,
	|			Организация = &Организация
	|				И Контрагент = &Контрагент) КАК МГС_БаллоныУКонтрагентовОстатки";
	
		
	//Запрос.УстановитьПараметр("Граница", Новый Граница(Новый МоментВремени(объект.дата,объект.ссылка), ВидГраницы.Исключая));
	Запрос.УстановитьПараметр("Граница", объект.дата);
	Запрос.УстановитьПараметр("Контрагент", Объект.Контрагент);
	Запрос.УстановитьПараметр("Организация", Объект.Организация);

	РезультатЗапроса =  Запрос.Выполнить();	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.выбрать();
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		СтрокаДокументыОтгрузки= Объект.ДокументыОтгрузки.Добавить();
		//СтрокаДокументыОтгрузки.ДокументОтгрузки = ВыборкаДетальныеЗаписи.ДокументОтгрузки;
		СтрокаДокументыОтгрузки.ТипБаллона =  ВыборкаДетальныеЗаписи.ТипБаллона;
		СтрокаДокументыОтгрузки.Количество =  ВыборкаДетальныеЗаписи.КоличествоОстаток;
		
	КонецЦикла;
	

 КонецПроцедуры

&НаКлиенте
Процедура Заполнить(Команда)
	ЗаполнитьНаСервере();
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	// Вставить содержимое обработчика.
	// СтандартныеПодсистемы.ДатыЗапретаИзменения
	ДатыЗапретаИзменения.ОбъектПриЧтенииНаСервере(ЭтаФорма, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.ДатыЗапретаИзменения
КонецПроцедуры

//&НаСервереБезКонтекста
//Функция ПолучитьТипБаллонаПоНоменклатуре(ДокументОтгрузки)
//	// Вставить содержимое обработчика.
//	возврат документы.МГС_ОтгрузкаБаллонов.ПолучитьТипБаллонаПоНоменклатуре(ДокументОтгрузки.Номенклатура)
//КонецФункции


//&НаКлиенте
//Процедура ДокументыОтгрузкиДокументОтгрузкиПриИзменении(Элемент)
//	// Вставить содержимое обработчика.
//	ТекущиеДанные = Элементы.ДокументыОтгрузки.ТекущиеДанные;
//	ТекущиеДанные.ТипБаллона =ПолучитьТипБаллонаПоНоменклатуре(ТекущиеДанные.ДокументОтгрузки) 
//КонецПроцедуры



