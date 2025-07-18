﻿&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если ЗначениеЗаполнено(параметры.ЗначениеКопирования) Тогда
		Отказ = истина;
		Возврат;		
	КонецЕсли; 
	
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	Если Параметры.Ключ.Пустая() Тогда
		Объект.Дата =ТекущаяДатаСеанса();		
	КонецЕсли;

КонецПроцедуры


&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	// Вставить содержимое обработчика.
	// СтандартныеПодсистемы.ДатыЗапретаИзменения
	ДатыЗапретаИзменения.ОбъектПриЧтенииНаСервере(ЭтаФорма, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.ДатыЗапретаИзменения
КонецПроцедуры
