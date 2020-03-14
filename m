Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CA9C4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FAD2051A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgCOCC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:02:27 -0400
Received: from smtprelay0001.hostedemail.com ([216.40.44.1]:38378 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726550AbgCOCC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:02:27 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id 4185A1803D435;
        Sat, 14 Mar 2020 21:15:46 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 0A5D1180286F5;
        Sat, 14 Mar 2020 21:15:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: order55_4f4bcd68dbf2c
X-Filterd-Recvd-Size: 4799
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sat, 14 Mar 2020 21:15:44 +0000 (UTC)
Message-ID: <7a2977ea9baacd1580ff80689f2c8f20d45b069d.camel@perches.com>
Subject: [PATCH] coding-style.rst: Add fallthrough as an emacs keyword
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 14 Mar 2020 14:13:59 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fallthrough was added as a pseudo-keyword by commit 294f69e662d1
("compiler_attributes.h: Add 'fallthrough' pseudo keyword for switch/case use")

Add fallthrough as a keyword to the example .emacs content
so emacs can colorize or highlight the uses.

Signed-off-by: Joe Perches <joe@perches.com>
---

I've no idea how to remove the infinite monkeys jibe from the chinese translation

 Documentation/process/coding-style.rst                    | 9 +++++----
 Documentation/translations/it_IT/process/coding-style.rst | 9 +++++----
 Documentation/translations/zh_CN/process/coding-style.rst | 5 ++++-
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index acb2f1b..3260cd 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -577,9 +577,7 @@ item, explaining its use.
 That's OK, we all do.  You've probably been told by your long-time Unix
 user helper that ``GNU emacs`` automatically formats the C sources for
 you, and you've noticed that yes, it does do that, but the defaults it
-uses are less than desirable (in fact, they are worse than random
-typing - an infinite number of monkeys typing into GNU emacs would never
-make a good program).
+uses are less than desirable.
 
 So, you can either get rid of GNU emacs, or change it to use saner
 values.  To do the latter, you can stick the following in your .emacs file:
@@ -631,7 +629,10 @@ values.  To do the latter, you can stick the following in your .emacs file:
 
   (dir-locals-set-directory-class
    (expand-file-name "~/src/linux-trees")
-   'linux-kernel)
+   'linux-kernel
+   (font-lock-add-keywords 'c-mode
+			   '(("\\<\\(fallthrough\\)\\>" . font-lock-keyword-face)))
+  )
 
 This will make emacs go better with the kernel coding style for C
 files below ``~/src/linux-trees``.
diff --git a/Documentation/translations/it_IT/process/coding-style.rst b/Documentation/translations/it_IT/process/coding-style.rst
index 8725f2b..67364f 100644
--- a/Documentation/translations/it_IT/process/coding-style.rst
+++ b/Documentation/translations/it_IT/process/coding-style.rst
@@ -584,9 +584,7 @@ commento per spiegarne l'uso.
 Va bene, li facciamo tutti.  Probabilmente vi è stato detto dal vostro
 aiutante Unix di fiducia che ``GNU emacs`` formatta automaticamente il
 codice C per conto vostro, e avete notato che sì, in effetti lo fa, ma che
-i modi predefiniti non sono proprio allettanti (infatti, sono peggio che
-premere tasti a caso - un numero infinito di scimmie che scrivono in
-GNU emacs non faranno mai un buon programma).
+i modi predefiniti non sono proprio allettanti.
 
 Quindi, potete sbarazzarvi di GNU emacs, o riconfigurarlo con valori più
 sensati.  Per fare quest'ultima cosa, potete appiccicare il codice che
@@ -639,7 +637,10 @@ segue nel vostro file .emacs:
 
   (dir-locals-set-directory-class
    (expand-file-name "~/src/linux-trees")
-   'linux-kernel)
+   'linux-kernel
+   (font-lock-add-keywords 'c-mode
+			   '(("\\<\\(fallthrough\\)\\>" . font-lock-keyword-face)))
+  )
 
 Questo farà funzionare meglio emacs con lo stile del kernel per i file che
 si trovano nella cartella ``~/src/linux-trees``.
diff --git a/Documentation/translations/zh_CN/process/coding-style.rst b/Documentation/translations/zh_CN/process/coding-style.rst
index eae10bc..6c9443 100644
--- a/Documentation/translations/zh_CN/process/coding-style.rst
+++ b/Documentation/translations/zh_CN/process/coding-style.rst
@@ -558,7 +558,10 @@ Documentation/doc-guide/ 和 scripts/kernel-doc 以获得详细信息。
 
   (dir-locals-set-directory-class
    (expand-file-name "~/src/linux-trees")
-   'linux-kernel)
+   'linux-kernel
+   (font-lock-add-keywords 'c-mode
+			   '(("\\<\\(fallthrough\\)\\>" . font-lock-keyword-face)))
+  )
 
 这会让 emacs 在 ``~/src/linux-trees`` 下的 C 源文件获得更好的内核代码风格。
 


