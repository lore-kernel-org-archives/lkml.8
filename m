Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E73C2D0EB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 19:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8122D20781
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 19:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgC2TGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 15:06:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56825 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbgC2TGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 15:06:38 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIdGU-0000m8-0o; Sun, 29 Mar 2020 21:06:34 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 49A781C04D7;
        Sun, 29 Mar 2020 21:06:33 +0200 (CEST)
Date:   Sun, 29 Mar 2020 19:06:32 -0000
From:   "tip-bot2 for afzal mohammed" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] alpha: Replace setup_irq() by request_irq()
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Turner <mattst88@gmail.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3C51f8ae7da9f47a23596388141933efa2bdef317b=2E15853?=
 =?utf-8?q?20721=2Egit=2Eafzal=2Emohd=2Ema=40gmail=2Ecom=3E?=
References: =?utf-8?q?=3C51f8ae7da9f47a23596388141933efa2bdef317b=2E158532?=
 =?utf-8?q?0721=2Egit=2Eafzal=2Emohd=2Ema=40gmail=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <158550879289.28353.10584853322434505856.tip-bot2@tip-bot2>
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

Commit-ID:     82c849eb36fe6dcfa955b25c7aad71b5c1b4403c
Gitweb:        https://git.kernel.org/tip/82c849eb36fe6dcfa955b25c7aad71b5c1b4403c
Author:        afzal mohammed <afzal.mohd.ma@gmail.com>
AuthorDate:    Fri, 27 Mar 2020 21:39:01 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 29 Mar 2020 21:03:41 +02:00

alpha: Replace setup_irq() by request_irq()

request_irq() is preferred over setup_irq(). Invocations of setup_irq()
occur after memory allocators are ready.

setup_irq() was required in older kernels as the memory allocator was not
available during early boot.

Hence replace setup_irq() by request_irq().

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Matt Turner <mattst88@gmail.com>
Link: https://lkml.kernel.org/r/51f8ae7da9f47a23596388141933efa2bdef317b.1585320721.git.afzal.mohd.ma@gmail.com

---
 arch/alpha/kernel/irq_alpha.c     | 29 +++++------------------------
 arch/alpha/kernel/irq_i8259.c     |  8 ++------
 arch/alpha/kernel/irq_impl.h      |  7 +------
 arch/alpha/kernel/irq_pyxis.c     |  3 ++-
 arch/alpha/kernel/sys_alcor.c     |  3 ++-
 arch/alpha/kernel/sys_cabriolet.c |  3 ++-
 arch/alpha/kernel/sys_eb64p.c     |  3 ++-
 arch/alpha/kernel/sys_marvel.c    |  2 +-
 arch/alpha/kernel/sys_miata.c     |  6 ++++--
 arch/alpha/kernel/sys_ruffian.c   |  3 ++-
 arch/alpha/kernel/sys_rx164.c     |  3 ++-
 arch/alpha/kernel/sys_sx164.c     |  3 ++-
 arch/alpha/kernel/sys_wildfire.c  |  7 ++-----
 arch/alpha/kernel/time.c          |  6 ++----
 14 files changed, 31 insertions(+), 55 deletions(-)

