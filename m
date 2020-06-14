Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F053C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 20:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 639A120739
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 20:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="xXw1bKKG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgFNULK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 16:11:10 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:54226 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbgFNULJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 16:11:09 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 1B1EB658;
        Sun, 14 Jun 2020 22:11:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1592165462; x=1593979863;
         bh=rqlrBXCc+ntKYDecZ7nicCLrzxfP8IIyJrpsG4xb3qM=; b=xXw1bKKGuiCO
        TsJgEgZerFqvQmKqfpxqe7glumou/07UrzM6mjUappI7tgpk6f6BQDdHzc7dvMZ9
        Sp4T//6JCSPolWdKDOl7M8Sw8ivKBB8H3vWaH2Ovl57dueJsOVbO/dptiw7JkZX4
        Jcfy/zLW6MBJQ63ykYB2+/8O40j8lHxggpmvWPh5J5tQNaX1N5qfND8O1uzGRbsZ
        P6P7VgpjQLHoPNYLz3mU/vDUx/j7a+pZR7hVb5Wl0iAIHx8dDCTgelsOcXjqNmiJ
        Xu2j5K7pHjkXn0Cmcy7iCSInnDwayacgSRg4bw4vLgPsh6XgU1xZ4drRY6z0XXVJ
        ks5FOc7QTh1CB82pSJ7FmRYe62r/Ua+ZYFG/Lx9JSpOoygyDiUH+xukI9EuNUWAo
        GzmjhR2JchaICLQ6BX0UqWFIdgYAmXOhm6v2QqDUahGW3O0VAFXt9Z4jkdp+mfuo
        ia6kZ4rLZm9AVvWYM4rXLFtShAwKhao9Egaj4A/L2RydTSa5xoOENtbLc2G1gN6u
        8U0ldm0F9+yuAo6BxJduHQkELimU+FRfB/Ym12MwJeF90NvFMt4JMTLfpxKB2iGV
        iyJw+o6uKw9sok9ec+Q8C0xcViicSrHPh1LRr8qArENC0rde5Ci/EVBE6kV910tl
        ls8/I88a2YIDVYlzdCLqQh7TZxKaoPA=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QaI-ZjrgDQli; Sun, 14 Jun 2020 22:11:02 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id DB0F4463;
        Sun, 14 Jun 2020 22:11:01 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 70F51235E;
        Sun, 14 Jun 2020 22:11:01 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH] doc:it_IT: add symbol-namespace translation
Date:   Sun, 14 Jun 2020 22:10:53 +0200
Message-Id: <20200614201053.59502-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- add complete translation of symbol-namespaces.rst
- fix references to this page within the italian translation
- add document to main indexes

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 .../translations/it_IT/core-api/index.rst     |  18 ++
 .../it_IT/core-api/symbol-namespaces.rst      | 166 ++++++++++++++++++
 Documentation/translations/it_IT/index.rst    |   5 +-
 .../it_IT/kernel-hacking/hacking.rst          |   4 +-
 4 files changed, 189 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/translations/it_IT/core-api/index.rst
 create mode 100644 Documentation/translations/it_IT/core-api/symbol-namespaces.rst

