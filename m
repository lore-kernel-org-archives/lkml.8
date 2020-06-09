Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2906EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0075020734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389429AbgFIUN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 16:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732949AbgFIUN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 16:13:57 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C44AC05BD1E;
        Tue,  9 Jun 2020 13:13:56 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 4A9CF1388F4;
        Tue,  9 Jun 2020 20:13:47 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     Federico Vaga <federico.vaga@vaga.pv.it>,
        Jonathan Corbet <corbet@lwn.net>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Jacob Huisman <jacobhuisman@kernelthusiast.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] Replace HTTP links with HTTPS ones: Documentation/translations/it_IT
Date:   Tue,  9 Jun 2020 22:12:41 +0200
Message-Id: <20200609201241.81518-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spamd-Bar: /
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  For each line:
    If doesn't contain `\bxmlns\b`:
      For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
        If both the HTTP and HTTPS versions
        return 200 OK and serve the same content:
          Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 .../translations/it_IT/admin-guide/README.rst      |  2 +-
 .../translations/it_IT/doc-guide/parse-headers.rst |  2 +-
 .../translations/it_IT/doc-guide/sphinx.rst        | 10 +++++-----
 .../translations/it_IT/process/2.Process.rst       | 12 ++++++------
 .../translations/it_IT/process/3.Early-stage.rst   |  2 +-
 .../translations/it_IT/process/4.Coding.rst        |  4 ++--
 .../it_IT/process/7.AdvancedTopics.rst             |  8 ++++----
 .../translations/it_IT/process/8.Conclusion.rst    | 14 +++++++-------
 .../translations/it_IT/process/adding-syscalls.rst |  4 ++--
 .../translations/it_IT/process/changes.rst         |  6 +++---
 .../translations/it_IT/process/clang-format.rst    |  2 +-
 .../translations/it_IT/process/coding-style.rst    |  2 +-
 Documentation/translations/it_IT/process/howto.rst |  2 +-
 .../it_IT/process/maintainer-pgp-guide.rst         |  2 +-
 .../it_IT/process/submitting-patches.rst           |  4 ++--
 .../it_IT/process/volatile-considered-harmful.rst  |  4 ++--
 16 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/Documentation/translations/it_IT/admin-guide/README.rst b/Documentation/translations/it_IT/admin-guide/README.rst
index b37166817842..fb0c0b0fde71 100644
--- a/Documentation/translations/it_IT/admin-guide/README.rst
+++ b/Documentation/translations/it_IT/admin-guide/README.rst
@@ -4,7 +4,7 @@
 
 .. _it_readme:
 
-Rilascio del kernel Linux  5.x <http://kernel.org/>
+Rilascio del kernel Linux  5.x <https://kernel.org/>
 ===================================================
 
 .. warning::
diff --git a/Documentation/translations/it_IT/doc-guide/parse-headers.rst b/Documentation/translations/it_IT/doc-guide/parse-headers.rst
index 993d549ee2b8..e210bbd84fb6 100644
--- a/Documentation/translations/it_IT/doc-guide/parse-headers.rst
+++ b/Documentation/translations/it_IT/doc-guide/parse-headers.rst
@@ -190,7 +190,7 @@ COPYRIGHT
 
 Copyright (c) 2016 by Mauro Carvalho Chehab <mchehab@s-opensource.com>.
 
-Licenza GPLv2: GNU GPL version 2 <http://gnu.org/licenses/gpl.html>.
+Licenza GPLv2: GNU GPL version 2 <https://gnu.org/licenses/gpl.html>.
 
 Questo è software libero: siete liberi di cambiarlo e ridistribuirlo.
 Non c'è alcuna garanzia, nei limiti permessi dalla legge.
diff --git a/Documentation/translations/it_IT/doc-guide/sphinx.rst b/Documentation/translations/it_IT/doc-guide/sphinx.rst
index f1ad4504b734..0aaeb0297661 100644
--- a/Documentation/translations/it_IT/doc-guide/sphinx.rst
+++ b/Documentation/translations/it_IT/doc-guide/sphinx.rst
@@ -14,7 +14,7 @@ Per generare la documentazione in HTML o PDF, usate comandi ``make htmldocs`` o
 ``make pdfdocs``. La documentazione così generata sarà disponibile nella
 cartella ``Documentation/output``.
 
-.. _Sphinx: http://www.sphinx-doc.org/
+.. _Sphinx: https://www.sphinx-doc.org/
 .. _reStructuredText: http://docutils.sourceforge.net/rst.html
 
 I file reStructuredText possono contenere delle direttive che permettono di
