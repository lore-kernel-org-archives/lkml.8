Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7C7C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 22:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C702205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 22:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="JdI7DyFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgD3WU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 18:20:56 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:4704 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgD3WUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 18:20:54 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 2FB91B66;
        Fri,  1 May 2020 00:20:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1588285242; x=1590099643;
         bh=sAF3Jr/+PGPSwdEjuNAgYj5Dn2CPz0W7C5Pt7XGYjrw=; b=JdI7DyFCIaNh
        azj/b6K4ba5lOGJ5pkyIivUvwG79vvSAbz99rVIjdQn7PWWwzG6QaWqLEwu08rJi
        UrBahpZ5dVJZqZRtW4Mai1FPz06cm5c12psxz1P+I9KLEuVGz8jGOvLM+PwTscdA
        aNKTI/JCllc+sxja7vD0+nTQxLENZfLWEilgvUO9QW7WkFqRn5DpOQgsk7uzgoM8
        13EQmH5VY8bfXWVZcA/Vw6P9SHiMbj+vDhnrD6cMK1wMhx/w9tR8lyQPmTpkRMoq
        89a+dvBCDlRwA9Wo+Tt2oRlAohFT6maINDHDR0GobuDn9ql1NH7WLgVzEw+Txpss
        zhG3tvUSZDH8HGivxs+nDWRzF4gIj24eXcCfkQeBjk5kE5/FN09NjFJT3WlUhX5f
        3P5ZJxz0m4fUOS6Sw/m0nmB0ovu99CgHw3ODBpF+UZG8epo54FqtOZ7gqAULCXG7
        ZJv9W/fQ2kk6m9bg1svADyvBNUH4uxPfLib3Mlb65U76kLp7pxC4HOlktmPdcKqx
        FKefJoFqKE/BRe7zt1+94JJEQiE1ULUl6TsXx17WaM7qvKr2Li6BMimcEAG/08M8
        XD8iKIor3auGns6K6Cmcj0g73/VVdOjJGS87SYeJu8CI+CFTZcKVj6Er3EFhtpxk
        3vjUQsUWf6gSwLkVLV/9VleaOFmky3Y=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tmThE8UJGCsM; Fri,  1 May 2020 00:20:42 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id F0FFEB3D;
        Fri,  1 May 2020 00:20:41 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 95F00D2B5;
        Fri,  1 May 2020 00:20:41 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH] doc:it_IT: align Italian translation
Date:   Fri,  1 May 2020 00:20:37 +0200
Message-Id: <20200430222037.4480-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translation for the following patches:

commit c4f4af4094d6 ("docs: Add documentation for Symbol Namespaces")
commit 36bc683dde0a ("kernel-doc: rename the kernel-doc directive 'functions' to 'identifiers'")
commit a035d552a93b ("Makefile: Globally enable fall-through warning")
commit b9918bdcac1f ("Documentation/process: Add fallthrough pseudo-keyword")
commit 58ad30cf91f0 ("docs: fix reference to core-api/namespaces.rst")
commit fb0e0ffe7fc8 ("Documentation: bring process docs up to date")
commit 7af51678b6d3 ("docs: deprecated.rst: Add BUG()-family")
commit 7929b9836ed0 ("docs: Remove :c:func: from process/deprecated.rst")
commit 76136e028d3b ("docs: deprecated.rst: Clean up fall-through details")
commit d8401f504b49 ("docs: deprecated.rst: Add %p to the list")
commit b1735296cef9 ("docs: locking: Drop :c:func: throughout")
commit 6adb7755996f ("docs: locking: Add 'need' to hardirq section")

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 .../it_IT/doc-guide/kernel-doc.rst            |  25 ++-
 .../it_IT/kernel-hacking/hacking.rst          |  18 ++
 .../it_IT/kernel-hacking/locking.rst          | 172 +++++++++---------
 .../translations/it_IT/process/2.Process.rst  |  95 +++++-----
 .../it_IT/process/coding-style.rst            |   6 +-
 .../translations/it_IT/process/deprecated.rst | 130 +++++++++++--
 6 files changed, 287 insertions(+), 159 deletions(-)

diff --git a/Documentation/translations/it_IT/doc-guide/kernel-doc.rst b/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
index a4ecd8f27631..524ad86cadbb 100644
--- a/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
+++ b/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
@@ -515,6 +515,22 @@ internal: *[source-pattern ...]*
     .. kernel-doc:: drivers/gpu/drm/i915/intel_audio.c
        :internal:
 
+identifiers: *[ function/type ...]*
+  Include la documentazione per ogni *function* e *type*  in *source*.
+  Se non vengono esplicitamente specificate le funzioni da includere, allora
+  verranno incluse tutte quelle disponibili in *source*.
+
+  Esempi::
+
+    .. kernel-doc:: lib/bitmap.c
+       :identifiers: bitmap_parselist bitmap_parselist_user
+
+    .. kernel-doc:: lib/idr.c
+       :identifiers:
+
+functions: *[ function ...]*
+  Questo è uno pseudonimo, deprecato, per la direttiva 'identifiers'.
+
 doc: *title*
   Include la documentazione del paragrafo ``DOC:`` identificato dal titolo
   (*title*) all'interno del file sorgente (*source*). Gli spazi in *title* sono
@@ -528,15 +544,6 @@ doc: *title*
     .. kernel-doc:: drivers/gpu/drm/i915/intel_audio.c
        :doc: High Definition Audio over HDMI and Display Port
 
-functions: *function* *[...]*
-  Dal file sorgente (*source*) include la documentazione per le funzioni
-  elencate (*function*).
-
-  Esempio::
-
-    .. kernel-doc:: lib/bitmap.c
-       :functions: bitmap_parselist bitmap_parselist_user
-
 Senza alcuna opzione, la direttiva kernel-doc include tutti i commenti di
 documentazione presenti nel file sorgente (*source*).
 
diff --git a/Documentation/translations/it_IT/kernel-hacking/hacking.rst b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
index 24c592852bf1..6aab27a8d323 100644
--- a/Documentation/translations/it_IT/kernel-hacking/hacking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
@@ -627,6 +627,24 @@ Alcuni manutentori e sviluppatori potrebbero comunque richiedere
 :c:func:`EXPORT_SYMBOL_GPL()` quando si aggiungono nuove funzionalità o
 interfacce.
 
+:c:func:`EXPORT_SYMBOL_NS()`
+----------------------------
+
+Definita in ``include/linux/export.h``
+
+Questa è una variate di `EXPORT_SYMBOL()` che permette di specificare uno
+spazio dei nomi. Lo spazio dei nomi è documentato in
+:doc:`../core-api/symbol-namespaces`
+
+:c:func:`EXPORT_SYMBOL_NS_GPL()`
+--------------------------------
+
+Definita in ``include/linux/export.h``
+
+Questa è una variate di `EXPORT_SYMBOL_GPL()` che permette di specificare uno
+spazio dei nomi. Lo spazio dei nomi è documentato in
+:doc:`../core-api/symbol-namespaces`
+
 Procedure e convenzioni
 =======================
 
diff --git a/Documentation/translations/it_IT/kernel-hacking/locking.rst b/Documentation/translations/it_IT/kernel-hacking/locking.rst
index b9a6be4b8499..4615df5723fb 100644
--- a/Documentation/translations/it_IT/kernel-hacking/locking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/locking.rst
@@ -159,17 +159,17 @@ Sincronizzazione in contesto utente
 Se avete una struttura dati che verrà utilizzata solo dal contesto utente,
 allora, per proteggerla, potete utilizzare un semplice mutex
 (``include/linux/mutex.h``). Questo è il caso più semplice: inizializzate il