diff --git a/arch/alpha/kernel/irq_alpha.c b/arch/alpha/kernel/irq_alpha.c
index da3e10d..d17e44c 100644
--- a/arch/alpha/kernel/irq_alpha.c
+++ b/arch/alpha/kernel/irq_alpha.c
@@ -213,32 +213,13 @@ process_mcheck_info(unsigned long vector, unsigned long la_ptr,
  * The special RTC interrupt type.  The interrupt itself was
  * processed by PALcode, and comes in via entInt vector 1.
  */
-
-struct irqaction timer_irqaction = {
-	.handler	= rtc_timer_interrupt,
-	.name		= "timer",
-};
-
 void __init
-init_rtc_irq(void)
+init_rtc_irq(irq_handler_t handler)
 {
 	irq_set_chip_and_handler_name(RTC_IRQ, &dummy_irq_chip,
 				      handle_percpu_irq, "RTC");
-	setup_irq(RTC_IRQ, &timer_irqaction);
+	if (!handler)
+		handler = rtc_timer_interrupt;
+	if (request_irq(RTC_IRQ, handler, 0, "timer", NULL))
+		pr_err("Failed to register timer interrupt\n");
 }
-
-/* Dummy irqactions.  */
-struct irqaction isa_cascade_irqaction = {
-	.handler	= no_action,
-	.name		= "isa-cascade"
-};
-
-struct irqaction timer_cascade_irqaction = {
-	.handler	= no_action,
-	.name		= "timer-cascade"
-};
-
-struct irqaction halt_switch_irqaction = {
-	.handler	= no_action,
-	.name		= "halt-switch"
-};
diff --git a/arch/alpha/kernel/irq_i8259.c b/arch/alpha/kernel/irq_i8259.c
index 5d54c07..1dcf0d9 100644
--- a/arch/alpha/kernel/irq_i8259.c
+++ b/arch/alpha/kernel/irq_i8259.c
@@ -82,11 +82,6 @@ struct irq_chip i8259a_irq_type = {
 void __init
 init_i8259a_irqs(void)
 {
-	static struct irqaction cascade = {
-		.handler	= no_action,
-		.name		= "cascade",
-	};
-
 	long i;
 
 	outb(0xff, 0x21);	/* mask all of 8259A-1 */
@@ -96,7 +91,8 @@ init_i8259a_irqs(void)
 		irq_set_chip_and_handler(i, &i8259a_irq_type, handle_level_irq);
 	}
 
-	setup_irq(2, &cascade);
+	if (request_irq(2, no_action, 0, "cascade", NULL))
+		pr_err("Failed to request irq 2 (cascade)\n");
 }
 
 
diff --git a/arch/alpha/kernel/irq_impl.h b/arch/alpha/kernel/irq_impl.h
index 16f2b02..fbf2189 100644
--- a/arch/alpha/kernel/irq_impl.h
+++ b/arch/alpha/kernel/irq_impl.h
@@ -21,14 +21,9 @@ extern void isa_no_iack_sc_device_interrupt(unsigned long);
 extern void srm_device_interrupt(unsigned long);
 extern void pyxis_device_interrupt(unsigned long);
 
-extern struct irqaction timer_irqaction;
-extern struct irqaction isa_cascade_irqaction;
-extern struct irqaction timer_cascade_irqaction;
-extern struct irqaction halt_switch_irqaction;
-
 extern void init_srm_irqs(long, unsigned long);
 extern void init_pyxis_irqs(unsigned long);
-extern void init_rtc_irq(void);
+extern void init_rtc_irq(irq_handler_t  handler);
 
 extern void common_init_isa_dma(void);
 
diff --git a/arch/alpha/kernel/irq_pyxis.c b/arch/alpha/kernel/irq_pyxis.c
index a968b10..27070b5 100644
--- a/arch/alpha/kernel/irq_pyxis.c
+++ b/arch/alpha/kernel/irq_pyxis.c
@@ -107,5 +107,6 @@ init_pyxis_irqs(unsigned long ignore_mask)
 		irq_set_status_flags(i, IRQ_LEVEL);
 	}
 
-	setup_irq(16+7, &isa_cascade_irqaction);
+	if (request_irq(16 + 7, no_action, 0, "isa-cascade", NULL))
+		pr_err("Failed to register isa-cascade interrupt\n");
 }
diff --git a/arch/alpha/kernel/sys_alcor.c b/arch/alpha/kernel/sys_alcor.c
index e56efd5..ce54300 100644
--- a/arch/alpha/kernel/sys_alcor.c
+++ b/arch/alpha/kernel/sys_alcor.c
@@ -133,7 +133,8 @@ alcor_init_irq(void)
 	init_i8259a_irqs();
 	common_init_isa_dma();
 
-	setup_irq(16+31, &isa_cascade_irqaction);
+	if (request_irq(16 + 31, no_action, 0, "isa-cascade", NULL))
+		pr_err("Failed to register isa-cascade interrupt\n");
 }
 
 
diff --git a/arch/alpha/kernel/sys_cabriolet.c b/arch/alpha/kernel/sys_cabriolet.c
index 10bc46a..0aa6a27 100644
--- a/arch/alpha/kernel/sys_cabriolet.c
+++ b/arch/alpha/kernel/sys_cabriolet.c
@@ -112,7 +112,8 @@ common_init_irq(void (*srm_dev_int)(unsigned long v))
 	}
 
 	common_init_isa_dma();
-	setup_irq(16+4, &isa_cascade_irqaction);
+	if (request_irq(16 + 4, no_action, 0, "isa-cascade", NULL))
+		pr_err("Failed to register isa-cascade interrupt\n");
 }
 
 #ifndef CONFIG_ALPHA_PC164
diff --git a/arch/alpha/kernel/sys_eb64p.c b/arch/alpha/kernel/sys_eb64p.c
index 5251937..1cdfe55 100644
--- a/arch/alpha/kernel/sys_eb64p.c
+++ b/arch/alpha/kernel/sys_eb64p.c
@@ -123,7 +123,8 @@ eb64p_init_irq(void)
 	}
 
 	common_init_isa_dma();