@@ -191,8 +191,8 @@ informazione circa le loro potenzialità. In particolare, il
 cui cominciare. Esistono, inoltre, anche alcuni
 `costruttori specifici per Sphinx`_.
 
-.. _`manuale introduttivo a reStructuredText`: http://www.sphinx-doc.org/en/stable/rest.html
-.. _`costruttori specifici per Sphinx`: http://www.sphinx-doc.org/en/stable/markup/index.html
+.. _`manuale introduttivo a reStructuredText`: https://www.sphinx-doc.org/en/stable/rest.html
+.. _`costruttori specifici per Sphinx`: https://www.sphinx-doc.org/en/stable/markup/index.html
 
 Guide linea per la documentazione del kernel
 --------------------------------------------
@@ -388,8 +388,8 @@ formato SVG::
 Le direttive del kernel per figure ed immagini supportano il formato **DOT**,
 per maggiori informazioni
 
-* DOT: http://graphviz.org/pdf/dotguide.pdf
-* Graphviz: http://www.graphviz.org/content/dot-language
+* DOT: https://graphviz.org/pdf/dotguide.pdf
+* Graphviz: https://www.graphviz.org/content/dot-language
 
 Un piccolo esempio (:ref:`it_hello_dot_file`)::
 
diff --git a/Documentation/translations/it_IT/process/2.Process.rst b/Documentation/translations/it_IT/process/2.Process.rst
index 30dc172f06b0..c2f3a0647d1b 100644
--- a/Documentation/translations/it_IT/process/2.Process.rst
+++ b/Documentation/translations/it_IT/process/2.Process.rst
@@ -315,7 +315,7 @@ patch andrà nel ramo principale attraverso -mm.
 La patch -mm correnti sono disponibili nella cartella "mmotm" (-mm of
 the moment) all'indirizzo:
 
-      http://www.ozlabs.org/~akpm/mmotm/
+      https://www.ozlabs.org/~akpm/mmotm/
 
 È molto probabile che l'uso dei sorgenti MMOTM diventi un'esperienza
 frustrante; ci sono buone probabilità che non compili nemmeno.
@@ -327,7 +327,7 @@ la prossima finestra di inclusione si chiuderà.  I linux-next sono annunciati
 sulla lista di discussione linux-kernel e linux-next nel momento in cui
 vengono assemblati; e possono essere scaricate da:
 
-	http://www.kernel.org/pub/linux/kernel/next/
+	https://www.kernel.org/pub/linux/kernel/next/
 
 Linux-next è divenuto parte integrante del processo di sviluppo del kernel;
 tutte le patch incorporate durante una finestra di integrazione dovrebbero
@@ -391,21 +391,21 @@ con il lavoro degli altri sviluppatori (e con il ramo principale).
 Git è ora compreso in quasi tutte le distribuzioni Linux. Esiste una sito che
 potete consultare:
 
-	http://git-scm.com/
+	https://git-scm.com/
 
 Qui troverete i riferimenti alla documentazione e alle guide passo-passo.
 
 Tra gli sviluppatori Kernel che non usano git, la scelta alternativa più
 popolare è quasi sicuramente Mercurial:
 
-	http://www.selenic.com/mercurial/
+	https://www.selenic.com/mercurial/
 
 Mercurial condivide diverse caratteristiche con git, ma fornisce
 un'interfaccia che potrebbe risultare più semplice da utilizzare.
 
 L'altro strumento che vale la pena conoscere è Quilt:
 
-	http://savannah.nongnu.org/projects/quilt/
+	https://savannah.nongnu.org/projects/quilt/
 
 
 Quilt è un sistema di gestione delle patch, piuttosto che un sistema
@@ -524,7 +524,7 @@ Andrew Morton da questo consiglio agli aspiranti sviluppatori kernel
      collaborare con gli altri nel sistemare le cose (questo richiede
      persistenza!) ma va bene - è parte dello sviluppo kernel.
 