-mutex; invocate :c:func:`mutex_lock_interruptible()` per trattenerlo e
-:c:func:`mutex_unlock()` per rilasciarlo. C'è anche :c:func:`mutex_lock()`
+mutex; invocate mutex_lock_interruptible() per trattenerlo e
+mutex_unlock() per rilasciarlo. C'è anche mutex_lock()
 ma questa dovrebbe essere evitata perché non ritorna in caso di segnali.
 
 Per esempio: ``net/netfilter/nf_sockopt.c`` permette la registrazione
-di nuove chiamate per :c:func:`setsockopt()` e :c:func:`getsockopt()`
-usando la funzione :c:func:`nf_register_sockopt()`. La registrazione e
+di nuove chiamate per setsockopt() e getsockopt()
+usando la funzione nf_register_sockopt(). La registrazione e
 la rimozione vengono eseguite solamente quando il modulo viene caricato
 o scaricato (e durante l'avvio del sistema, qui non abbiamo concorrenza),
 e la lista delle funzioni registrate viene consultata solamente quando
-:c:func:`setsockopt()` o :c:func:`getsockopt()` sono sconosciute al sistema.
+setsockopt() o getsockopt() sono sconosciute al sistema.
 In questo caso ``nf_sockopt_mutex`` è perfetto allo scopo, in particolar modo
 visto che setsockopt e getsockopt potrebbero dormire.
 
@@ -179,19 +179,19 @@ Sincronizzazione fra il contesto utente e i softirq
 Se un softirq condivide dati col contesto utente, avete due problemi.
 Primo, il contesto utente corrente potrebbe essere interroto da un softirq,
 e secondo, la sezione critica potrebbe essere eseguita da un altro
-processore. Questo è quando :c:func:`spin_lock_bh()`
+processore. Questo è quando spin_lock_bh()
 (``include/linux/spinlock.h``) viene utilizzato. Questo disabilita i softirq
-sul processore e trattiene il *lock*. Invece, :c:func:`spin_unlock_bh()` fa
+sul processore e trattiene il *lock*. Invece, spin_unlock_bh() fa
 l'opposto. (Il suffisso '_bh' è un residuo storico che fa riferimento al
 "Bottom Halves", il vecchio nome delle interruzioni software. In un mondo
 perfetto questa funzione si chiamerebbe 'spin_lock_softirq()').
 
-Da notare che in questo caso potete utilizzare anche :c:func:`spin_lock_irq()`
-o :c:func:`spin_lock_irqsave()`, queste fermano anche le interruzioni hardware:
+Da notare che in questo caso potete utilizzare anche spin_lock_irq()
+o spin_lock_irqsave(), queste fermano anche le interruzioni hardware:
 vedere :ref:`Contesto di interruzione hardware <it_hardirq-context>`.
 
 Questo funziona alla perfezione anche sui sistemi monoprocessore: gli spinlock
-svaniscono e questa macro diventa semplicemente :c:func:`local_bh_disable()`
+svaniscono e questa macro diventa semplicemente local_bh_disable()
 (``include/linux/interrupt.h``), la quale impedisce ai softirq d'essere
 eseguiti.
 
@@ -224,8 +224,8 @@ Differenti tasklet/timer
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
 Se un altro tasklet/timer vuole condividere dati col vostro tasklet o timer,
-allora avrete bisogno entrambe di :c:func:`spin_lock()` e
-:c:func:`spin_unlock()`. Qui :c:func:`spin_lock_bh()` è inutile, siete già
+allora avrete bisogno entrambe di spin_lock() e
+spin_unlock(). Qui spin_lock_bh() è inutile, siete già
 in un tasklet ed avete la garanzia che nessun altro verrà eseguito sullo
 stesso processore.
 
@@ -243,13 +243,13 @@ processore (vedere :ref:`Dati per processore <it_per-cpu>`). Se siete arrivati
 fino a questo punto nell'uso dei softirq, probabilmente tenete alla scalabilità
 delle prestazioni abbastanza da giustificarne la complessità aggiuntiva.
 
-Dovete utilizzare :c:func:`spin_lock()` e :c:func:`spin_unlock()` per
+Dovete utilizzare spin_lock() e spin_unlock() per
 proteggere i dati condivisi.
 
 Diversi Softirqs
 ~~~~~~~~~~~~~~~~
 
-Dovete utilizzare :c:func:`spin_lock()` e :c:func:`spin_unlock()` per
+Dovete utilizzare spin_lock() e spin_unlock() per
 proteggere i dati condivisi, che siano timer, tasklet, diversi softirq o
 lo stesso o altri softirq: uno qualsiasi di essi potrebbe essere in esecuzione
 su un diverso processore.
@@ -270,40 +270,40 @@ Se un gestore di interruzioni hardware condivide dati con un softirq, allora
 avrete due preoccupazioni. Primo, il softirq può essere interrotto da
 un'interruzione hardware, e secondo, la sezione critica potrebbe essere
 eseguita da un'interruzione hardware su un processore diverso. Questo è il caso
-dove :c:func:`spin_lock_irq()` viene utilizzato. Disabilita le interruzioni
-sul processore che l'esegue, poi trattiene il lock. :c:func:`spin_unlock_irq()`
+dove spin_lock_irq() viene utilizzato. Disabilita le interruzioni
+sul processore che l'esegue, poi trattiene il lock. spin_unlock_irq()
 fa l'opposto.
 
-Il gestore d'interruzione hardware non usa :c:func:`spin_lock_irq()` perché
-i softirq non possono essere eseguiti quando il gestore d'interruzione hardware
-è in esecuzione: per questo si può usare :c:func:`spin_lock()`, che è un po'
+Il gestore d'interruzione hardware non ha bisogno di usare spin_lock_irq()
+perché i softirq non possono essere eseguiti quando il gestore d'interruzione
+hardware è in esecuzione: per questo si può usare spin_lock(), che è un po'
 più veloce. L'unica eccezione è quando un altro gestore d'interruzioni
-hardware utilizza lo stesso *lock*: :c:func:`spin_lock_irq()` impedirà a questo
+hardware utilizza lo stesso *lock*: spin_lock_irq() impedirà a questo
 secondo gestore di interrompere quello in esecuzione.
 
 Questo funziona alla perfezione anche sui sistemi monoprocessore: gli spinlock
-svaniscono e questa macro diventa semplicemente :c:func:`local_irq_disable()`
+svaniscono e questa macro diventa semplicemente local_irq_disable()
 (``include/asm/smp.h``), la quale impedisce a softirq/tasklet/BH d'essere
 eseguiti.
 
-:c:func:`spin_lock_irqsave()` (``include/linux/spinlock.h``) è una variante che
+spin_lock_irqsave() (``include/linux/spinlock.h``) è una variante che
 salva lo stato delle interruzioni in una variabile, questa verrà poi passata
-a :c:func:`spin_unlock_irqrestore()`. Questo significa che lo stesso codice
+a spin_unlock_irqrestore(). Questo significa che lo stesso codice
 potrà essere utilizzato in un'interruzione hardware (dove le interruzioni sono
 già disabilitate) e in un softirq (dove la disabilitazione delle interruzioni
 è richiesta).
 
 Da notare che i softirq (e quindi tasklet e timer) sono eseguiti al ritorno
