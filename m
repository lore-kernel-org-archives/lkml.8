Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF998C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7373020737
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wr9w0+2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgC0QJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 12:09:55 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44510 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgC0QJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:09:54 -0400
Received: by mail-pl1-f196.google.com with SMTP id h11so3601135plr.11;
        Fri, 27 Mar 2020 09:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LVnJntLYzH7Zj+TzjtaQCNZBQVMzfV4qtxc28RtRXBk=;
        b=Wr9w0+2+vG5+GIAAsmHkLUkJ67+/v20StxdCIVcNOlCs1QgDja/SK2gi7YgnnMFCGl
         HqSkGV/oGGtS6/1IrxyAh30HL3Qevyj0bxI/wsnJcoeBaVjt5/CrXKItw8oWEJIpR/wr
         3g3N8RNPbovPzgp0anVktMGWqsQpm9BSn/Tb/hKbvCCkUMghQZ8Wu+RilqBmxWr1ThpQ
         kIO1SDJR8ESRGErze6elG3ltPQHVW+2FeN3QzsQkvXiFIIbquieyyw3FfFfF66jUxXNU
         zQ8kzRGG+UPOMyBu3hgdyEGagv1iPbBg3ZwxeQFOASiIOfSbYqfww66+82ms5GFh6CoK
         75aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LVnJntLYzH7Zj+TzjtaQCNZBQVMzfV4qtxc28RtRXBk=;
        b=IQqh73GffAY90wmse+MyW7163J1fIPoHWxSTLHt5Ff+nmtch1EmsmCTizeV6vfSF8M
         AW27r3pkCDjmXwfms+lQ9Vqx6qttvm2gHWeCq3Xs1kuqN7HuTO8vnqeJPK5CPj9P4ItG
         nT9X489g1SseNNUzOcW3lUpKHOLLBYWvwATPKcLGYnJnc1Y+T2dHES4tb3TX1aNO2FMN
         PtSTOAmorc6Y3FTl1EQ8ohfVniQxBQ05gPla2Des4/xgLTT/Jnz2GxaNvG/ZNNpFh6s+
         MElHL5T/TiNmpm1B6lRG5agyZsNi5ywmlupa5s+pbYWCpGMUv3xFyR4tMbpxaGoh5maT
         42dA==
X-Gm-Message-State: ANhLgQ3/6jeNngBBjAH6Va+OWfXbWCOTgvUwnnbfB9xKqs+JMIwer27H
        eEE7ePDwh0XUnXKSsOGb8SE=
X-Google-Smtp-Source: ADFU+vv0QOIrhMO6NfKN1odzXeh1iV4k+Uofu66WworPTXHF22tzwTen4Eqo3yR0XRfHOMzjE4De2w==
X-Received: by 2002:a17:902:9a93:: with SMTP id w19mr13834187plp.277.1585325393014;
        Fri, 27 Mar 2020 09:09:53 -0700 (PDT)
Received: from localhost ([49.207.55.57])
        by smtp.gmail.com with ESMTPSA id l6sm4280981pff.173.2020.03.27.09.09.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Mar 2020 09:09:52 -0700 (PDT)
Date:   Fri, 27 Mar 2020 21:39:50 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/6] hexagon: replace setup_irq() by request_irq()
Message-ID: <e84ac60de8f747d49ce082659e51595f708c29d4.1585320721.git.afzal.mohd.ma@gmail.com>
References: <20200321174303.GA7930@afzalpc>
 <cover.1585320721.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1585320721.git.afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
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

Link to v3, v2 & v1,
[v3] https://lkml.kernel.org/r/20200304004910.4842-1-afzal.mohd.ma@gmail.com
[v2] https://lkml.kernel.org/r/cover.1582471508.git.afzal.mohd.ma@gmail.com
[v1] https://lkml.kernel.org/r/cover.1581478323.git.afzal.mohd.ma@gmail.com

v5:
 * No change
v4:
 * Non-existent
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

