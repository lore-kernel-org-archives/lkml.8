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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5CDC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 00:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1DA206D5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 00:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPg4ZbPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387414AbgCDAlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 19:41:24 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33967 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgCDAlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 19:41:24 -0500
Received: by mail-pl1-f196.google.com with SMTP id j7so206244plt.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 16:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0v4QnmomYtLDKkZhTWixIsZmvX5XApJobfyYR5hOCfc=;
        b=jPg4ZbPcHFBSU/Btau79OXjm7VZDCp28YCITyUJ8H0fjNnAm9gnxqh+QNGa5auXJyg
         E1yaJLI9LA4r+9+5fVplhk3IDrFX6AetBZG6IdxqXUIlIKkKlB/04jlmA3JYwRA9pND3
         9/vy6DTiTmWPrFhGC75OPyBDkh+1NfhNWdFgWMzTjTKONypvGIM2C0d8W66yFPeCyQyj
         Jg6UeqUwKk2DTcLzh6pIcaJuFJWH1Mzolv5O1zq2LChVy8TA26on1end9iFLKHzBUiXI
         GyaGF1hTZSmqdOxY8UkRCdhzsII6mCWomXv2rlktR1rB+1iLfShlV2HLzQNJjnASRv9e
         PoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0v4QnmomYtLDKkZhTWixIsZmvX5XApJobfyYR5hOCfc=;
        b=fVt6mZfJ+R4XmKt7/y/OM/OfzDhbb8rrWBuGojAKpZvqmz7dHPwGmrhjGq749kX3h7
         FAC7/xIUILhSXlNAljpDNtOPEAyLmspK7OgVifusrrfXJ4dTMf96t/GK3wnm1KSfh766
         qa9i+2dwbRnjvW4VRYbc7I4ZSJFiv6KKU/lXmHpyENhHzL/V0GJzqNxnFqH7ZaPa1+Fy
         03khinyRByUX3emenASMPf/jqqAFpTw1R/YSrD5Ecm1lw0AtD2fi80gt8s0Xr60oowmB
         Sq0/G88Wa5XV3AfEfCcBn89onKu0kNuMHx2/sveYN9WPgQBPYt0isyNJ2fhsC0Z54s9m
         7+8w==
X-Gm-Message-State: ANhLgQ2FTDI2zMPgSb4mNfCJNZ9h9mp5wtOxnVQjRgLXfexu7gbsOYvb
        DQuhrSRwFBilbFuNcB84XXQ=
X-Google-Smtp-Source: ADFU+vulai7dCgQLJ2juEnz/tqmXDdI6J3LO0heHRipXrmcux7MRju1odjsKGukCxj6G+zVm4bw7mQ==
X-Received: by 2002:a17:902:6a84:: with SMTP id n4mr548524plk.294.1583282483035;
        Tue, 03 Mar 2020 16:41:23 -0800 (PST)
Received: from localhost.localdomain ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id f8sm25539697pfn.2.2020.03.03.16.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 16:41:22 -0800 (PST)
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v3] xtensa: replace setup_irq() by request_irq()
Date:   Wed,  4 Mar 2020 06:11:11 +0530
Message-Id: <20200304004112.3848-1-afzal.mohd.ma@gmail.com>
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
Hi Max Filippov,

i believe you are the maintainer of xtensa, if you are okay w/ this change,
please consider taking it thr' your tree, else please let me know.

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

 arch/xtensa/kernel/smp.c  |  8 ++------
 arch/xtensa/kernel/time.c | 12 +++++-------
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
index 83b244ce61ee..cd85a7a2722b 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -53,16 +53,12 @@ static void system_flush_invalidate_dcache_range(unsigned long start,
 #define IPI_IRQ	0
 
 static irqreturn_t ipi_interrupt(int irq, void *dev_id);
-static struct irqaction ipi_irqaction = {
-	.handler =	ipi_interrupt,
-	.flags =	IRQF_PERCPU,
-	.name =		"ipi",
-};
 
 void ipi_init(void)
 {
 	unsigned irq = irq_create_mapping(NULL, IPI_IRQ);
-	setup_irq(irq, &ipi_irqaction);
+	if (request_irq(irq, ipi_interrupt, IRQF_PERCPU, "ipi", NULL))
+		pr_err("Failed to request irq %u (ipi)\n", irq);
 }
 
 static inline unsigned int get_core_count(void)
diff --git a/arch/xtensa/kernel/time.c b/arch/xtensa/kernel/time.c
index 69db8c93c1f9..77971fe4cc95 100644
--- a/arch/xtensa/kernel/time.c
+++ b/arch/xtensa/kernel/time.c
@@ -128,12 +128,6 @@ static irqreturn_t timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction timer_irqaction = {
-	.handler =	timer_interrupt,
-	.flags =	IRQF_TIMER,
-	.name =		"timer",
-};
-
 void local_timer_setup(unsigned cpu)
 {
 	struct ccount_timer *timer = &per_cpu(ccount_timer, cpu);
@@ -184,6 +178,8 @@ static inline void calibrate_ccount(void)
 
 void __init time_init(void)
 {
+	int irq;
+
 	of_clk_init(NULL);
 #ifdef CONFIG_XTENSA_CALIBRATE_CCOUNT
 	pr_info("Calibrating CPU frequency ");
@@ -199,7 +195,9 @@ void __init time_init(void)
 	     __func__);
 	clocksource_register_hz(&ccount_clocksource, ccount_freq);
 	local_timer_setup(0);
-	setup_irq(this_cpu_ptr(&ccount_timer)->evt.irq, &timer_irqaction);
+	irq = this_cpu_ptr(&ccount_timer)->evt.irq;
+	if (request_irq(irq, timer_interrupt, IRQF_TIMER, "timer", NULL))
+		pr_err("Failed to request irq %d (timer)\n", irq);
 	sched_clock_register(ccount_sched_clock_read, 32, ccount_freq);
 	timer_probe();
 }
-- 
2.25.1