-da un'interruzione hardware, quindi :c:func:`spin_lock_irq()` interrompe
+da un'interruzione hardware, quindi spin_lock_irq() interrompe
 anche questi. Tenuto conto di questo si può dire che
-:c:func:`spin_lock_irqsave()` è la funzione di sincronizzazione più generica
+spin_lock_irqsave() è la funzione di sincronizzazione più generica
 e potente.
 
 Sincronizzazione fra due gestori d'interruzioni hardware
 --------------------------------------------------------
 
 Condividere dati fra due gestori di interruzione hardware è molto raro, ma se
-succede, dovreste usare :c:func:`spin_lock_irqsave()`: è una specificità
+succede, dovreste usare spin_lock_irqsave(): è una specificità
 dell'architettura il fatto che tutte le interruzioni vengano interrotte
 quando si eseguono di gestori di interruzioni.
 
@@ -317,11 +317,11 @@ Pete Zaitcev ci offre il seguente riassunto:
    il mutex e dormire (``copy_from_user*(`` o ``kmalloc(x,GFP_KERNEL)``).
 
 -  Altrimenti (== i dati possono essere manipolati da un'interruzione) usate
-   :c:func:`spin_lock_irqsave()` e :c:func:`spin_unlock_irqrestore()`.
+   spin_lock_irqsave() e spin_unlock_irqrestore().
 
 -  Evitate di trattenere uno spinlock per più di 5 righe di codice incluse
    le chiamate a funzione (ad eccezione di quell per l'accesso come
-   :c:func:`readb()`).
+   readb()).
 
 Tabella dei requisiti minimi
 ----------------------------
@@ -334,7 +334,7 @@ processore alla volta, ma se deve condividere dati con un altro thread, allora
 la sincronizzazione è necessaria).
 
 Ricordatevi il suggerimento qui sopra: potete sempre usare
-:c:func:`spin_lock_irqsave()`, che è un sovrainsieme di tutte le altre funzioni
+spin_lock_irqsave(), che è un sovrainsieme di tutte le altre funzioni
 per spinlock.
 
 ============== ============= ============= ========= ========= ========= ========= ======= ======= ============== ==============
@@ -378,13 +378,13 @@ protetti dal *lock* quando qualche altro thread lo sta già facendo
 trattenendo il *lock*. Potrete acquisire il *lock* più tardi se vi
 serve accedere ai dati protetti da questo *lock*.
 
-La funzione :c:func:`spin_trylock()` non ritenta di acquisire il *lock*,
+La funzione spin_trylock() non ritenta di acquisire il *lock*,
 se ci riesce al primo colpo ritorna un valore diverso da zero, altrimenti
 se fallisce ritorna 0. Questa funzione può essere utilizzata in un qualunque
-contesto, ma come :c:func:`spin_lock()`: dovete disabilitare i contesti che
+contesto, ma come spin_lock(): dovete disabilitare i contesti che
 potrebbero interrompervi e quindi trattenere lo spinlock.
 
-La funzione :c:func:`mutex_trylock()` invece di sospendere il vostro processo
+La funzione mutex_trylock() invece di sospendere il vostro processo
 ritorna un valore diverso da zero se è possibile trattenere il lock al primo
 colpo, altrimenti se fallisce ritorna 0. Nonostante non dorma, questa funzione
 non può essere usata in modo sicuro in contesti di interruzione hardware o
@@ -506,7 +506,7 @@ della memoria che il suo contenuto sono protetti dal *lock*. Questo
 caso è semplice dato che copiamo i dati dall'utente e non permettiamo
 mai loro di accedere direttamente agli oggetti.
 
-C'è una piccola ottimizzazione qui: nella funzione :c:func:`cache_add()`
+C'è una piccola ottimizzazione qui: nella funzione cache_add()
 impostiamo i campi dell'oggetto prima di acquisire il *lock*. Questo è
 sicuro perché nessun altro potrà accedervi finché non lo inseriremo
 nella memoria.
@@ -514,7 +514,7 @@ nella memoria.
 Accesso dal contesto utente
 ---------------------------
 
-Ora consideriamo il caso in cui :c:func:`cache_find()` può essere invocata
+Ora consideriamo il caso in cui cache_find() può essere invocata
 dal contesto d'interruzione: sia hardware che software. Un esempio potrebbe
 essere un timer che elimina oggetti dalla memoria.
 
@@ -583,15 +583,15 @@ sono quelle rimosse, mentre quelle ``+`` sono quelle aggiunte.
              return ret;
      }
 
-Da notare che :c:func:`spin_lock_irqsave()` disabiliterà le interruzioni
+Da notare che spin_lock_irqsave() disabiliterà le interruzioni
 se erano attive, altrimenti non farà niente (quando siamo già in un contesto
 d'interruzione); dunque queste funzioni possono essere chiamante in
 sicurezza da qualsiasi contesto.
 
-Sfortunatamente, :c:func:`cache_add()` invoca :c:func:`kmalloc()` con
+Sfortunatamente, cache_add() invoca kmalloc() con
 l'opzione ``GFP_KERNEL`` che è permessa solo in contesto utente. Ho supposto
-che :c:func:`cache_add()` venga chiamata dal contesto utente, altrimenti
-questa opzione deve diventare un parametro di :c:func:`cache_add()`.
+che cache_add() venga chiamata dal contesto utente, altrimenti
+questa opzione deve diventare un parametro di cache_add().
 
 Esporre gli oggetti al di fuori del file
 ----------------------------------------
@@ -610,7 +610,7 @@ Il secondo problema è il problema del ciclo di vita: se un'altra struttura
 mantiene un puntatore ad un oggetto, presumibilmente si aspetta che questo
 puntatore rimanga valido. Sfortunatamente, questo è garantito solo mentre
 si trattiene il *lock*, altrimenti qualcuno potrebbe chiamare
-:c:func:`cache_delete()` o peggio, aggiungere un oggetto che riutilizza lo
+cache_delete() o peggio, aggiungere un oggetto che riutilizza lo
 stesso indirizzo.
 
 Dato che c'è un solo *lock*, non potete trattenerlo a vita: altrimenti
@@ -710,9 +710,9 @@ Ecco il codice::
      }
 
 Abbiamo incapsulato il contatore di riferimenti nelle tipiche funzioni
-di 'get' e 'put'. Ora possiamo ritornare l'oggetto da :c:func:`cache_find()`
+di 'get' e 'put'. Ora possiamo ritornare l'oggetto da cache_find()
 col vantaggio che l'utente può dormire trattenendo l'oggetto (per esempio,
-:c:func:`copy_to_user()` per copiare il nome verso lo spazio utente).
+copy_to_user() per copiare il nome verso lo spazio utente).
 
 Un altro punto da notare è che ho detto che il contatore dovrebbe incrementarsi
 per ogni puntatore ad un oggetto: quindi il contatore di riferimenti è 1
@@ -727,8 +727,8 @@ Ci sono un certo numbero di operazioni atomiche definite
 in ``include/asm/atomic.h``: queste sono garantite come atomiche su qualsiasi
 processore del sistema, quindi non sono necessari i *lock*. In questo caso è
 più semplice rispetto all'uso degli spinlock, benché l'uso degli spinlock
