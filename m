Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47B6C2BA1E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 21:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9833620659
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 21:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="gWcIyJQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgDEVGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 17:06:53 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:1452 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbgDEVGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 17:06:53 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id D777DB4C;
        Sun,  5 Apr 2020 23:06:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1586120810; x=1587935211;
         bh=gMtjva/2LYCyGqSMasV6HyfNJDUxms5Pd/tz4w2CSiI=; b=gWcIyJQJ+cW2
        mSCy+PBzE/HSMjkch9XtW+CSNnh+9XFzWGJXmzZhmmSA4SNxaHmVhD6ud6xtT/fT
        n16rBbvTewcNJ+vvd7rKk5xSGTxetDXLAhT9XUvz5CL6raop1mYf6D+MqvCg2pQ+
        sxsFp24WN6U4z5KbkpWfwKeoEor8PBXmRZXJZYsP+AXxvtaGS67uD9gqns20odxa
        XOIkb7FeiDxRqA6pca1wLCBVAxVid+9i9VEwF6OI2iUAJ34QEpy5QjFOTF7PpssS
        Nd6myoRSE+GGMabd+T0/VfX38YZOuWGMgdRlzr6L3VU5gAZqwCMkzCu1WdJutTXA
        0/m5rTFLg0fsscz2bO5tZYUUEGA07dn4m8oQ6Xpeh7hkZBQOzURTtNlWlpPcx1mG
        lcyGLsmPiRq+F6mw5JDzQSQARa5zTaK0JRCr2o+rpmujCE/7XjftxV6bKHI/Bqx6
        haO5DTV3lHeWZJGqJ//4VRQJ7i5gA3NUBLUaGw1f5+oEteCGsfONhyzCXbceNRBL
        6yfMPGlg1xyuW54vB+ix1KVIe8pb4EgLlmX+I9+jGbYVVILYzbgUDvsiff1fBzjx
        rNp5BymrwjAJ9tncH1VyxLYPmEVS/Kd3/ZVftLW6IHQTfl/hPse3NnSfzIuLu9ls
        +RvDrw7u1JyNMP4RonikBjRvVESkNM0=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZxbZmQ0Z2SVX; Sun,  5 Apr 2020 23:06:50 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 4B7C556F;
        Sun,  5 Apr 2020 23:06:50 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id F3EA739A;
        Sun,  5 Apr 2020 23:06:49 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH] doc:it_IT: add RISC-V maintenance guidelines
Date:   Sun,  5 Apr 2020 23:06:47 +0200
Message-Id: <20200405210647.24991-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add translation for the RISC-V maintenance guidelines as part
of the translation of things related to "process/"

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 .../translations/it_IT/process/index.rst      |  1 +
 .../it_IT/riscv/patch-acceptance.rst          | 40 +++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 Documentation/translations/it_IT/riscv/patch-acceptance.rst

diff --git a/Documentation/translations/it_IT/process/index.rst b/Documentation/translations/it_IT/process/index.rst
index 012de0f3154a..c4c867132c88 100644
--- a/Documentation/translations/it_IT/process/index.rst
+++ b/Documentation/translations/it_IT/process/index.rst
@@ -59,6 +59,7 @@ perché non si è trovato un posto migliore.
    magic-number
    volatile-considered-harmful
    clang-format
+   ../riscv/patch-acceptance
 
 .. only::  subproject and html
 
diff --git a/Documentation/translations/it_IT/riscv/patch-acceptance.rst b/Documentation/translations/it_IT/riscv/patch-acceptance.rst
new file mode 100644
index 000000000000..edf67252b3fb
--- /dev/null
+++ b/Documentation/translations/it_IT/riscv/patch-acceptance.rst
@@ -0,0 +1,40 @@
+.. include:: ../disclaimer-ita.rst
+
+:Original: :doc:`../../../riscv/patch-acceptance`
+:Translator: Federico Vaga <federico.vaga@vaga.pv.it>
+
+arch/riscv linee guida alla manutenzione per gli sviluppatori
+=============================================================
+
+Introduzione
+------------
+
+L'insieme di istruzioni RISC-V sono sviluppate in modo aperto: le
+bozze in fase di sviluppo sono disponibili a tutti per essere
+revisionate e per essere sperimentare nelle implementazioni.  Le bozze
+dei nuovi moduli o estensioni possono cambiare in fase di sviluppo - a
+volte in modo incompatibile rispetto a bozze precedenti.  Questa
+flessibilità può portare a dei problemi di manutenzioni per il
+supporto RISC-V nel kernel Linux. I manutentori Linux non amano
+l'abbandono del codice, e il processo di sviluppo del kernel
+preferisce codice ben revisionato e testato rispetto a quello
+sperimentale.  Desideriamo estendere questi stessi principi al codice
+relativo all'architettura RISC-V che verrà accettato per l'inclusione
+nel kernel.
+
+In aggiunta alla lista delle verifiche da fare prima di inviare una patch
+-------------------------------------------------------------------------
+
+Accetteremo le patch per un nuovo modulo o estensione se la fondazione
+RISC-V li classifica come "Frozen" o "Retified".  (Ovviamente, gli
+sviluppatori sono liberi di mantenere una copia del kernel Linux
+contenente il codice per una bozza di estensione).
+
+In aggiunta, la specifica RISC-V permette agli implementatori di
+creare le proprie estensioni.  Queste estensioni non passano
+attraverso il processo di revisione della fondazione RISC-V.  Per
+questo motivo, al fine di evitare complicazioni o problemi di
+prestazioni, accetteremo patch solo per quelle estensioni che sono
+state ufficialmente accettate dalla fondazione RISC-V.  (Ovviamente,
+gli implementatori sono liberi di mantenere una copia del kernel Linux
+contenente il codice per queste specifiche estensioni).
-- 
2.25.1

