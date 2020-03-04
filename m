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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E36C3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 00:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075CF206E2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 00:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoS70Y/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387441AbgCDAtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 19:49:16 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38941 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgCDAtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 19:49:16 -0500
Received: by mail-pf1-f196.google.com with SMTP id l7so33295pff.6;
        Tue, 03 Mar 2020 16:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fchUchZf7JdeqH38aXjaBP5ZuQR9zSoVNleVtfnCoh8=;
        b=aoS70Y/SNFfr/bkddtY4JmUukQC8BDn9XS7opwiJ6w3OjoZCxZdAqWTp2nVsigLERZ
         bV7UZnmQOirWsYHTqxSWrfEaAqCUdi4WuLLMYn3iiqjU/lM35pCll0Hk9o3Zovts9oX5
         kXfk7DtkHYcTt6WUHqQpU0mn/BHw8ik7OZrD4of4sjae8aVWH/SlLFmcEDTBUITU1aMn
         FlJwxYFe0Ay6pIGo9bXiicFUNHUy3fAAoyqFvAnpkBX7DtnfGZGKcn9G7LU9RCOQk9IB
         PngAl4ywC/7NvvtgRubSDnOMfdYHdSaMFCWGjLQ7f6N+kvP+mUHYZvh5G4HpTyYsAQWb
         GSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fchUchZf7JdeqH38aXjaBP5ZuQR9zSoVNleVtfnCoh8=;
        b=aWbgJqa6ln+pnWzXsJs+o+xMr9Rna5vTJoO1YvLUq+Ril6wIvT0JDu5538NcitYFcE
         aqz1273z6+y4V396qT5fdgPFFdYTGvuzptIti411fMtpnCVf1xit26nktV13cQaaxGqq
         QqShB4lpX2Y2C66t0KOPeKSVFR1Ixk89oicH6lxd+RxDeywdQ1GZwfBi23h4QkbicffN
         TgjS9w7oqVPy05giivim1/9EmnLJFmozfAVjj001ZOr7OmmSsn/U/Mqm14JtRCcEeMBo
         ySuYuGjg5Trg5w1Ivq8EtBuE830KNIYJ5/YGjz/D8J8s2RqDnXhOnHLIaf3E368iUGCn
         +2ag==
X-Gm-Message-State: ANhLgQ2sWzDzQWXRg+p7HpOxmsfEeyIPxeOhTUmQU0tEiaXNorHEM+XL
        jVQ93yfjlY7lAXkNOuVyP9ZcyyaI
X-Google-Smtp-Source: ADFU+vtnecRChCSPLMPxV7NgPGh79fAtubdaps4zlWIhFDCOsvsL+PeNS/CSTs7V0sbjK7daMSTEuA==
X-Received: by 2002:a63:770d:: with SMTP id s13mr129483pgc.7.1583282954772;
        Tue, 03 Mar 2020 16:49:14 -0800 (PST)
Received: from localhost.localdomain ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id c15sm343440pja.30.2020.03.03.16.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 16:49:14 -0800 (PST)
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Brian Cain <bcain@codeaurora.org>
Subject: [PATCH v3] hexagon: replace setup_irq() by request_irq()
Date:   Wed,  4 Mar 2020 06:19:09 +0530
Message-Id: <20200304004910.4842-1-afzal.mohd.ma@gmail.com>
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
Hi hexagon maintainers,

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

 arch/hexagon/kernel/smp.c  | 22 +++++++++++-----------
 arch/hexagon/kernel/time.c | 11 +++--------
 2 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/arch/hexagon/kernel/smp.c b/arch/hexagon/kernel/smp.c
index 0bbbe652a513..619c56420aa0 100644
--- a/arch/hexagon/kernel/smp.c
+++ b/arch/hexagon/kernel/smp.c
@@ -114,12 +114,6 @@ void send_ipi(const struct cpumask *cpumask, enum ipi_message_type msg)
 	local_irq_restore(flags);
 }
 
-static struct irqaction ipi_intdesc = {
-	.handler = handle_ipi,
-	.flags = IRQF_TRIGGER_RISING,
-	.name = "ipi_handler"
-};
-
 void __init smp_prepare_boot_cpu(void)
 {
 }
@@ -132,8 +126,8 @@ void __init smp_prepare_boot_cpu(void)
 
 void start_secondary(void)
 {
-	unsigned int cpu;
 	unsigned long thread_ptr;
+	unsigned int cpu, irq;
 
 	/*  Calculate thread_info pointer from stack pointer  */
 	__asm__ __volatile__(
@@ -155,7 +149,10 @@ void start_secondary(void)
 
 	cpu = smp_processor_id();
 
-	setup_irq(BASE_IPI_IRQ + cpu, &ipi_intdesc);
+	irq = BASE_IPI_IRQ + cpu;
+	if (request_irq(irq, handle_ipi, IRQF_TRIGGER_RISING, "ipi_handler",
+			NULL))
+		pr_err("Failed to request irq %u (ipi_handler)\n", irq);
 
 	/*  Register the clock_event dummy  */
 	setup_percpu_clockdev();
@@ -201,7 +198,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
-	int i;
+	int i, irq = BASE_IPI_IRQ;
 
 	/*
 	 * should eventually have some sort of machine
@@ -213,8 +210,11 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 		set_cpu_present(i, true);
 
 	/*  Also need to register the interrupts for IPI  */
-	if (max_cpus > 1)
-		setup_irq(BASE_IPI_IRQ, &ipi_intdesc);
+	if (max_cpus > 1) {
+		if (request_irq(irq, handle_ipi, IRQF_TRIGGER_RISING,
+				"ipi_handler", NULL))
+			pr_err("Failed to request irq %d (ipi_handler)\n", irq);
+	}
 }
 
 void smp_send_reschedule(int cpu)
diff --git a/arch/hexagon/kernel/time.c b/arch/hexagon/kernel/time.c
index f99e9257bed4..feffe527ac92 100644
--- a/arch/hexagon/kernel/time.c
+++ b/arch/hexagon/kernel/time.c
@@ -143,13 +143,6 @@ static irqreturn_t timer_interrupt(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
-/*  This should also be pulled from devtree  */
-static struct irqaction rtos_timer_intdesc = {
-	.handler = timer_interrupt,
-	.flags = IRQF_TIMER | IRQF_TRIGGER_RISING,
-	.name = "rtos_timer"
-};
-
 /*
  * time_init_deferred - called by start_kernel to set up timer/clock source
  *
@@ -163,6 +156,7 @@ void __init time_init_deferred(void)
 {
 	struct resource *resource = NULL;
 	struct clock_event_device *ce_dev = &hexagon_clockevent_dev;
+	unsigned long flag = IRQF_TIMER | IRQF_TRIGGER_RISING;
 
 	ce_dev->cpumask = cpu_all_mask;
 
@@ -195,7 +189,8 @@ void __init time_init_deferred(void)
 #endif
 
 	clockevents_register_device(ce_dev);
-	setup_irq(ce_dev->irq, &rtos_timer_intdesc);
+	if (request_irq(ce_dev->irq, timer_interrupt, flag, "rtos_timer", NULL))
+		pr_err("Failed to register rtos_timer interrupt\n");
 }
 
 void __init time_init(void)
-- 
2.25.1