-sia più elegante per casi non banali. Le funzioni :c:func:`atomic_inc()` e
-:c:func:`atomic_dec_and_test()` vengono usate al posto dei tipici operatori di
+sia più elegante per casi non banali. Le funzioni atomic_inc() e
+atomic_dec_and_test() vengono usate al posto dei tipici operatori di
 incremento e decremento, e i *lock* non sono più necessari per proteggere il
 contatore stesso.
 
@@ -820,7 +820,7 @@ al nome di cambiare abbiamo tre possibilità:
 -  Si può togliere static da ``cache_lock`` e dire agli utenti che devono
    trattenere il *lock* prima di modificare il nome di un oggetto.
 
--  Si può fornire una funzione :c:func:`cache_obj_rename()` che prende il
+-  Si può fornire una funzione cache_obj_rename() che prende il
    *lock* e cambia il nome per conto del chiamante; si dirà poi agli utenti
    di usare questa funzione.
 
@@ -878,11 +878,11 @@ Da notare che ho deciso che il contatore di popolarità dovesse essere
 protetto da ``cache_lock`` piuttosto che dal *lock* dell'oggetto; questo
 perché è logicamente parte dell'infrastruttura (come
 :c:type:`struct list_head <list_head>` nell'oggetto). In questo modo,
-in :c:func:`__cache_add()`, non ho bisogno di trattenere il *lock* di ogni
+in __cache_add(), non ho bisogno di trattenere il *lock* di ogni
 oggetto mentre si cerca il meno popolare.
 
 Ho anche deciso che il campo id è immutabile, quindi non ho bisogno di
-trattenere il lock dell'oggetto quando si usa :c:func:`__cache_find()`
+trattenere il lock dell'oggetto quando si usa __cache_find()
 per leggere questo campo; il *lock* dell'oggetto è usato solo dal chiamante
 che vuole leggere o scrivere il campo name.
 
@@ -907,7 +907,7 @@ Questo è facile da diagnosticare: non è uno di quei problemi che ti tengono
 sveglio 5 notti a parlare da solo.
 
 Un caso un pochino più complesso; immaginate d'avere una spazio condiviso
-fra un softirq ed il contesto utente. Se usate :c:func:`spin_lock()` per
+fra un softirq ed il contesto utente. Se usate spin_lock() per
 proteggerlo, il contesto utente potrebbe essere interrotto da un softirq
 mentre trattiene il lock, da qui il softirq rimarrà in attesa attiva provando
 ad acquisire il *lock* già trattenuto nel contesto utente.
@@ -1006,12 +1006,12 @@ potreste fare come segue::
             spin_unlock_bh(&list_lock);
 
 Primo o poi, questo esploderà su un sistema multiprocessore perché un
-temporizzatore potrebbe essere già partiro prima di :c:func:`spin_lock_bh()`,
-e prenderà il *lock* solo dopo :c:func:`spin_unlock_bh()`, e cercherà
+temporizzatore potrebbe essere già partiro prima di spin_lock_bh(),
+e prenderà il *lock* solo dopo spin_unlock_bh(), e cercherà
 di eliminare il suo oggetto (che però è già stato eliminato).
 
 Questo può essere evitato controllando il valore di ritorno di
-:c:func:`del_timer()`: se ritorna 1, il temporizzatore è stato già
+del_timer(): se ritorna 1, il temporizzatore è stato già
 rimosso. Se 0, significa (in questo caso) che il temporizzatore è in
 esecuzione, quindi possiamo fare come segue::
 
@@ -1032,9 +1032,9 @@ esecuzione, quindi possiamo fare come segue::
                     spin_unlock_bh(&list_lock);
 
 Un altro problema è l'eliminazione dei temporizzatori che si riavviano
-da soli (chiamando :c:func:`add_timer()` alla fine della loro esecuzione).
+da soli (chiamando add_timer() alla fine della loro esecuzione).
 Dato che questo è un problema abbastanza comune con una propensione
-alle corse critiche, dovreste usare :c:func:`del_timer_sync()`
+alle corse critiche, dovreste usare del_timer_sync()
 (``include/linux/timer.h``) per gestire questo caso. Questa ritorna il
 numero di volte che il temporizzatore è stato interrotto prima che
 fosse in grado di fermarlo senza che si riavviasse.
@@ -1116,7 +1116,7 @@ chiamata ``list``::
             wmb();
             list->next = new;
 
-La funzione :c:func:`wmb()` è una barriera di sincronizzazione delle
+La funzione wmb() è una barriera di sincronizzazione delle
 scritture. Questa garantisce che la prima operazione (impostare l'elemento
 ``next`` del nuovo elemento) venga completata e vista da tutti i processori
 prima che venga eseguita la seconda operazione (che sarebbe quella di mettere
@@ -1127,7 +1127,7 @@ completamente il nuovo elemento; oppure che lo vedano correttamente e quindi
 il puntatore ``next`` deve puntare al resto della lista.
 
 Fortunatamente, c'è una funzione che fa questa operazione sulle liste
-:c:type:`struct list_head <list_head>`: :c:func:`list_add_rcu()`
+:c:type:`struct list_head <list_head>`: list_add_rcu()
 (``include/linux/list.h``).
 
 Rimuovere un elemento dalla lista è anche più facile: sostituiamo il puntatore
@@ -1138,7 +1138,7 @@ l'elemento o lo salteranno.
 
             list->next = old->next;
 
-La funzione :c:func:`list_del_rcu()` (``include/linux/list.h``) fa esattamente
+La funzione list_del_rcu() (``include/linux/list.h``) fa esattamente
 questo (la versione normale corrompe il vecchio oggetto, e non vogliamo che
 accada).
 
@@ -1146,9 +1146,9 @@ Anche i lettori devono stare attenti: alcuni processori potrebbero leggere
 attraverso il puntatore ``next`` il contenuto dell'elemento successivo
 troppo presto, ma non accorgersi che il contenuto caricato è sbagliato quando
 il puntatore ``next`` viene modificato alla loro spalle. Ancora una volta
-c'è una funzione che viene in vostro aiuto :c:func:`list_for_each_entry_rcu()`
+c'è una funzione che viene in vostro aiuto list_for_each_entry_rcu()
 (``include/linux/list.h``). Ovviamente, gli scrittori possono usare
-:c:func:`list_for_each_entry()` dato che non ci possono essere due scrittori
+list_for_each_entry() dato che non ci possono essere due scrittori
 in contemporanea.
 
 Il nostro ultimo dilemma è il seguente: quando possiamo realmente distruggere
@@ -1156,15 +1156,15 @@ l'elemento rimosso? Ricordate, un lettore potrebbe aver avuto accesso a questo
 elemento proprio ora: se eliminiamo questo elemento ed il puntatore ``next``
 cambia, il lettore salterà direttamente nella spazzatura e scoppierà. Dobbiamo
 aspettare finché tutti i lettori che stanno attraversando la lista abbiano
-finito. Utilizziamo :c:func:`call_rcu()` per registrare una funzione di
+finito. Utilizziamo call_rcu() per registrare una funzione di
 richiamo che distrugga l'oggetto quando tutti i lettori correnti hanno
 terminato. In alternative, potrebbe essere usata la funzione
-:c:func:`synchronize_rcu()` che blocca l'esecuzione finché tutti i lettori
+synchronize_rcu() che blocca l'esecuzione finché tutti i lettori
 non terminano di ispezionare la lista.
 
 Ma come fa l'RCU a sapere quando i lettori sono finiti? Il meccanismo è
 il seguente: innanzi tutto i lettori accedono alla lista solo fra la coppia
-:c:func:`rcu_read_lock()`/:c:func:`rcu_read_unlock()` che disabilita la
+rcu_read_lock()/rcu_read_unlock() che disabilita la
 prelazione così che i lettori non vengano sospesi mentre stanno leggendo
 la lista.
 
@@ -1253,12 +1253,12 @@ codice RCU è un po' più ottimizzato di così, ma questa è l'idea di fondo.
      }
 
 Da notare che i lettori modificano il campo popularity nella funzione
