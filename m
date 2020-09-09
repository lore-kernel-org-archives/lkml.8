Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B17C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2B2120732
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbgIJCDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:03:51 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:61240 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729785AbgIJBn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 21:43:56 -0400
X-Greylist: delayed 11067 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Sep 2020 21:43:53 EDT
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 179975CB;
        Thu, 10 Sep 2020 00:39:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1599691162; x=1601505563;
         bh=0kHeBkrm0QCQX5yLoLl7ByLnT2cie7rlwYYNGJSbUFA=; b=p4ZXhzXgRXhY
        Nqed7LYCJuMZGma0fzM7lsRpUKshqmnWaFVCffgr8ZsIuEgnnv9y151nteCVI2nU
        OMpLzdew3x633JMGIGPI7Jv9uB3Wl696qqtWg73CQjXJyoQepVNNGpOxA8SSfuLW
        yE0uj0bxan1ehKuZYVfd6sRiFkISJ7kUTiQ6HXrhOGbbbpofe8B3mw4CTHZU7tgZ
        pDWs7pXAI7nPkYhxmJMrrX5Jn3c00H0TvAMAc5WJECbCz66gqbsbYzilzxVts+H1
        tSbODVTQdILH+GRemSiD0zfvbG2n8OosRI2SYMnOana8Db99VnLuM3YILtzP/KYQ
        8sxhtWK5dwrfXnTWJJZTyRn9kqm9gWjj5wX/mpIwYrwHe+Yhtvtq6MucMlhLfx4A
        UAcHYbHGIQiJd8mgL3sSrJhjnvaLT024L7A2UdYsmts7wEoHa0hadgmp5XTK+NYi
        sAh+wRPn3Vyi394nL96pc9P6J/u8ho83Jy5jyXw2kv/Trr0fbRM3xd6XugBwwL10
        lrN+x90flEV/uHpvp9Tc1lHTvVMEgJGJb62mT3T9sGIOXlPCvBv5Hte8H4/QgZ7o
        AIvAPHjBI1RAG9voWedCWaXO11RNXwT8COiKkvdzwnmgD2/63M4vCchipTXeGwdQ
        um6M11tn3nbKiPd8smVYRuK4VcQtqmM=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id t6FBjPI3exCi; Thu, 10 Sep 2020 00:39:22 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id D3A0B489;
        Thu, 10 Sep 2020 00:39:21 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 741CAAC2;
        Thu, 10 Sep 2020 00:39:21 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH] doc:it_IT: align Italian documentation
Date:   Thu, 10 Sep 2020 00:38:39 +0200
Message-Id: <20200909223839.9000-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translation for the following patches

commit 68e4cd17e218 ("docs: deprecated.rst: Add zero-length and one-element arrays")
commit 5429ef62bcf3 ("compiler/gcc: Raise minimum GCC version for kernel builds to 4.8")
commit 5b5bbb8cc51b ("docs: process: Add an example for creating a fixes tag")
commit 858e6845654d ("docs: dt: convert submitting-patches.txt to ReST format")
commit bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column warning")
commit cca73e4946c4 ("docs: Correct the release date of 5.2 stable")

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 .../translations/it_IT/process/2.Process.rst  |   2 +-
 .../translations/it_IT/process/changes.rst    |   2 +-
 .../it_IT/process/coding-style.rst            |  26 ++--
 .../translations/it_IT/process/deprecated.rst | 128 ++++++++++++++++++
 .../it_IT/process/submitting-patches.rst      |   7 +-
 5 files changed, 152 insertions(+), 13 deletions(-)

diff --git a/Documentation/translations/it_IT/process/2.Process.rst b/Documentation/translations/it_IT/process/2.Process.rst
index 30dc172f06b0..220248127285 100644
--- a/Documentation/translations/it_IT/process/2.Process.rst
+++ b/Documentation/translations/it_IT/process/2.Process.rst
@@ -123,7 +123,7 @@ iniziale, i kernel ricevono aggiornamenti per più di un ciclo di sviluppo.
 Quindi, per esempio, la storia del kernel 5.2 appare così (anno 2019):
 
 	==============  ===============================
-	15 settembre	5.2 rilascio stabile FIXME settembre è sbagliato
+	 7 luglio	5.2 rilascio stabile
 	14 luglio	5.2.1
 	21 luglio	5.2.2
 	26 luglio	5.2.3
diff --git a/Documentation/translations/it_IT/process/changes.rst b/Documentation/translations/it_IT/process/changes.rst
index 02da4408983d..3310d788fca3 100644
--- a/Documentation/translations/it_IT/process/changes.rst
+++ b/Documentation/translations/it_IT/process/changes.rst
@@ -32,7 +32,7 @@ PC Card, per esempio, probabilmente non dovreste preoccuparvi di pcmciautils.
 ====================== =================  ========================================
         Programma       Versione minima       Comando per verificare la versione
 ====================== =================  ========================================
