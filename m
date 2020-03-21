Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162C2C4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 14:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2EB920658
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 14:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgCUOWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 10:22:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38662 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbgCUOWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 10:22:01 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFf0f-0003yd-2p; Sat, 21 Mar 2020 15:21:57 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A48A51C1CA2;
        Sat, 21 Mar 2020 15:21:56 +0100 (CET)
Date:   Sat, 21 Mar 2020 14:21:56 -0000
From:   "tip-bot2 for afzal mohammed" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: Replace setup_irq() by request_irq()
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3C17f85021f6877650a5b09e0212d88323e6a30fd0=2E15824?=
 =?utf-8?q?71508=2Egit=2Eafzal=2Emohd=2Ema=40gmail=2Ecom=3E?=
References: =?utf-8?q?=3C17f85021f6877650a5b09e0212d88323e6a30fd0=2E158247?=
 =?utf-8?q?1508=2Egit=2Eafzal=2Emohd=2Ema=40gmail=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <158480051619.28353.14186528712410718742.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     4dd2a1b92b91b5f2acf853ee1dc0df135054698f
Gitweb:        https://git.kernel.org/tip/4dd2a1b92b91b5f2acf853ee1dc0df135054698f
Author:        afzal mohammed <afzal.mohd.ma@gmail.com>
AuthorDate:    Mon, 24 Feb 2020 06:22:26 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 21 Mar 2020 15:15:47 +01:00

x86: Replace setup_irq() by request_irq()

request_irq() is preferred over setup_irq(). The early boot setup_irq()
invocations happen either via 'init_IRQ()' or 'time_init()', while
memory allocators are ready by 'mm_init()'.

setup_irq() was required in old kernels when allocators were not ready by
the time early interrupts were initialized.

Hence replace setup_irq() by request_irq().

[ tglx: Use a local variable and get rid of the line break. Tweak the
  	comment a bit ]

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/17f85021f6877650a5b09e0212d88323e6a30fd0.1582471508.git.afzal.mohd.ma@gmail.com

---
 arch/x86/kernel/irqinit.c | 16 +++++-----------
 arch/x86/kernel/time.c    | 15 ++++++---------
 2 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/irqinit.c b/arch/x86/kernel/irqinit.c
index 1e5ad12..5aa523c 100644
--- a/arch/x86/kernel/irqinit.c
+++ b/arch/x86/kernel/irqinit.c
@@ -44,15 +44,6 @@
  * (these are usually mapped into the 0x30-0xff vector range)
  */
 
-/*
- * IRQ2 is cascade interrupt to second interrupt controller
- */
-static struct irqaction irq2 = {
-	.handler = no_action,
-	.name = "cascade",
-	.flags = IRQF_NO_THREAD,
-};
-
 DEFINE_PER_CPU(vector_irq_t, vector_irq) = {
 	[0 ... NR_VECTORS - 1] = VECTOR_UNUSED,
 };
@@ -104,6 +95,9 @@ void __init native_init_IRQ(void)
 	idt_setup_apic_and_irq_gates();
 	lapic_assign_system_vectors();
 
-	if (!acpi_ioapic && !of_ioapic && nr_legacy_irqs())
-		setup_irq(2, &irq2);
+	if (!acpi_ioapic && !of_ioapic && nr_legacy_irqs()) {
+		/* IRQ2 is cascade interrupt to second interrupt controller */
+		if (request_irq(2, no_action, IRQF_NO_THREAD, "cascade", NULL))
+			pr_err("%s: request_irq() failed\n", "cascade");
+	}
 }
diff --git a/arch/x86/kernel/time.c b/arch/x86/kernel/time.c
index d8673d8..8c5213e 100644
--- a/arch/x86/kernel/time.c
+++ b/arch/x86/kernel/time.c
@@ -62,19 +62,16 @@ static irqreturn_t timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction irq0  = {
-	.handler = timer_interrupt,
-	.flags = IRQF_NOBALANCING | IRQF_IRQPOLL | IRQF_TIMER,
-	.name = "timer"
-};
-
 static void __init setup_default_timer_irq(void)
 {
+	unsigned long flags = IRQF_NOBALANCING | IRQF_IRQPOLL | IRQF_TIMER;
+
 	/*
-	 * Unconditionally register the legacy timer; even without legacy
-	 * PIC/PIT we need this for the HPET0 in legacy replacement mode.
+	 * Unconditionally register the legacy timer interrupt; even
+	 * without legacy PIC/PIT we need this for the HPET0 in legacy
+	 * replacement mode.
 	 */
-	if (setup_irq(0, &irq0))
+	if (request_irq(0, timer_interrupt, flags, "timer", NULL))
 		pr_info("Failed to register legacy timer interrupt\n");
 }
 