-	setup_irq(16+5, &isa_cascade_irqaction);
+	if (request_irq(16 + 5, no_action, 0, "isa-cascade", NULL))
+		pr_err("Failed to register isa-cascade interrupt\n");
 }
 
 /*
diff --git a/arch/alpha/kernel/sys_marvel.c b/arch/alpha/kernel/sys_marvel.c
index 8d34cf6..533899a 100644
--- a/arch/alpha/kernel/sys_marvel.c
+++ b/arch/alpha/kernel/sys_marvel.c
@@ -397,7 +397,7 @@ marvel_init_pci(void)
 static void __init
 marvel_init_rtc(void)
 {
-	init_rtc_irq();
+	init_rtc_irq(NULL);
 }
 
 static void
diff --git a/arch/alpha/kernel/sys_miata.c b/arch/alpha/kernel/sys_miata.c
index 6fa07dc..702292a 100644
--- a/arch/alpha/kernel/sys_miata.c
+++ b/arch/alpha/kernel/sys_miata.c
@@ -81,8 +81,10 @@ miata_init_irq(void)
 	init_pyxis_irqs(0x63b0000);
 
 	common_init_isa_dma();
-	setup_irq(16+2, &halt_switch_irqaction);	/* SRM only? */
-	setup_irq(16+6, &timer_cascade_irqaction);
+	if (request_irq(16 + 2, no_action, 0, "halt-switch", NULL))
+		pr_err("Failed to register halt-switch interrupt\n");
+	if (request_irq(16 + 6, no_action, 0, "timer-cascade", NULL))
+		pr_err("Failed to register timer-cascade interrupt\n");
 }
 
 
diff --git a/arch/alpha/kernel/sys_ruffian.c b/arch/alpha/kernel/sys_ruffian.c
index 07830cc..d330740 100644
--- a/arch/alpha/kernel/sys_ruffian.c
+++ b/arch/alpha/kernel/sys_ruffian.c
@@ -82,7 +82,8 @@ ruffian_init_rtc(void)
 	outb(0x31, 0x42);
 	outb(0x13, 0x42);
 
-	setup_irq(0, &timer_irqaction);
+	if (request_irq(0, rtc_timer_interrupt, 0, "timer", NULL))
+		pr_err("Failed to request irq 0 (timer)\n");
 }
 
 static void
diff --git a/arch/alpha/kernel/sys_rx164.c b/arch/alpha/kernel/sys_rx164.c
index a3db719..4d85eae 100644
--- a/arch/alpha/kernel/sys_rx164.c
+++ b/arch/alpha/kernel/sys_rx164.c
@@ -106,7 +106,8 @@ rx164_init_irq(void)
 	init_i8259a_irqs();
 	common_init_isa_dma();
 
-	setup_irq(16+20, &isa_cascade_irqaction);
+	if (request_irq(16 + 20, no_action, 0, "isa-cascade", NULL))
+		pr_err("Failed to register isa-cascade interrupt\n");
 }
 
 
diff --git a/arch/alpha/kernel/sys_sx164.c b/arch/alpha/kernel/sys_sx164.c
index 1ec638a..17cc203 100644
--- a/arch/alpha/kernel/sys_sx164.c
+++ b/arch/alpha/kernel/sys_sx164.c
@@ -54,7 +54,8 @@ sx164_init_irq(void)
 	else
 		init_pyxis_irqs(0xff00003f0000UL);
 
-	setup_irq(16+6, &timer_cascade_irqaction);
+	if (request_irq(16 + 6, no_action, 0, "timer-cascade", NULL))
+		pr_err("Failed to register timer-cascade interrupt\n");
 }
 
 /*
diff --git a/arch/alpha/kernel/sys_wildfire.c b/arch/alpha/kernel/sys_wildfire.c
index 8e64052..2191bde 100644
--- a/arch/alpha/kernel/sys_wildfire.c
+++ b/arch/alpha/kernel/sys_wildfire.c
@@ -156,10 +156,6 @@ static void __init
 wildfire_init_irq_per_pca(int qbbno, int pcano)
 {
 	int i, irq_bias;
-	static struct irqaction isa_enable = {
-		.handler	= no_action,
-		.name		= "isa_enable",
-	};
 
 	irq_bias = qbbno * (WILDFIRE_PCA_PER_QBB * WILDFIRE_IRQ_PER_PCA)
 		 + pcano * WILDFIRE_IRQ_PER_PCA;
@@ -198,7 +194,8 @@ wildfire_init_irq_per_pca(int qbbno, int pcano)
 		irq_set_status_flags(i + irq_bias, IRQ_LEVEL);
 	}
 
-	setup_irq(32+irq_bias, &isa_enable);
+	if (request_irq(32 + irq_bias, no_action, 0, "isa_enable", NULL))
+		pr_err("Failed to register isa_enable interrupt\n");
 }
 
 static void __init
diff --git a/arch/alpha/kernel/time.c b/arch/alpha/kernel/time.c
index 0069360..4d01c39 100644
--- a/arch/alpha/kernel/time.c
+++ b/arch/alpha/kernel/time.c
@@ -242,7 +242,7 @@ common_init_rtc(void)
 	outb(0x31, 0x42);
 	outb(0x13, 0x42);
 
-	init_rtc_irq();
+	init_rtc_irq(NULL);
 }
 
 
@@ -396,9 +396,7 @@ time_init(void)
 	if (alpha_using_qemu) {
 		clocksource_register_hz(&qemu_cs, NSEC_PER_SEC);
 		init_qemu_clockevent();
-
-		timer_irqaction.handler = qemu_timer_interrupt;
-		init_rtc_irq();
+		init_rtc_irq(qemu_timer_interrupt);
 		return;
 	}
 