diff --git a/Documentation/translations/it_IT/core-api/index.rst b/Documentation/translations/it_IT/core-api/index.rst
new file mode 100644
index 000000000000..cc4c4328ad03
--- /dev/null
+++ b/Documentation/translations/it_IT/core-api/index.rst
@@ -0,0 +1,18 @@
+===============================
+Documentazione dell'API di base
+===============================
+
+Utilità di base
+===============
+
+.. toctree::
+   :maxdepth: 1
+
+   symbol-namespaces
+
+.. only:: subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/translations/it_IT/core-api/symbol-namespaces.rst b/Documentation/translations/it_IT/core-api/symbol-namespaces.rst
new file mode 100644
index 000000000000..aa851a57a4b0
--- /dev/null
+++ b/Documentation/translations/it_IT/core-api/symbol-namespaces.rst
@@ -0,0 +1,166 @@
+.. include:: ../disclaimer-ita.rst
+
+:Original: :doc:`../../../core-api/symbol-namespaces`
+:Translator: Federico Vaga <federico.vaga@vaga.pv.it>
+
+===========================
+Spazio dei nomi dei simboli
+===========================
+
+Questo documento descrive come usare lo spazio dei nomi dei simboli
+per strutturare quello che viene esportato internamente al kernel
+grazie alle macro della famiglia EXPORT_SYMBOL().
+
+1. Introduzione
+===============
+
+Lo spazio dei nomi dei simboli è stato introdotto come mezzo per strutturare
+l'API esposta internamente al kernel. Permette ai manutentori di un
+sottosistema di organizzare i simboli esportati in diversi spazi di
+nomi. Questo meccanismo è utile per la documentazione (pensate ad
+esempio allo spazio dei nomi SUBSYSTEM_DEBUG) così come per limitare
+la disponibilità di un gruppo di simboli in altre parti del kernel. Ad
+oggi, i moduli che usano simboli esportati da uno spazio di nomi
+devono prima importare detto spazio. Altrimenti il kernel, a seconda
+della configurazione, potrebbe rifiutare di caricare il modulo o
+avvisare l'utente di un'importazione mancante.
+
+2. Come definire uno spazio dei nomi dei simboli
+================================================
+
+I simboli possono essere esportati in spazi dei nomi usando diversi
+meccanismi.  Tutti questi meccanismi cambiano il modo in cui
+EXPORT_SYMBOL e simili vengono guidati verso la creazione di voci in ksymtab.
+
+2.1 Usare le macro EXPORT_SYMBOL
+================================
+
+In aggiunta alle macro EXPORT_SYMBOL() e EXPORT_SYMBOL_GPL(), che permettono
+di esportare simboli del kernel nella rispettiva tabella, ci sono
+varianti che permettono di esportare simboli all'interno di uno spazio dei
+nomi: EXPORT_SYMBOL_NS() ed EXPORT_SYMBOL_NS_GPL(). Queste macro richiedono un
+argomento aggiuntivo: lo spazio dei nomi.
+Tenete presente che per via dell'espansione delle macro questo argomento deve
+essere un simbolo di preprocessore. Per esempio per esportare il
+simbolo `usb_stor_suspend` nello spazio dei nomi `USB_STORAGE` usate::
+
+	EXPORT_SYMBOL_NS(usb_stor_suspend, USB_STORAGE);
+
+Di conseguenza, nella tabella dei simboli del kernel ci sarà una voce
+rappresentata dalla struttura `kernel_symbol` che avrà il campo
+`namespace` (spazio dei nomi) impostato. Un simbolo esportato senza uno spazio
+dei nomi avrà questo campo impostato a `NULL`. Non esiste uno spazio dei nomi
+di base. Il programma `modpost` e il codice in kernel/module.c usano lo spazio
+dei nomi, rispettivamente, durante la compilazione e durante il caricamento
+di un modulo.
+
+2.2 Usare il simbolo di preprocessore DEFAULT_SYMBOL_NAMESPACE
+==============================================================
+
+Definire lo spazio dei nomi per tutti i simboli di un sottosistema può essere
+logorante e di difficile manutenzione. Perciò è stato fornito un simbolo
+di preprocessore di base (DEFAULT_SYMBOL_NAMESPACE), che, se impostato,
+diventa lo spazio dei simboli di base per tutti gli usi di EXPORT_SYMBOL()
+ed EXPORT_SYMBOL_GPL() che non specificano esplicitamente uno spazio dei nomi.
+
+Ci sono molti modi per specificare questo simbolo di preprocessore e il loro
+uso dipende dalle preferenze del manutentore di un sottosistema. La prima
+possibilità è quella di definire il simbolo nel `Makefile` del sottosistema.
+Per esempio per esportare tutti i simboli definiti in usb-common nello spazio
+dei nomi USB_COMMON, si può aggiungere la seguente linea in
+drivers/usb/common/Makefile::
+
+	ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=USB_COMMON
+
+Questo cambierà tutte le macro EXPORT_SYMBOL() ed EXPORT_SYMBOL_GPL(). Invece,
+un simbolo esportato con EXPORT_SYMBOL_NS() non verrà cambiato e il simbolo
+verrà esportato nello spazio dei nomi indicato.
+
+Una seconda possibilità è quella di definire il simbolo di preprocessore
+direttamente nei file da compilare. L'esempio precedente diventerebbe::
+
+	#undef  DEFAULT_SYMBOL_NAMESPACE
+	#define DEFAULT_SYMBOL_NAMESPACE USB_COMMON
+
+Questo va messo prima di un qualsiasi uso di EXPORT_SYMBOL.
+
+3. Come usare i simboli esportati attraverso uno spazio dei nomi
+================================================================
+
+Per usare i simboli esportati da uno spazio dei nomi, i moduli del
+kernel devono esplicitamente importare il relativo spazio dei nomi; altrimenti
+il kernel potrebbe rifiutarsi di caricare il modulo. Il codice del
+modulo deve usare la macro MODULE_IMPORT_NS per importare lo spazio
+dei nomi che contiene i simboli desiderati. Per esempio un modulo che
+usa il simbolo usb_stor_suspend deve importare lo spazio dei nomi
+USB_STORAGE usando la seguente dichiarazione::
+
+	MODULE_IMPORT_NS(USB_STORAGE);
+
+Questo creerà un'etichetta `modinfo` per ogni spazio dei nomi
+importato. Un risvolto di questo fatto è che gli spazi dei
+nomi importati da un modulo possono essere ispezionati tramite
+modinfo::
+
+	$ modinfo drivers/usb/storage/ums-karma.ko
+	[...]
+	import_ns:      USB_STORAGE
+	[...]
+
+
+Si consiglia di posizionare la dichiarazione MODULE_IMPORT_NS() vicino
+ai metadati del modulo come MODULE_AUTHOR() o MODULE_LICENSE(). Fate
+riferimento alla sezione 5. per creare automaticamente le importazioni
+mancanti.
+
+4. Caricare moduli che usano simboli provenienti da spazi dei nomi
+==================================================================
+
+Quando un modulo viene caricato (per esempio usando `insmod`), il kernel
+verificherà la disponibilità di ogni simbolo usato e se lo spazio dei nomi
+che potrebbe contenerli è stato importato. Il comportamento di base del kernel
+è di rifiutarsi di caricare quei moduli che non importano tutti gli spazi dei
+nomi necessari. L'errore verrà annotato e il caricamento fallirà con l'errore
+EINVAL. Per caricare i moduli che non soddisfano questo requisito esiste
+un'opzione di configurazione: impostare
+MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=y caricherà i moduli comunque ma
+emetterà un avviso.
+
+5. Creare automaticamente la dichiarazione MODULE_IMPORT_NS
+===========================================================
+
+La mancanza di un'importazione può essere individuata facilmente al momento
+della compilazione. Infatti, modpost emetterà un avviso se il modulo usa
+un simbolo da uno spazio dei nomi che non è stato importato.
+La dichiarazione MODULE_IMPORT_NS() viene solitamente aggiunta in un posto
+ben definito (assieme agli altri metadati del modulo). Per facilitare
+la vita di chi scrive moduli (e i manutentori di sottosistemi), esistono uno
+script e un target make per correggere le importazioni mancanti. Questo può
+essere fatto con::
+
+	$ make nsdeps
+
+Lo scenario tipico di chi scrive un modulo potrebbe essere::
+
+	- scrivere codice che dipende da un simbolo appartenente ad uno spazio
+	  dei nomi non importato
+	- eseguire `make`
+	- aver notato un avviso da modpost che parla di un'importazione
+	  mancante
+	- eseguire `make nsdeps` per aggiungere import nel posto giusto
+
+Per i manutentori di sottosistemi che vogliono aggiungere uno spazio dei nomi,
+l'approccio è simile. Di nuovo, eseguendo `make nsdeps` aggiungerà le
+importazioni mancanti nei moduli inclusi nel kernel::
+
+	- spostare o aggiungere simboli ad uno spazio dei nomi (per esempio
+	  usando EXPORT_SYMBOL_NS())
+	- eseguire `make` (preferibilmente con allmodconfig per coprire tutti
+	  i moduli del kernel)
+	- aver notato un avviso da modpost che parla di un'importazione
+	  mancante
+	- eseguire `make nsdeps` per aggiungere import nel posto giusto
+
+Potete anche eseguire nsdeps per moduli esterni. Solitamente si usa così::
+
+       $ make -C <path_to_kernel_src> M=$PWD nsdeps
diff --git a/Documentation/translations/it_IT/index.rst b/Documentation/translations/it_IT/index.rst
index 409eaac03e9f..bb8fa7346939 100644
--- a/Documentation/translations/it_IT/index.rst
+++ b/Documentation/translations/it_IT/index.rst
@@ -121,9 +121,10 @@ file sorgenti, informazioni aggiuntive vengono aggiunte solo se necessarie
 (o almeno ci proviamo — probabilmente *non* tutto quello che è davvero
 necessario).
 