-:c:func:`__cache_find()`, e ora non trattiene alcun *lock*. Una soluzione
+__cache_find(), e ora non trattiene alcun *lock*. Una soluzione
 potrebbe essere quella di rendere la variabile ``atomic_t``, ma per l'uso
 che ne abbiamo fatto qui, non ci interessano queste corse critiche perché un
 risultato approssimativo è comunque accettabile, quindi non l'ho cambiato.
 
-Il risultato è che la funzione :c:func:`cache_find()` non ha bisogno di alcuna
+Il risultato è che la funzione cache_find() non ha bisogno di alcuna
 sincronizzazione con le altre funzioni, quindi è veloce su un sistema
 multi-processore tanto quanto lo sarebbe su un sistema mono-processore.
 
@@ -1271,9 +1271,9 @@ riferimenti.
 
 Ora, dato che il '*lock* di lettura' di un RCU non fa altro che disabilitare
 la prelazione, un chiamante che ha sempre la prelazione disabilitata fra le
-chiamate :c:func:`cache_find()` e :c:func:`object_put()` non necessita
+chiamate cache_find() e object_put() non necessita
 di incrementare e decrementare il contatore di riferimenti. Potremmo
-esporre la funzione :c:func:`__cache_find()` dichiarandola non-static,
+esporre la funzione __cache_find() dichiarandola non-static,
 e quel chiamante potrebbe usare direttamente questa funzione.
 
 Il beneficio qui sta nel fatto che il contatore di riferimenti no
@@ -1293,10 +1293,10 @@ singolo contatore. Facile e pulito.
 Se questo dovesse essere troppo lento (solitamente non lo è, ma se avete
 dimostrato che lo è devvero), potreste usare un contatore per ogni processore
 e quindi non sarebbe più necessaria la mutua esclusione. Vedere
-:c:func:`DEFINE_PER_CPU()`, :c:func:`get_cpu_var()` e :c:func:`put_cpu_var()`
+DEFINE_PER_CPU(), get_cpu_var() e put_cpu_var()
 (``include/linux/percpu.h``).
 
-Il tipo di dato ``local_t``, la funzione :c:func:`cpu_local_inc()` e tutte
+Il tipo di dato ``local_t``, la funzione cpu_local_inc() e tutte
 le altre funzioni associate, sono di particolare utilità per semplici contatori
 per-processore; su alcune architetture sono anche più efficienti
 (``include/asm/local.h``).
@@ -1324,11 +1324,11 @@ da un'interruzione software. Il gestore d'interruzione non utilizza alcun
         enable_irq(irq);
         spin_unlock(&lock);
 
-La funzione :c:func:`disable_irq()` impedisce al gestore d'interruzioni
+La funzione disable_irq() impedisce al gestore d'interruzioni
 d'essere eseguito (e aspetta che finisca nel caso fosse in esecuzione su
 un altro processore). Lo spinlock, invece, previene accessi simultanei.
 Naturalmente, questo è più lento della semplice chiamata
-:c:func:`spin_lock_irq()`, quindi ha senso solo se questo genere di accesso
+spin_lock_irq(), quindi ha senso solo se questo genere di accesso
 è estremamente raro.
 
 .. _`it_sleeping-things`:
@@ -1336,7 +1336,7 @@ Naturalmente, questo è più lento della semplice chiamata
 Quali funzioni possono essere chiamate in modo sicuro dalle interruzioni?
 =========================================================================
 
-Molte funzioni del kernel dormono (in sostanza, chiamano ``schedule()``)
+Molte funzioni del kernel dormono (in sostanza, chiamano schedule())
 direttamente od indirettamente: non potete chiamarle se trattenere uno
 spinlock o avete la prelazione disabilitata, mai. Questo significa che
 dovete necessariamente essere nel contesto utente: chiamarle da un
@@ -1354,23 +1354,23 @@ dormire.
 
 -  Accessi allo spazio utente:
 
-   -  :c:func:`copy_from_user()`
+   -  copy_from_user()
 
-   -  :c:func:`copy_to_user()`
+   -  copy_to_user()
 
-   -  :c:func:`get_user()`
+   -  get_user()
 
-   -  :c:func:`put_user()`
+   -  put_user()
 
