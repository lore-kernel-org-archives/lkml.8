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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777C0C3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 00:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A6B206D5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 00:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zgrfj9HW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387444AbgCDAuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 19:50:32 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41043 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbgCDAub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 19:50:31 -0500
Received: by mail-pg1-f193.google.com with SMTP id b1so128414pgm.8;
        Tue, 03 Mar 2020 16:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4i5Gs/Sv4Lt/cK2/XelvZbksB2WGpOmI+ebmeTuAw3k=;
        b=Zgrfj9HWQDfYBP/g4bKX+LsQ/AYbxX7PBhz1sV1WAm+fX9wrOTRaClFlFuHNpRQE9M
         RHgEz3DVUW05rnuAbH/88rV/PCAxRA+fbytqMHG2cOTX3kqCb5i0KhP4cQxAEHBC2TA1
         ZZoGCbwi5G2dVeLji7lSQdjUkgpHw59IyHWWShK9xkIW3xyk7fXRu9b/Aq230l4+Klb2
         YJ0RJ8QNevuwjQLfwHOiGm52WcJSaVqUOEZuxFjC5o89D7SVibB64t1dYH/FktVanrNE
         pZduxRXVKD+y/rxHsPdEJ3fHazausM0elvIlmwiUN7xkgUkEPuYlL2fqU/Io9itENrXA
         J4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4i5Gs/Sv4Lt/cK2/XelvZbksB2WGpOmI+ebmeTuAw3k=;
        b=iVL2bLLw04H/rl52Ci51GNQ04MZR3Et6W/TqzZHCsYgG8hbACR6aQTR8nSWK3EPVrx
         fEHtNaJcespl7PoHXLW75HCpQW3szfaKZ4hGXL5c8/m19+9krT4XD1czrFJGZdoHJ1y/
         cJ37Ugwrbw+VW86PzCPqqnMYHzaQgy6p2CRyrN/Nmz0EDwLDEX2xaQVNB9nddIE3E78g
         53aHCuM6rYRpSHZgWw6dwomS5AU2sxqLTSeoSrdoQZC+m93+xincEYC+5GCxJIFxiAFo
         ZRR0xyr9jzhQZuvLq52NufPCGGNoWfuMS6w9d5wa3M4XlRpgWT0Myl7AUy661T3EBg67
         GX0g==
X-Gm-Message-State: ANhLgQ2FKFhy+wucFg0IM1CSfdbk37bjjf5kdYRQSb2lHo6hZi2EZVb9
        SwhuFL8GSr9ggIBUUfpuQH+I3q9v
X-Google-Smtp-Source: ADFU+vto7qeGWxTXYn+Nw8Dl/kD7gogfFj7/Si3GbeJXMDT8c5Kn0G0k6Yd1nqEBHaUMWyVCAjOkYA==
X-Received: by 2002:a63:cf14:: with SMTP id j20mr130606pgg.67.1583283030448;
        Tue, 03 Mar 2020 16:50:30 -0800 (PST)
Received: from localhost.localdomain ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id d186sm7555662pfc.8.2020.03.03.16.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 16:50:29 -0800 (PST)
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH v3] parisc: Replace setup_irq() by request_irq()
Date:   Wed,  4 Mar 2020 06:20:24 +0530
Message-Id: <20200304005025.5179-1-afzal.mohd.ma@gmail.com>
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
Hi parisc maintainers,

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

 arch/parisc/kernel/irq.c | 22 ++++++----------------
 drivers/parisc/eisa.c    |  8 ++------
 2 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index e5fcfb70cc7c..e76c86619949 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -560,33 +560,23 @@ void do_cpu_irq_mask(struct pt_regs *regs)
 	goto out;
 }
 
-static struct irqaction timer_action = {
-	.handler = timer_interrupt,
-	.name = "timer",
-	.flags = IRQF_TIMER | IRQF_PERCPU | IRQF_IRQPOLL,
-};
-
-#ifdef CONFIG_SMP
-static struct irqaction ipi_action = {
-	.handler = ipi_interrupt,
-	.name = "IPI",
-	.flags = IRQF_PERCPU,
-};
-#endif
-
 static void claim_cpu_irqs(void)
 {
+	unsigned long flags = IRQF_TIMER | IRQF_PERCPU | IRQF_IRQPOLL;
 	int i;
+
 	for (i = CPU_IRQ_BASE; i <= CPU_IRQ_MAX; i++) {
 		irq_set_chip_and_handler(i, &cpu_interrupt_type,
 					 handle_percpu_irq);
 	}
 
 	irq_set_handler(TIMER_IRQ, handle_percpu_irq);
-	setup_irq(TIMER_IRQ, &timer_action);
+	if (request_irq(TIMER_IRQ, timer_interrupt, flags, "timer", NULL))
+		pr_err("Failed to register timer interrupt\n");
 #ifdef CONFIG_SMP
 	irq_set_handler(IPI_IRQ, handle_percpu_irq);
-	setup_irq(IPI_IRQ, &ipi_action);
+	if (request_irq(IPI_IRQ, ipi_interrupt, IRQF_PERCPU, "IPI", NULL))
+		pr_err("Failed to register IPI interrupt\n");
 #endif
 }
 
diff --git a/drivers/parisc/eisa.c b/drivers/parisc/eisa.c
index 9d00a24277aa..f96e5eaee87e 100644
--- a/drivers/parisc/eisa.c
+++ b/drivers/parisc/eisa.c
@@ -243,11 +243,6 @@ static irqreturn_t dummy_irq2_handler(int _, void *dev)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction irq2_action = {
-	.handler = dummy_irq2_handler,
-	.name = "cascade",
-};
-
 static void init_eisa_pic(void)
 {
 	unsigned long flags;
@@ -335,7 +330,8 @@ static int __init eisa_probe(struct parisc_device *dev)
 	}
 
 	/* Reserve IRQ2 */
-	setup_irq(2, &irq2_action);
+	if (request_irq(2, dummy_irq2_handler, 0, "cascade", NULL))
+		pr_err("Failed to request irq 2 (cascade)\n");
 	for (i = 0; i < 16; i++) {
 		irq_set_chip_and_handler(i, &eisa_interrupt_type,
 					 handle_simple_irq);
-- 
2.25.1