-.. warning::
+.. toctree::
+   :maxdepth: 2
 
-    TODO ancora da tradurre
+   core-api/index
 
 Documentazione specifica per architettura
 -----------------------------------------
diff --git a/Documentation/translations/it_IT/kernel-hacking/hacking.rst b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
index e9a2e92134f0..6aab27a8d323 100644
--- a/Documentation/translations/it_IT/kernel-hacking/hacking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
@@ -634,7 +634,7 @@ Definita in ``include/linux/export.h``
 
 Questa è una variate di `EXPORT_SYMBOL()` che permette di specificare uno
 spazio dei nomi. Lo spazio dei nomi è documentato in
-:doc:`../../../core-api/symbol-namespaces`
+:doc:`../core-api/symbol-namespaces`
 
 :c:func:`EXPORT_SYMBOL_NS_GPL()`
 --------------------------------
@@ -643,7 +643,7 @@ Definita in ``include/linux/export.h``
 
 Questa è una variate di `EXPORT_SYMBOL_GPL()` che permette di specificare uno
 spazio dei nomi. Lo spazio dei nomi è documentato in
-:doc:`../../../core-api/symbol-namespaces`
+:doc:`../core-api/symbol-namespaces`
 
 Procedure e convenzioni
 =======================
-- 
2.26.2

