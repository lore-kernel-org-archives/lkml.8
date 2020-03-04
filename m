Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE84DC3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 00:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0C120637
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 00:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tfTyG1nv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387451AbgCDAvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 19:51:01 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:34910 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgCDAvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 19:51:01 -0500
Received: by mail-pj1-f67.google.com with SMTP id s8so118879pjq.0;
        Tue, 03 Mar 2020 16:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YjDxnROOsFBZHH9G4FkwXuXreuByRCX6q2DAdQ6+okY=;
        b=tfTyG1nvuYZjCHvhLdckSkWT0ydHTOp26o/TpzJtgDi372G8CIy9PQvX/6lJKr3bYm
         kZ51baTCu5A6t2GzydkX5hH54CVKkANwxX9qGZiFqJdVq+bYQE7OlzcinCcGy8GMNHCH
         Fm7E53rUzGAsN5PK5kWqjfxuf2+iHvwYIbQlis9AUOFBJQK2jZUw/lrn7YDwKtty4nYH
         imOmmTxzoWWsmgjXQxtUoIZZsIUUDZ/p64rj/72GgBJNhxqkNx+DoGF7v4dkPALyIbhI
         /D86tPtXbSF7/w3pTxCpQPDr95EovA4G0+vmkUfCRU7ItyQAE7HgTDxEs786gqaDs5Z2
         CVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YjDxnROOsFBZHH9G4FkwXuXreuByRCX6q2DAdQ6+okY=;
        b=E0frPc13CRgOFcd1mOrx+PS81hD74wBzMAHNgAdKeLChFfb+TtKmgBePgfN0eFKdKJ
         6kwVym36KrhsWuAExhSVtXuncMdwnooLS640zdN3aF7UoRPTkKEkMd3jdOZDZUFpBVYE
         Uf0iJ7AKunE9ECeBPrw+akWzW2cLk6h0rbgpgjHaih2Yb+e5j1EtC8jR2xcQa3AS1blA
         EXIagA9HV9F/XRXRJcHedS38207w0/8Oa5YlYPiQGLEIlMh5v4Qq9EVloztkSd9SEP5H
         7agWFK9Q5xNE7of0ZHc2pZOfiiOSNx5dERSO9xqH56TrPK0wCD7Ll13/BQq9r2TLC6YM
         GidA==
X-Gm-Message-State: ANhLgQ3PPGZ6V7JfW+F/maJkwQ44pb1yqB/ZYwlsFNM1uM5daONjSTJ9
        tzWU87JxrxQRKkMeHqakL8ZwkzKg
X-Google-Smtp-Source: ADFU+vs0IvL1EKnpHzB57Z+NA8IvfOLXojPeqBsfUktUQoHUL6iVb/zNL9/XppifWe3mOU7ModOkHg==
X-Received: by 2002:a17:902:9886:: with SMTP id s6mr611605plp.100.1583283058310;
        Tue, 03 Mar 2020 16:50:58 -0800 (PST)
Received: from localhost.localdomain ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id r13sm343720pjp.14.2020.03.03.16.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 16:50:57 -0800 (PST)
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: [PATCH v3] s390: replace setup_irq() by request_irq()
Date:   Wed,  4 Mar 2020 06:20:48 +0530
Message-Id: <20200304005049.5291-1-afzal.mohd.ma@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_irq() is preferred over setup_irq(). Invocations of setup_irq()
occur after memory allocators are ready.

Per tglx[1], setup_irq() existed in olden days when allocators were not
ready by the time early interrupts were initialized.

Hence replace setup_irq() by request_irq().

[1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---
Hi s390 maintainers,

if okay w/ this change, please consider taking it thr' your tree, else please
let me know.

Regards
afzal

Link to v2 & v1,
[v2] https://lkml.kernel.org/r/cover.1582471508.git.afzal.mohd.ma@gmail.com
[v1] https://lkml.kernel.org/r/cover.1581478323.git.afzal.mohd.ma@gmail.com

v3:
 * Split out from tree wide series, as Thomas suggested to get it thr'
	respective maintainers
 * Modify pr_err displayed in case of error
 * Re-arrange code & choose pr_err args as required to improve readability
 * Remove irrelevant parts from commit message & improve
 
v2:
 * Replace pr_err("request_irq() on %s failed" by
           pr_err("%s: request_irq() failed"
 * Commit message massage

 arch/s390/kernel/irq.c  | 8 ++------
 drivers/s390/cio/airq.c | 8 ++------
 drivers/s390/cio/cio.c  | 8 ++------
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index 8371855042dc..015c9dc45f7d 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -294,11 +294,6 @@ static irqreturn_t do_ext_interrupt(int irq, void *dummy)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction external_interrupt = {
-	.name	 = "EXT",
-	.handler = do_ext_interrupt,
-};
-
 void __init init_ext_interrupts(void)
 {
 	int idx;
@@ -308,7 +303,8 @@ void __init init_ext_interrupts(void)
 
 	irq_set_chip_and_handler(EXT_INTERRUPT,
 				 &dummy_irq_chip, handle_percpu_irq);
-	setup_irq(EXT_INTERRUPT, &external_interrupt);
+	if (request_irq(EXT_INTERRUPT, do_ext_interrupt, 0, "EXT", NULL))
+		pr_err("Failed to register EXT interrupt\n");
 }
 
 static DEFINE_SPINLOCK(irq_subclass_lock);
diff --git a/drivers/s390/cio/airq.c b/drivers/s390/cio/airq.c
index 427b2e24a8ce..a860da77b0d1 100644
--- a/drivers/s390/cio/airq.c
+++ b/drivers/s390/cio/airq.c
@@ -105,16 +105,12 @@ static irqreturn_t do_airq_interrupt(int irq, void *dummy)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction airq_interrupt = {
-	.name	 = "AIO",
-	.handler = do_airq_interrupt,
-};
-
 void __init init_airq_interrupts(void)
 {
 	irq_set_chip_and_handler(THIN_INTERRUPT,
 				 &dummy_irq_chip, handle_percpu_irq);
-	setup_irq(THIN_INTERRUPT, &airq_interrupt);
+	if (request_irq(THIN_INTERRUPT, do_airq_interrupt, 0, "AIO", NULL))
+		pr_err("Failed to register AIO interrupt\n");
 }
 
 static inline unsigned long iv_size(unsigned long bits)
diff --git a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
index 18f5458f90e8..94a66d6d32a3 100644
--- a/drivers/s390/cio/cio.c
+++ b/drivers/s390/cio/cio.c
@@ -563,16 +563,12 @@ static irqreturn_t do_cio_interrupt(int irq, void *dummy)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction io_interrupt = {
-	.name	 = "I/O",
-	.handler = do_cio_interrupt,
-};
-
 void __init init_cio_interrupts(void)
 {
 	irq_set_chip_and_handler(IO_INTERRUPT,
 				 &dummy_irq_chip, handle_percpu_irq);
-	setup_irq(IO_INTERRUPT, &io_interrupt);
+	if (request_irq(IO_INTERRUPT, do_cio_interrupt, 0, "I/O", NULL))
+		pr_err("Failed to register I/O interrupt\n");
 }
 
 #ifdef CONFIG_CCW_CONSOLE
-- 
2.25.1

