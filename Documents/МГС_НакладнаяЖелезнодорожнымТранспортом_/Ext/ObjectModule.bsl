﻿
Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	// Вставить содержимое обработчика.
	ЗаполнениеДокументов.Заполнить(ЭтотОбъект, ДанныеЗаполнения);
	ОтгрузкаБаллонов = ДанныеЗаполнения;
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	// Вставить содержимое обработчика.
	
	Движения.МГС_БаллоныУКонтрагентов.Записывать = Истина;
	Если ЩитДеревянныйКоличество <> 0 Тогда
		Движение = Движения.МГС_БаллоныУКонтрагентов.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
		Движение.Период = Дата;
		Движение.Организация = Организация;
		Движение.ТипБаллона = Справочники.МГС_ТипыБаллонов.ЩитДеревянный;
		Движение.Контрагент = ОтгрузкаБаллонов.Контрагент;
		Движение.ДокументОтгрузки = Ссылка;
		Движение.Количество =ЩитДеревянныйКоличество ;			
	
	КонецЕсли; 

КонецПроцедуры


	