-GNU C                  4.6                gcc --version
+GNU C                  4.8                gcc --version
 GNU make               3.81               make --version
 binutils               2.23               ld -v
 flex                   2.5.35             flex --version
diff --git a/Documentation/translations/it_IT/process/coding-style.rst b/Documentation/translations/it_IT/process/coding-style.rst
index 6f4f85832dee..e188692deefe 100644
--- a/Documentation/translations/it_IT/process/coding-style.rst
+++ b/Documentation/translations/it_IT/process/coding-style.rst
@@ -92,16 +92,22 @@ delle righe.
 Lo stile del codice riguarda la leggibilità e la manutenibilità utilizzando
 strumenti comuni.
 
-Il limite delle righe è di 80 colonne e questo e un limite fortemente
-desiderato.
-
-Espressioni più lunghe di 80 colonne saranno spezzettate in pezzi più piccoli,
-a meno che eccedere le 80 colonne non aiuti ad aumentare la leggibilità senza
-nascondere informazioni.  I pezzi derivati sono sostanzialmente più corti degli
-originali e vengono posizionati più a destra.  Lo stesso si applica, nei file
-d'intestazione, alle funzioni con una lista di argomenti molto lunga. Tuttavia,
-non spezzettate mai le stringhe visibili agli utenti come i messaggi di
-printk, questo perché inibireste la possibilità d'utilizzare grep per cercarle.
+Come limite di riga si preferiscono le 80 colonne.
+
+Espressioni più lunghe di 80 colonne dovrebbero essere spezzettate in
+pezzi più piccoli, a meno che eccedere le 80 colonne non aiuti ad
+aumentare la leggibilità senza nascondere informazioni.
+
+I nuovi pezzi derivati sono sostanzialmente più corti degli originali
+e vengono posizionati più a destra. Uno stile molto comune è quello di
+allineare i nuovi pezzi alla parentesi aperta di una funzione.
+
+Lo stesso si applica, nei file d'intestazione, alle funzioni con una
+lista di argomenti molto lunga.
+
+Tuttavia, non spezzettate mai le stringhe visibili agli utenti come i
+messaggi di printk, questo perché inibireste la possibilità
+d'utilizzare grep per cercarle.
 
 3) Posizionamento di parentesi graffe e spazi
 ---------------------------------------------
diff --git a/Documentation/translations/it_IT/process/deprecated.rst b/Documentation/translations/it_IT/process/deprecated.rst
index e108eaf82cf6..158a63d9f244 100644
--- a/Documentation/translations/it_IT/process/deprecated.rst
+++ b/Documentation/translations/it_IT/process/deprecated.rst
@@ -95,6 +95,11 @@ Invece, usate la seguente funzione::
 
 	header = kzalloc(struct_size(header, item, count), GFP_KERNEL);
 
+.. note:: Se per caso state usando struct_size() su una struttura dati che
+	  in coda contiene un array di lunghezza zero o uno, allora siete
+	  invitati a riorganizzare il vostro codice usando il
+	  `flexible array member <#zero-length-and-one-element-arrays>`_.
+
 Per maggiori dettagli fate riferimento a array_size(),
 array3_size(), e struct_size(), così come la famiglia di
 funzioni check_add_overflow() e check_mul_overflow().
@@ -227,3 +232,126 @@ modi:
 * ``continue;``
 * ``goto <label>;``
 * ``return [expression];``