-(http://lwn.net/Articles/283982/).
+(https://lwn.net/Articles/283982/).
 
 In assenza di problemi ovvi da risolvere, si consiglia agli sviluppatori
 di consultare, in generale, la lista di regressioni e di bachi aperti.
diff --git a/Documentation/translations/it_IT/process/3.Early-stage.rst b/Documentation/translations/it_IT/process/3.Early-stage.rst
index 443ac1e5558f..f8a2b4ca320f 100644
--- a/Documentation/translations/it_IT/process/3.Early-stage.rst
+++ b/Documentation/translations/it_IT/process/3.Early-stage.rst
@@ -55,7 +55,7 @@ scrisse questo messaggio:
 	una perdita di tempo. Loro sono troppo "intelligenti" per stare ad
 	ascoltare dei poveri mortali.
 
-	(http://lwn.net/Articles/131776/).
+	(https://lwn.net/Articles/131776/).
 
 La realtà delle cose fu differente; gli sviluppatori del kernel erano molto
 più preoccupati per la stabilità del sistema, per la manutenzione di lungo
diff --git a/Documentation/translations/it_IT/process/4.Coding.rst b/Documentation/translations/it_IT/process/4.Coding.rst
index a5e36aa60448..11dbff7f0f4c 100644
--- a/Documentation/translations/it_IT/process/4.Coding.rst
+++ b/Documentation/translations/it_IT/process/4.Coding.rst
@@ -222,7 +222,7 @@ domanda ci è stata fornita da Linus nel luglio 2007:
    dei progressi reali. Sono due passi avanti e uno indietro, oppure
    un passo avanti e due indietro?
 
-(http://lwn.net/Articles/243460/).
+(https://lwn.net/Articles/243460/).
 
 Una particolare tipologia di regressione mal vista consiste in una qualsiasi
 sorta di modifica all'ABI dello spazio utente.  Una volta che un'interfaccia
@@ -340,7 +340,7 @@ scheda di sviluppo Blackfin sotto mano, potete comunque continuare la fase
 di compilazione.  Un vasto numero di cross-compilatori per x86 possono
 essere trovati al sito:
 
-	http://www.kernel.org/pub/tools/crosstool/
+	https://www.kernel.org/pub/tools/crosstool/
 
 Il tempo impiegato nell'installare e usare questi compilatori sarà d'aiuto
 nell'evitare situazioni imbarazzanti nel futuro.
diff --git a/Documentation/translations/it_IT/process/7.AdvancedTopics.rst b/Documentation/translations/it_IT/process/7.AdvancedTopics.rst
index cc1cff5d23ae..dffd813a0910 100644
--- a/Documentation/translations/it_IT/process/7.AdvancedTopics.rst
+++ b/Documentation/translations/it_IT/process/7.AdvancedTopics.rst
@@ -35,9 +35,9 @@ git è parte del processo di sviluppo del kernel.  Gli sviluppatori che
 desiderassero diventare agili con git troveranno più informazioni ai
 seguenti indirizzi:
 
-	http://git-scm.com/
+	https://git-scm.com/
 
-	http://www.kernel.org/pub/software/scm/git/docs/user-manual.html
+	https://www.kernel.org/pub/software/scm/git/docs/user-manual.html
 
 e su varie guide che potrete trovare su internet.
 
@@ -63,7 +63,7 @@ eseguire git-daemon è relativamente semplice .  Altrimenti, iniziano a
 svilupparsi piattaforme che offrono spazi pubblici, e gratuiti (Github,
 per esempio).  Gli sviluppatori permanenti possono ottenere un account
 su kernel.org, ma non è proprio facile da ottenere; per maggiori informazioni
-consultate la pagina web http://kernel.org/faq/.
+consultate la pagina web https://kernel.org/faq/.
 
 In git è normale avere a che fare con tanti rami.  Ogni linea di sviluppo
 può essere separata in "rami per argomenti" e gestiti indipendentemente.
@@ -137,7 +137,7 @@ vostri rami.  Citando Linus
 	facendo, e ho bisogno di fidarmi *senza* dover passare tutte
 	le modifiche manualmente una per una.
 
-(http://lwn.net/Articles/224135/).
+(https://lwn.net/Articles/224135/).
 
 Per evitare queste situazioni, assicuratevi che tutte le patch in un ramo
 siano strettamente correlate al tema delle modifiche; un ramo "driver fixes"
diff --git a/Documentation/translations/it_IT/process/8.Conclusion.rst b/Documentation/translations/it_IT/process/8.Conclusion.rst
index 039bfc5a4108..b5520846fe51 100644
--- a/Documentation/translations/it_IT/process/8.Conclusion.rst
+++ b/Documentation/translations/it_IT/process/8.Conclusion.rst
@@ -24,23 +24,23 @@ appropriatamente i documenti).
 
 Diversi siti web approfondiscono lo sviluppo del kernel ad ogni livello
 di dettaglio.  Il vostro autore vorrebbe umilmente suggerirvi
-http://lwn.net/ come fonte; usando l'indice 'kernel' su LWN troverete
+https://lwn.net/ come fonte; usando l'indice 'kernel' su LWN troverete
 molti argomenti specifici sul kernel:
 
-	http://lwn.net/Kernel/Index/
+	https://lwn.net/Kernel/Index/
 
 Oltre a ciò, una risorsa valida per gli sviluppatori kernel è:
 
-	http://kernelnewbies.org/
+	https://kernelnewbies.org/
 
-E, ovviamente, una fonte da non dimenticare è http://kernel.org/, il luogo
+E, ovviamente, una fonte da non dimenticare è https://kernel.org/, il luogo
 definitivo per le informazioni sui rilasci del kernel.
 
 Ci sono numerosi libri sullo sviluppo del kernel:
 
 	Linux Device Drivers, 3rd Edition (Jonathan Corbet, Alessandro
 	Rubini, and Greg Kroah-Hartman).  In linea all'indirizzo
-	http://lwn.net/Kernel/LDD3/.
+	https://lwn.net/Kernel/LDD3/.
 
 	Linux Kernel Development (Robert Love).
 
@@ -52,9 +52,9 @@ tempo.  Comunque contengono informazioni abbastanza buone.
 
 La documentazione per git la troverete su:
 
-	http://www.kernel.org/pub/software/scm/git/docs/
+	https://www.kernel.org/pub/software/scm/git/docs/
 
-	http://www.kernel.org/pub/software/scm/git/docs/user-manual.html
+	https://www.kernel.org/pub/software/scm/git/docs/user-manual.html
 
 
 
diff --git a/Documentation/translations/it_IT/process/adding-syscalls.rst b/Documentation/translations/it_IT/process/adding-syscalls.rst
index bff0a82bf127..b3fb1434cc0c 100644
--- a/Documentation/translations/it_IT/process/adding-syscalls.rst
+++ b/Documentation/translations/it_IT/process/adding-syscalls.rst
@@ -604,9 +604,9 @@ Riferimenti e fonti
    :manpage:`syscall(2)` :
    http://man7.org/linux/man-pages/man2/syscall.2.html#NOTES
  - Collezione di email di Linux Torvalds sui problemi relativi a ``ioctl()``:
-   http://yarchive.net/comp/linux/ioctl.html
+   https://yarchive.net/comp/linux/ioctl.html
  - "Come non inventare interfacce del kernel", Arnd Bergmann,
-   http://www.ukuug.org/events/linux2007/2007/papers/Bergmann.pdf
+   https://www.ukuug.org/events/linux2007/2007/papers/Bergmann.pdf
  - Articolo di Michael Kerris su LWN sull'evitare nuovi usi di CAP_SYS_ADMIN:
    https://lwn.net/Articles/486306/
  - Raccomandazioni da Andrew Morton circa il fatto che tutte le informazioni
diff --git a/Documentation/translations/it_IT/process/changes.rst b/Documentation/translations/it_IT/process/changes.rst
index 37da4447a40d..b8af957c6e05 100644
--- a/Documentation/translations/it_IT/process/changes.rst
+++ b/Documentation/translations/it_IT/process/changes.rst
@@ -131,7 +131,7 @@ Modifiche architetturali
 ------------------------
 
 DevFS è stato reso obsoleto da udev
-(http://www.kernel.org/pub/linux/utils/kernel/hotplug/)
+(https://www.kernel.org/pub/linux/utils/kernel/hotplug/)
 
 Il supporto per UID a 32-bit è ora disponibile.  Divertitevi!
 
@@ -428,7 +428,7 @@ Microcodice Intel P6
 udev
 ----
 
-- <http://www.freedesktop.org/software/systemd/man/udev.html>
+- <https://www.freedesktop.org/software/systemd/man/udev.html>
 
 FUSE
 ----
@@ -482,4 +482,4 @@ Documentazione del kernel
 Sphinx
 ------
 
-- <http://www.sphinx-doc.org/>
+- <https://www.sphinx-doc.org/>
diff --git a/Documentation/translations/it_IT/process/clang-format.rst b/Documentation/translations/it_IT/process/clang-format.rst
index 77eac809a639..29f83c198025 100644
--- a/Documentation/translations/it_IT/process/clang-format.rst
+++ b/Documentation/translations/it_IT/process/clang-format.rst
@@ -40,7 +40,7 @@ Linux più popolari. Cercate ``clang-format`` nel vostro repositorio.
 Altrimenti, potete scaricare una versione pre-generata dei binari di LLVM/clang
 oppure generarlo dai codici sorgenti:
 
-    http://releases.llvm.org/download.html
+    https://releases.llvm.org/download.html
 
 Troverete più informazioni ai seguenti indirizzi:
 
diff --git a/Documentation/translations/it_IT/process/coding-style.rst b/Documentation/translations/it_IT/process/coding-style.rst
index 6f4f85832dee..aca3d6b32653 100644
--- a/Documentation/translations/it_IT/process/coding-style.rst
+++ b/Documentation/translations/it_IT/process/coding-style.rst
@@ -1144,7 +1144,7 @@ ISBN 0-201-61586-X.
 
 Manuali GNU - nei casi in cui sono compatibili con K&R e questo documento -
 per indent, cpp, gcc e i suoi dettagli interni, tutto disponibile qui
-http://www.gnu.org/manual/
+https://www.gnu.org/manual/
 
 WG14 è il gruppo internazionale di standardizzazione per il linguaggio C,
 URL: http://www.open-std.org/JTC1/SC22/WG14/
diff --git a/Documentation/translations/it_IT/process/howto.rst b/Documentation/translations/it_IT/process/howto.rst
index 1db5a1082389..b6e6ac239c25 100644
--- a/Documentation/translations/it_IT/process/howto.rst
+++ b/Documentation/translations/it_IT/process/howto.rst
@@ -618,7 +618,7 @@ Per maggiori dettagli su come tutto ciò dovrebbe apparire, riferitevi alla
 sezione ChangeLog del documento:
 
  "The Perfect Patch"
-      http://www.ozlabs.org/~akpm/stuff/tpp.txt
+      https://www.ozlabs.org/~akpm/stuff/tpp.txt
 
 A volte tutto questo è difficile da realizzare. Il perfezionamento di queste
 pratiche può richiedere anni (eventualmente). È un processo continuo di
diff --git a/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst b/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst
index f3c8e8d377ee..41043bccab20 100644
--- a/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst
+++ b/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst
@@ -473,7 +473,7 @@ Nitrokey Start.
 .. _`Nitrokey Start`: https://shop.nitrokey.com/shop/product/nitrokey-start-6
 .. _`Nitrokey Pro 2`: https://shop.nitrokey.com/shop/product/nitrokey-pro-2-3
 .. _`Yubikey 5`: https://www.yubico.com/product/yubikey-5-overview/
-.. _Gnuk: http://www.fsij.org/doc-gnuk/
+.. _Gnuk: https://www.fsij.org/doc-gnuk/
 .. _`Su LWN c'è una buona recensione`: https://lwn.net/Articles/736231/
 
 Configurare il vostro dispositivo smartcard
diff --git a/Documentation/translations/it_IT/process/submitting-patches.rst b/Documentation/translations/it_IT/process/submitting-patches.rst
index 7c23c08e4401..37196ca2c707 100644
--- a/Documentation/translations/it_IT/process/submitting-patches.rst
+++ b/Documentation/translations/it_IT/process/submitting-patches.rst
@@ -102,7 +102,7 @@ sviluppatori, il che è molto importante se volete che la patch venga accettata.
 
 Se state utilizzando ``git``, ``git rebase -i`` può aiutarvi nel procedimento.
 Se non usate ``git``, un'alternativa popolare è ``quilt``
-<http://savannah.nongnu.org/projects/quilt>.
+<https://savannah.nongnu.org/projects/quilt>.
 
 .. _it_describe_changes:
 
@@ -865,7 +865,7 @@ Riferimenti
 -----------
 
 Andrew Morton, "La patch perfetta" (tpp).
-  <http://www.ozlabs.org/~akpm/stuff/tpp.txt>
+  <https://www.ozlabs.org/~akpm/stuff/tpp.txt>
 
 Jeff Garzik, "Formato per la sottomissione di patch per il kernel Linux"
   <https://web.archive.org/web/20180829112450/http://linux.yyz.us/patch-format.html>
diff --git a/Documentation/translations/it_IT/process/volatile-considered-harmful.rst b/Documentation/translations/it_IT/process/volatile-considered-harmful.rst
index efc640cac596..4fff9a59b548 100644
--- a/Documentation/translations/it_IT/process/volatile-considered-harmful.rst
+++ b/Documentation/translations/it_IT/process/volatile-considered-harmful.rst
@@ -119,9 +119,9 @@ concorrenza siano stati opportunamente considerati.
 Riferimenti
 ===========
 
-[1] http://lwn.net/Articles/233481/
+[1] https://lwn.net/Articles/233481/
 
-[2] http://lwn.net/Articles/233482/
+[2] https://lwn.net/Articles/233482/
 
 Crediti
 =======
-- 
2.26.2

