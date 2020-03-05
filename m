Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B51DC3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 13:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4272072A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 13:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r60dpSbI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgCENIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 08:08:51 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:53410 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgCENIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 08:08:51 -0500
Received: by mail-pj1-f68.google.com with SMTP id cx7so2480626pjb.3;
        Thu, 05 Mar 2020 05:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bVBnRKTWMAoJt8jksXDWM1oJP/8GMBvpEQFwQVtFuIY=;
        b=r60dpSbIkHMLtxKIhm+8VCcgW+WOqWPdnuFOaD9pUBjD6hZQTwzEkjKPOlhPBHrNsP
         Mo5y5hTGDuBFAq+AugItAfU+ColTSq53EK5Khq5gJorimNZXxqc4xpthFDzRle8lHaRf
         VQAe1cepgdQy6DHiocLrHJJpna4EeG/IMqKMxoQUmDYr8gThkFMptzji+rXJ32svmt9A
         Q0iRtULEdCog1g0aJnu4da7qnTq/xlKv2Xf3HRmiu5FGLBpLaaeHqAAnHwlzVbsJpOHm
         6ApVQECG4gipJ+MbVcSW+hFG7Bs9z13ZYg/rqhbT0VhZdn4oRJXKWqjHVkQx0F+1+QJz
         /FJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bVBnRKTWMAoJt8jksXDWM1oJP/8GMBvpEQFwQVtFuIY=;
        b=JM2p1PQbYtUGSnNYOKaDetOf5fAcQ7gS+dD1rkI/19Nkl1Vkt5odiBAgAUxtvxgCxn
         WrLBE3O3qtlvZV50gyYIf2B5P+ozbZzSKLjcYneSqe8yy3b2OI32TGOD3RVjKt1iDwEW
         nbsh2C0bfY1ThjdyO88vQP2RiBL71cW2ytYwkVfE1OMPwa0Khpn3V7RCwqn3eEiLiRsF
         g3wJDgDlO3bAgwY+Dvn9Sjd58tjt1vqZCDmIkiA9QuCNadG4gqtffK3vQm7jX1KRS8Km
         eIUqrEkrxExPMgB2PQZw9kh+QQahnAEskCsK3piInO/quOXvkuNH40RTOUkA4NUabWAp
         l7ww==
X-Gm-Message-State: ANhLgQ0hkP7jM4SuLLzu/7OZ/OjgZodvJhKfWIk5ivpJjNAnZl8qstEb
        B/pF/cUBQOoxbQ1umRS7CuXrMXIq
X-Google-Smtp-Source: ADFU+vuS+lQbEoY484SdLMg0+EJFwX19PU7CwNQfP73a9xhYjj7XMFk85KfOdsFKvynPKc+y8/Akog==
X-Received: by 2002:a17:90a:d793:: with SMTP id z19mr8486239pju.40.1583413728753;
        Thu, 05 Mar 2020 05:08:48 -0800 (PST)
Received: from localhost.localdomain ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id x18sm20683829pfo.148.2020.03.05.05.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 05:08:48 -0800 (PST)
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
Subject: [PATCH v4] alpha: Replace setup_irq() by request_irq()
Date:   Thu,  5 Mar 2020 18:38:41 +0530
Message-Id: <20200305130843.17989-1-afzal.mohd.ma@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200304005209.5636-1-afzal.mohd.ma@gmail.com>
References: <20200304005209.5636-1-afzal.mohd.ma@gmail.com>
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
Hi alpha maintainers,

if okay w/ this change, please consider taking it thr' your tree, else please
let me know.

Regards
afzal

Link to v3, v2 & v1,
[v3] https://lkml.kernel.org/r/20200304005209.5636-1-afzal.mohd.ma@gmail.com
[v2] https://lkml.kernel.org/r/cover.1582471508.git.afzal.mohd.ma@gmail.com
[v1] https://lkml.kernel.org/r/cover.1581478323.git.afzal.mohd.ma@gmail.com

v4:
 * Fix build error @ init_rtc_irq arg
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
index da3e10d5f7fe..d17e44c99df9 100644
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
index 5d54c076a8ae..1dcf0d9038fd 100644
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
index 16f2b0276f3a..fbf21892e66d 100644
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
index a968b10e687d..27070b5bd33e 100644
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
index e56efd5b855f..ce5430056f65 100644
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
index 10bc46a4ec40..0aa6a27d0e2f 100644
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
index 5251937ec1b4..1cdfe55fb987 100644
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
index 8d34cf6e002a..533899a4a1a1 100644
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
index 6fa07dc5339d..702292af2225 100644
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
index 07830cccabf9..d33074011960 100644
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
index a3db719d3c38..4d85eaeb44aa 100644
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
index 1ec638a2746a..17cc203176c8 100644
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
index 8e64052811ab..2191bde161fd 100644
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
index 0069360697ee..4d01c392ab14 100644
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
 
-- 
2.18.0