+
+Array di lunghezza zero o con un solo elemento
+----------------------------------------------
+All'interno del kernel ricorre spesso la necessita di avere membri
+di dimensione variabile all'interno di una struttura dati. In questi
+casi il codice del kernel dovrebbe usare sempre i `"flexible array
+member" <https://en.wikipedia.org/wiki/Flexible_array_member>`_. La
+tecnica degli array a lunghezza nulla o di un solo elemento non
+dovrebbe essere più usata.
+
+Nel codice C più vecchio, la dichiarazione di un membro di dimensione
+variabile in coda ad una struttura dati veniva fatto dichiarando un
+array di un solo elemento posizionato alla fine della struttura dati::
+
+        struct something {
+                size_t count;
+                struct foo items[1];
+        };
+
+Questo ha portato ad un calcolo di sizeof() traballante (dovrebbe
+rimuovere la dimensione del singolo elemento in coda per calcolare la
+dimensione esatta dell' "intestazione"). Per evitare questi problemi è
+stata introdotta un' `estensione a GNU C
+<https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html>`_ che
+permettesse la dichiarazione di array a lungezza zero::
+
+        struct something {
+                size_t count;
+                struct foo items[0];
+        };
+
+Ma questo ha portato nuovi problemi, e non ha risolto alcuni dei
+problemi che affliggono entrambe le tecniche: per esempio
+l'impossibilità di riconoscere se un array di quel tipo viene usato
+nel mezzo di una struttura dati e _non_ alla fine (potrebbe accadere
+sia direttamente, sia indirettamente quando si usano le unioni o le
+strutture di strutture).
+
+Lo standard C99 introduce i "flexible array members". Questi array non
+hanno una dimensione nella loro dichiarazione::
+
+        struct something {
+                size_t count;
+                struct foo items[];
+        };
+
+Questo è il modo con cui ci si aspetta che vengano dichiarati gli
+elementi di lunghezza variabile in coda alle strutture dati.  Permette
+al compilatore di produrre errori quando gli array flessibili non si
+trovano alla fine della struttura dati, il che permette di prevenire
+alcuni tipi di bachi dovuti a `comportamenti inaspettati
+<https://git.kernel.org/linus/76497732932f15e7323dc805e8ea8dc11bb587cf>`_.
+Inoltre, permette al compilatore di analizzare correttamente le
+dimensioni degli array (attraverso sizeof(), `CONFIG_FORTIFY_SOURCE`,
+e `CONFIG_UBSAN_BOUNDS`). Per esempio, non esiste alcun meccanismo in
+grado di avvisarci che il seguente uso di sizeof() dia sempre come
+zero come risultato::
+
+        struct something {
+                size_t count;
+                struct foo items[0];
+        };
+
+        struct something *instance;
+
+        instance = kmalloc(struct_size(instance, items, count), GFP_KERNEL);
+        instance->count = count;
+
+        size = sizeof(instance->items) * instance->count;
+        memcpy(instance->items, source, size);
+
+Il valore di ``size`` nell'ultima riga sarà ``zero``, quando uno
+invece si aspetterebbe che il suo valore sia la dimensione totale in
+byte dell'allocazione dynamica che abbiamo appena fatto per l'array
+``items``. Qui un paio di esempi reali del problema: `collegamento 1
+<https://git.kernel.org/linus/f2cd32a443da694ac4e28fbf4ac6f9d5cc63a539>`_,
+`collegamento 2
+<https://git.kernel.org/linus/ab91c2a89f86be2898cee208d492816ec238b2cf>`_.
+Invece, `i flexible array members hanno un tipo incompleto, e quindi
+sizeof() non può essere applicato
+<https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html>`_; dunque ogni
+uso scorretto di questo operatore verrà identificato immediatamente
+durante la compilazione.
+
+Per quanto riguarda gli array di un solo elemento, bisogna essere
+consapevoli che `questi array occupano almeno quanto lo spazio di un
+singolo oggetti dello stesso tipo
+<https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html>`_, e quindi
+contribuiscono al calcolo della dimensione della struttura che li
+contiene. In questo caso è facile commettere errori quando si vuole
+calcolare la dimensione totale della memoria totale da allocare per
+una struttura dati::
+
+        struct something {
+                size_t count;
+                struct foo items[1];
+        };
+
+        struct something *instance;
+
+        instance = kmalloc(struct_size(instance, items, count - 1), GFP_KERNEL);
+        instance->count = count;
+
+        size = sizeof(instance->items) * instance->count;
+        memcpy(instance->items, source, size);
+
+In questo esempio ci siamo dovuti ricordare di usare ``count - 1`` in
+struct_size(), altrimenti avremmo --inavvertitamente-- allocato
+memoria per un oggetti ``items`` in più. Il modo più pulito e meno
+propenso agli errori è quello di usare i `flexible array member`::
+
+        struct something {
+                size_t count;
+                struct foo items[];
+        };
+
+        struct something *instance;
+
+        instance = kmalloc(struct_size(instance, items, count), GFP_KERNEL);
+        instance->count = count;
+
+        size = sizeof(instance->items[0]) * instance->count;
+        memcpy(instance->items, source, size);
diff --git a/Documentation/translations/it_IT/process/submitting-patches.rst b/Documentation/translations/it_IT/process/submitting-patches.rst
index cba1f8cb61ed..f0299c43ba35 100644
--- a/Documentation/translations/it_IT/process/submitting-patches.rst
+++ b/Documentation/translations/it_IT/process/submitting-patches.rst
@@ -21,7 +21,7 @@ Leggete anche :ref:`Documentation/translations/it_IT/process/submit-checklist.rs
 per una lista di punti da verificare prima di inviare del codice.  Se state
 inviando un driver, allora leggete anche :ref:`Documentation/translations/it_IT/process/submitting-drivers.rst <it_submittingdrivers>`;
 per delle patch relative alle associazioni per Device Tree leggete
-Documentation/devicetree/bindings/submitting-patches.txt.
+Documentation/devicetree/bindings/submitting-patches.rst.
 
 Molti di questi passi descrivono il comportamento di base del sistema di
 controllo di versione ``git``; se utilizzate ``git`` per preparare le vostre
@@ -208,6 +208,11 @@ precedente::
 	[pretty]
 		fixes = Fixes: %h (\"%s\")
 
+Un esempio::
+
+       $ git log -1 --pretty=fixes 54a4f0239f2e
+       Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")
+
 .. _it_split_changes:
 
 3) Separate le vostre modifiche
-- 
2.20.1