--  :c:func:`kmalloc(GFP_KERNEL) <kmalloc>`
+-  kmalloc(GFP_KERNEL) <kmalloc>`
 
--  :c:func:`mutex_lock_interruptible()` and
-   :c:func:`mutex_lock()`
+-  mutex_lock_interruptible() and
+   mutex_lock()
 
-   C'è anche :c:func:`mutex_trylock()` che però non dorme.
+   C'è anche mutex_trylock() che però non dorme.
    Comunque, non deve essere usata in un contesto d'interruzione dato
    che la sua implementazione non è sicura in quel contesto.
-   Anche :c:func:`mutex_unlock()` non dorme mai. Non può comunque essere
+   Anche mutex_unlock() non dorme mai. Non può comunque essere
    usata in un contesto d'interruzione perché un mutex deve essere rilasciato
    dallo stesso processo che l'ha acquisito.
 
@@ -1380,11 +1380,11 @@ Alcune funzioni che non dormono
 Alcune funzioni possono essere chiamate tranquillamente da qualsiasi
 contesto, o trattenendo un qualsiasi *lock*.
 
--  :c:func:`printk()`
+-  printk()
 
--  :c:func:`kfree()`
+-  kfree()
 
--  :c:func:`add_timer()` e :c:func:`del_timer()`
+-  add_timer() e del_timer()
 
 Riferimento per l'API dei Mutex
 ===============================
@@ -1444,14 +1444,14 @@ prelazione
 bh
   Bottom Half: per ragioni storiche, le funzioni che contengono '_bh' nel
   loro nome ora si riferiscono a qualsiasi interruzione software; per esempio,
-  :c:func:`spin_lock_bh()` blocca qualsiasi interuzione software sul processore
+  spin_lock_bh() blocca qualsiasi interuzione software sul processore
   corrente. I *Bottom Halves* sono deprecati, e probabilmente verranno
   sostituiti dai tasklet. In un dato momento potrà esserci solo un
   *bottom half* in esecuzione.
 
 contesto d'interruzione
   Non è il contesto utente: qui si processano le interruzioni hardware e
-  software. La macro :c:func:`in_interrupt()` ritorna vero.
+  software. La macro in_interrupt() ritorna vero.
 
 contesto utente
   Il kernel che esegue qualcosa per conto di un particolare processo (per
@@ -1461,12 +1461,12 @@ contesto utente
   che hardware.
 
 interruzione hardware
-  Richiesta di interruzione hardware. :c:func:`in_irq()` ritorna vero in un
+  Richiesta di interruzione hardware. in_irq() ritorna vero in un
   gestore d'interruzioni hardware.
 
 interruzione software / softirq
-  Gestore di interruzioni software: :c:func:`in_irq()` ritorna falso;
-  :c:func:`in_softirq()` ritorna vero. I tasklet e le softirq sono entrambi
+  Gestore di interruzioni software: in_irq() ritorna falso;
+  in_softirq() ritorna vero. I tasklet e le softirq sono entrambi
   considerati 'interruzioni software'.
 
   In soldoni, un softirq è uno delle 32 interruzioni software che possono
diff --git a/Documentation/translations/it_IT/process/2.Process.rst b/Documentation/translations/it_IT/process/2.Process.rst
index 9af4d01617c4..30dc172f06b0 100644
--- a/Documentation/translations/it_IT/process/2.Process.rst
+++ b/Documentation/translations/it_IT/process/2.Process.rst
@@ -23,18 +23,18 @@ ogni due o tre mesi viene effettuata un rilascio importante del kernel.
 I rilasci più recenti sono stati:
 
 	======  =================
-	4.11	Aprile 30, 2017
-	4.12	Luglio 2, 2017
-	4.13	Settembre 3, 2017
-	4.14	Novembre 12, 2017
-	4.15	Gennaio 28, 2018
-	4.16	Aprile 1, 2018
+	5.0     3 marzo, 2019
+	5.1     5 maggio, 2019
+	5.2     7 luglio, 2019
+	5.3     15 settembre, 2019
+	5.4     24 novembre, 2019
+	5.5     6 gennaio, 2020
 	======  =================
 
-Ciascun rilascio 4.x è un importante rilascio del kernel con nuove
+Ciascun rilascio 5.x è un importante rilascio del kernel con nuove
 funzionalità, modifiche interne dell'API, e molto altro.  Un tipico
-rilascio 4.x contiene quasi 13,000 gruppi di modifiche con ulteriori
-modifiche a parecchie migliaia di linee di codice.  La 4.x. è pertanto la
+rilascio contiene quasi 13,000 gruppi di modifiche con ulteriori
+modifiche a parecchie migliaia di linee di codice.  La 5.x. è pertanto la
 linea di confine nello sviluppo del kernel Linux; il kernel utilizza un sistema
 di sviluppo continuo che integra costantemente nuove importanti modifiche.
 
@@ -55,8 +55,8 @@ verrà descritto dettagliatamente più avanti).
 La finestra di inclusione resta attiva approssimativamente per due settimane.
 Al termine di questo periodo, Linus Torvald dichiarerà che la finestra è
 chiusa e rilascerà il primo degli "rc" del kernel.
-Per il kernel che è destinato ad essere 2.6.40, per esempio, il rilascio
-che emerge al termine della finestra d'inclusione si chiamerà 2.6.40-rc1.
+Per il kernel che è destinato ad essere 5.6, per esempio, il rilascio
+che emerge al termine della finestra d'inclusione si chiamerà 5.6-rc1.
 Questo rilascio indica che il momento di aggiungere nuovi componenti è
 passato, e che è iniziato il periodo di stabilizzazione del prossimo kernel.
 
@@ -76,22 +76,23 @@ Mentre le correzioni si aprono la loro strada all'interno del ramo principale,
 il ritmo delle modifiche rallenta col tempo.  Linus rilascia un nuovo
 kernel -rc circa una volta alla settimana; e ne usciranno circa 6 o 9 prima
 che il kernel venga considerato sufficientemente stabile e che il rilascio
-finale 2.6.x venga fatto.  A quel punto tutto il processo ricomincerà.
+finale venga fatto.  A quel punto tutto il processo ricomincerà.
 
-Esempio: ecco com'è andato il ciclo di sviluppo della versione 4.16
+Esempio: ecco com'è andato il ciclo di sviluppo della versione 5.4
 (tutte le date si collocano nel 2018)
 
 
 	==============  =======================================
-	Gennaio 28	4.15 rilascio stabile
-	Febbraio 11	4.16-rc1, finestra di inclusione chiusa
-	Febbraio 18	4.16-rc2
-	Febbraio 25	4.16-rc3
-	Marzo 4		4.16-rc4
-	Marzo 11	4.16-rc5
-	Marzo 18	4.16-rc6
-	Marzo 25	4.16-rc7
-	Aprile 1		4.17 rilascio stabile
+	15 settembre	5.3 rilascio stabile
+	30 settembre	5.4-rc1, finestra di inclusione chiusa
+	6 ottobre	5.4-rc2
+	13 ottobre	5.4-rc3
+	20 ottobre	5.4-rc4
+	27 ottobre	5.4-rc5
+	3 novembre	5.4-rc6
+	10 novembre	5.4-rc7
+	17 novembre	5.4-rc8
+	24 novembre	5.4 rilascio stabile
 	==============  =======================================
 
 In che modo gli sviluppatori decidono quando chiudere il ciclo di sviluppo e
@@ -108,43 +109,44 @@ tipo di perfezione difficilmente viene raggiunta; esistono troppe variabili
 in un progetto di questa portata.  Arriva un punto dove ritardare il rilascio
 finale peggiora la situazione; la quantità di modifiche in attesa della
 prossima finestra di inclusione crescerà enormemente, creando ancor più
-regressioni al giro successivo.  Quindi molti kernel 4.x escono con una
+regressioni al giro successivo.  Quindi molti kernel 5.x escono con una
 manciata di regressioni delle quali, si spera, nessuna è grave.
 
 Una volta che un rilascio stabile è fatto, il suo costante mantenimento è
 affidato al "squadra stabilità", attualmente composta da Greg Kroah-Hartman.
 Questa squadra rilascia occasionalmente degli aggiornamenti relativi al
-rilascio stabile usando la numerazione 4.x.y.  Per essere presa in
+rilascio stabile usando la numerazione 5.x.y.  Per essere presa in
 considerazione per un rilascio d'aggiornamento, una modifica deve:
 (1) correggere un baco importante (2) essere già inserita nel ramo principale
 per il prossimo sviluppo del kernel.  Solitamente, passato il loro rilascio
 iniziale, i kernel ricevono aggiornamenti per più di un ciclo di sviluppo.
-Quindi, per esempio, la storia del kernel 4.13 appare così:
+Quindi, per esempio, la storia del kernel 5.2 appare così (anno 2019):
 
 	==============  ===============================
-	Settembre 3 	4.13 rilascio stabile
-	Settembre 13	4.13.1
-	Settembre 20	4.13.2
-	Settembre 27	4.13.3
-	Ottobre 5	4.13.4
-	Ottobre 12	4.13.5
+	15 settembre	5.2 rilascio stabile FIXME settembre è sbagliato
+	14 luglio	5.2.1
+	21 luglio	5.2.2
+	26 luglio	5.2.3
+	28 luglio	5.2.4
+	31 luglio	5.2.5
 	...		...
-	Novembre 24	4.13.16
+	11 ottobre	5.2.21
 	==============  ===============================
 
-La 4.13.16 fu l'aggiornamento finale per la versione 4.13.
+La 5.2.21 fu l'aggiornamento finale per la versione 5.2.
 
 Alcuni kernel sono destinati ad essere kernel a "lungo termine"; questi
 riceveranno assistenza per un lungo periodo di tempo.  Al momento in cui
 scriviamo, i manutentori dei kernel stabili a lungo termine sono:
 
-	======  ======================  ==========================================
-	3.16	Ben Hutchings		(kernel stabile molto più a lungo termine)
-	4.1	Sasha Levin
-	4.4	Greg Kroah-Hartman	(kernel stabile molto più a lungo termine)
-	4.9	Greg Kroah-Hartman
-	4.14	Greg Kroah-Hartman
-	======  ======================  ==========================================
+	======  ================================  ==========================================
+	3.16	Ben Hutchings			  (kernel stabile molto più a lungo termine)
+	4.4	Greg Kroah-Hartman e Sasha Levin  (kernel stabile molto più a lungo termine)
+	4.9	Greg Kroah-Hartman e Sasha Levin
+	4.14	Greg Kroah-Hartman e Sasha Levin
+	4.19	Greg Kroah-Hartman e Sasha Levin
+	5.4i	Greg Kroah-Hartman e Sasha Levin
+	======  ================================  ==========================================
 
 
 Questa selezione di kernel di lungo periodo sono puramente dovuti ai loro
@@ -229,12 +231,13 @@ Come le modifiche finiscono nel Kernel
 --------------------------------------
 
 Esiste una sola persona che può inserire le patch nel repositorio principale
-del kernel: Linus Torvalds.  Ma, di tutte le 9500 patch che entrarono nella
-versione 2.6.38 del kernel, solo 112 (circa l'1,3%) furono scelte direttamente
-da Linus in persona.  Il progetto del kernel è cresciuto fino a raggiungere
-una dimensione tale per cui un singolo sviluppatore non può controllare e
-selezionare indipendentemente ogni modifica senza essere supportato.
-La via scelta dagli sviluppatori per indirizzare tale crescita è stata quella
+del kernel: Linus Torvalds.  Ma, per esempio, di tutte le 9500 patch
+che entrarono nella versione 2.6.38 del kernel, solo 112 (circa
+l'1,3%) furono scelte direttamente da Linus in persona.  Il progetto
+del kernel è cresciuto fino a raggiungere una dimensione tale per cui
+un singolo sviluppatore non può controllare e selezionare
+indipendentemente ogni modifica senza essere supportato.  La via
+scelta dagli sviluppatori per indirizzare tale crescita è stata quella
 di utilizzare un sistema di "sottotenenti" basato sulla fiducia.
 
 Il codice base del kernel è spezzato in una serie si sottosistemi: rete,
diff --git a/Documentation/translations/it_IT/process/coding-style.rst b/Documentation/translations/it_IT/process/coding-style.rst
index 8725f2b9e960..6f4f85832dee 100644
--- a/Documentation/translations/it_IT/process/coding-style.rst
+++ b/Documentation/translations/it_IT/process/coding-style.rst
@@ -313,7 +313,7 @@ che conta gli utenti attivi, dovreste chiamarla ``count_active_users()`` o
 qualcosa di simile, **non** dovreste chiamarla ``cntusr()``.
 
 Codificare il tipo di funzione nel suo nome (quella cosa chiamata notazione
-ungherese) fa male al cervello - il compilatore conosce comunque il tipo e
+ungherese) è stupido - il compilatore conosce comunque il tipo e
 può verificarli, e inoltre confonde i programmatori.  Non c'è da
 sorprendersi che MicroSoft faccia programmi bacati.
 
@@ -825,8 +825,8 @@ linguaggio assembler.
 
 Agli sviluppatori del kernel piace essere visti come dotti. Tenete un occhio
 di riguardo per l'ortografia e farete una belle figura. In inglese, evitate
-l'uso di parole mozzate come ``dont``: usate ``do not`` oppure ``don't``.
-Scrivete messaggi concisi, chiari, e inequivocabili.
+l'uso incorretto di abbreviazioni come ``dont``: usate ``do not`` oppure
+``don't``.  Scrivete messaggi concisi, chiari, e inequivocabili.
 
 I messaggi del kernel non devono terminare con un punto fermo.
 
diff --git a/Documentation/translations/it_IT/process/deprecated.rst b/Documentation/translations/it_IT/process/deprecated.rst
index 776f26732a94..e108eaf82cf6 100644
--- a/Documentation/translations/it_IT/process/deprecated.rst
+++ b/Documentation/translations/it_IT/process/deprecated.rst
@@ -34,6 +34,33 @@ interfaccia come 'vecchia', questa non è una soluzione completa. L'interfaccia
 deve essere rimossa dal kernel, o aggiunta a questo documento per scoraggiarne
 l'uso.
 
+BUG() e BUG_ON()
+----------------
+Al loro posto usate WARN() e WARN_ON() per gestire le
+condizioni "impossibili" e gestitele come se fosse possibile farlo.
+Nonostante le funzioni della famiglia BUG() siano state progettate
+per asserire "situazioni impossibili" e interrompere in sicurezza un
+thread del kernel, queste si sono rivelate essere troppo rischiose
+(per esempio, in quale ordine rilasciare i *lock*? Ci sono stati che
+sono stati ripristinati?). Molto spesso l'uso di BUG()
+destabilizza il sistema o lo corrompe del tutto, il che rende
+impossibile un'attività di debug o anche solo leggere un rapporto
+circa l'errore.  Linus ha un'opinione molto critica al riguardo:
+`email 1
+<https://lore.kernel.org/lkml/CA+55aFy6jNLsywVYdGp83AMrXBo_P-pkjkphPGrO=82SPKCpLQ@mail.gmail.com/>`_,
+`email 2
+<https://lore.kernel.org/lkml/CAHk-=whDHsbK3HTOpTF=ue_o04onRwTEaK_ZoJp_fjbqq4+=Jw@mail.gmail.com/>`_
+
+Tenete presente che la famiglia di funzioni WARN() dovrebbe essere
+usato solo per situazioni che si suppone siano "impossibili".  Se
+volete avvisare gli utenti riguardo a qualcosa di possibile anche se
+indesiderato, usare le funzioni della famiglia pr_warn().  Chi
+amministra il sistema potrebbe aver attivato l'opzione sysctl
+*panic_on_warn* per essere sicuri che il sistema smetta di funzionare
+in caso si verifichino delle condizioni "inaspettate". (per esempio,
+date un'occhiata al questo `commit
+<https://git.kernel.org/linus/d4689846881d160a4d12a514e991a740bcb5d65a>`_)
+
 Calcoli codificati negli argomenti di un allocatore
 ----------------------------------------------------
 Il calcolo dinamico delle dimensioni (specialmente le moltiplicazioni) non
@@ -68,52 +95,81 @@ Invece, usate la seguente funzione::
 
 	header = kzalloc(struct_size(header, item, count), GFP_KERNEL);
 
-Per maggiori dettagli fate riferimento a :c:func:`array_size`,
-:c:func:`array3_size`, e :c:func:`struct_size`, così come la famiglia di
-funzioni :c:func:`check_add_overflow` e :c:func:`check_mul_overflow`.
+Per maggiori dettagli fate riferimento a array_size(),
+array3_size(), e struct_size(), così come la famiglia di
+funzioni check_add_overflow() e check_mul_overflow().
 
 simple_strtol(), simple_strtoll(), simple_strtoul(), simple_strtoull()
 ----------------------------------------------------------------------
-Le funzioni :c:func:`simple_strtol`, :c:func:`simple_strtoll`,
-:c:func:`simple_strtoul`, e :c:func:`simple_strtoull` ignorano volutamente
+Le funzioni simple_strtol(), simple_strtoll(),
+simple_strtoul(), e simple_strtoull() ignorano volutamente
 i possibili overflow, e questo può portare il chiamante a generare risultati
-inaspettati. Le rispettive funzioni :c:func:`kstrtol`, :c:func:`kstrtoll`,
-:c:func:`kstrtoul`, e :c:func:`kstrtoull` sono da considerarsi le corrette
+inaspettati. Le rispettive funzioni kstrtol(), kstrtoll(),
+kstrtoul(), e kstrtoull() sono da considerarsi le corrette
 sostitute; tuttavia va notato che queste richiedono che la stringa sia
 terminata con il carattere NUL o quello di nuova riga.
 
 strcpy()
 --------
-La funzione :c:func:`strcpy` non fa controlli agli estremi del buffer
+La funzione strcpy() non fa controlli agli estremi del buffer
 di destinazione. Questo può portare ad un overflow oltre i limiti del
 buffer e generare svariati tipi di malfunzionamenti. Nonostante l'opzione
 `CONFIG_FORTIFY_SOURCE=y` e svariate opzioni del compilatore aiutano
 a ridurne il rischio, non c'è alcuna buona ragione per continuare ad usare
-questa funzione. La versione sicura da usare è :c:func:`strscpy`.
+questa funzione. La versione sicura da usare è strscpy().
 
 strncpy() su stringe terminate con NUL
 --------------------------------------
-L'utilizzo di :c:func:`strncpy` non fornisce alcuna garanzia sul fatto che
+L'utilizzo di strncpy() non fornisce alcuna garanzia sul fatto che
 il buffer di destinazione verrà terminato con il carattere NUL. Questo
 potrebbe portare a diversi overflow di lettura o altri malfunzionamenti
 causati, appunto, dalla mancanza del terminatore. Questa estende la
 terminazione nel buffer di destinazione quando la stringa d'origine è più
 corta; questo potrebbe portare ad una penalizzazione delle prestazioni per
 chi usa solo stringe terminate. La versione sicura da usare è
-:c:func:`strscpy`. (chi usa :c:func:`strscpy` e necessita di estendere la
-terminazione con NUL deve aggiungere una chiamata a :c:func:`memset`)
+strscpy(). (chi usa strscpy() e necessita di estendere la
+terminazione con NUL deve aggiungere una chiamata a memset())
 
-Se il chiamate no usa stringhe terminate con NUL, allore :c:func:`strncpy()`
+Se il chiamate no usa stringhe terminate con NUL, allore strncpy()()
 può continuare ad essere usata, ma i buffer di destinazione devono essere
 marchiati con l'attributo `__nonstring <https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html>`_
 per evitare avvisi durante la compilazione.
 
 strlcpy()
 ---------
-La funzione :c:func:`strlcpy`, per prima cosa, legge interamente il buffer di
+La funzione strlcpy(), per prima cosa, legge interamente il buffer di
 origine, magari leggendo più di quanto verrà effettivamente copiato. Questo
 è inefficiente e può portare a overflow di lettura quando la stringa non è
-terminata con NUL. La versione sicura da usare è :c:func:`strscpy`.
+terminata con NUL. La versione sicura da usare è strscpy().
+
+Segnaposto %p nella stringa di formato
+--------------------------------------
+
+Tradizionalmente, l'uso del segnaposto "%p" nella stringa di formato
+esponne un indirizzo di memoria in dmesg, proc, sysfs, eccetera.  Per
+evitare che questi indirizzi vengano sfruttati da malintenzionati,
+tutto gli usi di "%p" nel kernel rappresentano l'hash dell'indirizzo,
+rendendolo di fatto inutilizzabile.  Nuovi usi di "%p" non dovrebbero
+essere aggiunti al kernel.  Per una rappresentazione testuale di un
+indirizzo usate "%pS", l'output è migliore perché mostrerà il nome del
+simbolo.  Per tutto il resto, semplicemente non usate "%p".
+
+Parafrasando la `guida
+<https://lore.kernel.org/lkml/CA+55aFwQEd_d40g4mUCSsVRZzrFPUJt74vc6PPpb675hYNXcKw@mail.gmail.com/>`_
+di Linus:
+
+- Se il valore hash di "%p" è inutile, chiediti se il puntatore stesso
+  è importante. Forse dovrebbe essere rimosso del tutto?
+- Se credi davvero che il vero valore del puntatore sia importante,
+  perché alcuni stati del sistema o i livelli di privilegi di un
+  utente sono considerati "special"? Se pensi di poterlo giustificare
+  (in un commento e nel messaggio del commit) abbastanza bene da
+  affrontare il giudizio di Linus, allora forse potrai usare "%px",
+  assicurandosi anche di averne il permesso.
+
+Infine, sappi che un cambio in favore di "%p" con hash `non verrà
+accettato
+<https://lore.kernel.org/lkml/CA+55aFwieC1-nAs+NFq9RTwaR8ef9hWa4MjNBWL41F-8wM49eA@mail.gmail.com/>`_.
 
 Vettori a dimensione variabile (VLA)
 ------------------------------------
@@ -127,3 +183,47 @@ Questo può portare a dei malfunzionamenti, potrebbe sovrascrivere
 dati importanti alla fine dello stack (quando il kernel è compilato senza
 `CONFIG_THREAD_INFO_IN_TASK=y`), o sovrascrivere un pezzo di memoria adiacente
 allo stack (quando il kernel è compilato senza `CONFIG_VMAP_STACK=y`).
+
+Salto implicito nell'istruzione switch-case
+-------------------------------------------
+
+Il linguaggio C permette ai casi di un'istruzione `switch` di saltare al
+prossimo caso quando l'istruzione "break" viene omessa alla fine del caso
+corrente. Tuttavia questo rende il codice ambiguo perché non è sempre ovvio se
+l'istruzione "break" viene omessa intenzionalmente o è un baco. Per esempio,
+osservando il seguente pezzo di codice non è chiaro se lo stato
+`STATE_ONE` è stato progettato apposta per eseguire anche `STATE_TWO`::
+
+  switch (value) {
+  case STATE_ONE:
+          do_something();
+  case STATE_TWO:
+          do_other();
+          break;
+  default:
+          WARN("unknown state");
+  }
+
+Dato che c'è stata una lunga lista di problemi `dovuti alla mancanza dell'istruzione
+"break" <https://cwe.mitre.org/data/definitions/484.html>`_, oggigiorno non
+permettiamo più che vi sia un "salto implicito" (*fall-through*). Per
+identificare un salto implicito intenzionale abbiamo adottato la pseudo
+parola chiave 'fallthrough' che viene espansa nell'estensione di gcc
+`__attribute__((fallthrough))` `Statement Attributes
+<https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html>`_.
+(Quando la sintassi C17/C18 `[[fallthrough]]` sarà più comunemente
+supportata dai compilatori C, analizzatori statici, e dagli IDE,
+allora potremo usare quella sintassi per la pseudo parola chiave)
+
+Quando la sintassi [[fallthrough]] sarà più comunemente supportata dai
+compilatori, analizzatori statici, e ambienti di sviluppo IDE,
+allora potremo usarla anche noi.
+
+Ne consegue che tutti i blocchi switch/case devono finire in uno dei seguenti
+modi:
+
+* ``break;``
+* `fallthrough;``
+* ``continue;``
+* ``goto <label>;``
+* ``return [expression];``
-- 
2.25.4

