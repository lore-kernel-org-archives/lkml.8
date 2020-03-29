Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F20C2D0E5
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 19:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 502A520781
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 19:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgC2TGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 15:06:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56828 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbgC2TGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 15:06:39 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIdGT-0000m0-BS; Sun, 29 Mar 2020 21:06:33 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4AFAC1C0451;
        Sun, 29 Mar 2020 21:06:32 +0200 (CEST)
Date:   Sun, 29 Mar 2020 19:06:31 -0000
From:   "tip-bot2 for afzal mohammed" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] hexagon: Replace setup_irq() by request_irq()
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3Ce84ac60de8f747d49ce082659e51595f708c29d4=2E15853?=
 =?utf-8?q?20721=2Egit=2Eafzal=2Emohd=2Ema=40gmail=2Ecom=3E?=
References: =?utf-8?q?=3Ce84ac60de8f747d49ce082659e51595f708c29d4=2E158532?=
 =?utf-8?q?0721=2Egit=2Eafzal=2Emohd=2Ema=40gmail=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <158550879196.28353.14074902944041161420.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     45b26ddee6d7d69c1ca41fdc843ac2cadaf4293c
Gitweb:        https://git.kernel.org/tip/45b26ddee6d7d69c1ca41fdc843ac2cadaf4293c
Author:        afzal mohammed <afzal.mohd.ma@gmail.com>
AuthorDate:    Fri, 27 Mar 2020 21:39:50 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 29 Mar 2020 21:03:42 +02:00

hexagon: Replace setup_irq() by request_irq()

request_irq() is preferred over setup_irq(). Invocations of setup_irq()
occur after memory allocators are ready.

setup_irq() was required in older kernels as the memory allocator was not
available during early boot.

Hence replace setup_irq() by request_irq().

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/e84ac60de8f747d49ce082659e51595f708c29d4.1585320721.git.afzal.mohd.ma@gmail.com

---
 arch/hexagon/kernel/smp.c  | 22 +++++++++++-----------
 arch/hexagon/kernel/time.c | 11 +++--------
 2 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/arch/hexagon/kernel/smp.c b/arch/hexagon/kernel/smp.c
index 0bbbe65..619c564 100644
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
index f99e925..feffe52 100644
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
