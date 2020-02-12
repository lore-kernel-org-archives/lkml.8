Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672FEC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A9A206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQNVJZH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgBLICf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:02:35 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45045 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgBLICf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:02:35 -0500
Received: by mail-pf1-f193.google.com with SMTP id y5so822723pfb.11;
        Wed, 12 Feb 2020 00:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mc2dpv581ToIkk+a3WeQqZxxfWJkiHoH2SJ2prBaVpc=;
        b=NQNVJZH/P88kbkRnHmGdNwoXRJFNslK1GyfXCckDOIOseGxQId6SviVXpjk6ItHg4j
         jK+G7pDoHY9yjneeUo1BShSzFiW6Nwm77EAXjd6oy6wqviRFwTMRRgvK+slFu1HHns2O
         Cs3Pw1cvICbZQwAlCZbeZ6Tg3tCv0P/eNvoHAogoYROziBtjzaEJgocpVsbpSjhSB3cp
         OAZq5x37Owjgy27WzKOSiIwkFOexAbHq/5RP243a9r9hStvI8DF+Ih59a5YHRyP7eP/Q
         XzOLjoe7753tuVGRHL+q+Zb0zSYKovdleGkBJoka+2URmw1aSeZxiJp7bhkVG+Tws2MV
         2RzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mc2dpv581ToIkk+a3WeQqZxxfWJkiHoH2SJ2prBaVpc=;
        b=F7wx32HvVRKbIBFmrftNEc7CbLw4DxZnV61llY3lleNRofxjTInw4b2W5+mc/pNINy
         BUjOUNanhWjbkHU+fAUQTt1oaZknKJQqGCF/nHlD30QIVgo/91ZelNXPDLcMjAQwFE0V
         p6hrb9mRF+44Kqs3yl/xANQ/OQi2BMtzRsb7djSoemWhBYdQ63Vd6jzDoDmBUVbx/Tw2
         MLCNHoEe2VBBJ60v9nEWbvOhWkUZr65JiVxXA09YnKU0y59wWKpxCLhIQqrYBvkBQQ0G
         4A+Gp+n618Bp6xm9YDirNqkCZSmdq8pv5BroJ08oe3YCchnYfVnwagtA0aDHtzLFrb7A
         ea2g==
X-Gm-Message-State: APjAAAUOouh1m1uJLTwJA4jFwRdRqqia+QoyDYwvoVxo9wygyGcjRWWh
        0GVkbnGaVypA4moaL9Jteomq/UFm
X-Google-Smtp-Source: APXvYqy/lNV+jiLuWlDfraKQ/fgvZGONDS/zVzTNo31fr/COxn8AhGP5xw4s9lhLsqPuOcnnmpNj9Q==
X-Received: by 2002:a62:1402:: with SMTP id 2mr7387521pfu.126.1581494552022;
        Wed, 12 Feb 2020 00:02:32 -0800 (PST)
Received: from localhost ([106.51.21.91])
        by smtp.gmail.com with ESMTPSA id w5sm2200288pfc.24.2020.02.12.00.02.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 00:02:31 -0800 (PST)
Date:   Wed, 12 Feb 2020 13:32:29 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Turner <mattst88@gmail.com>
Subject: [PATCH 01/18] alpha: replace setup_irq() by request_irq()
Message-ID: <4f69d778a2bcf2cff76d59abd5adcac40329be0c.1581478324.git.afzal.mohd.ma@gmail.com>
References: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_irq() is preferred over setup_irq(). Existing callers of
setup_irq() reached mostly via 'init_IRQ()' & 'time_init()', while
memory allocators are ready by 'mm_init()'.

Per tglx[1], setup_irq() existed in olden days when allocators were not
ready by the time early interrupts were initialized.

Hence replace setup_irq() by request_irq().

Seldom remove_irq() usage has been observed coupled with setup_irq(),
wherever that has been found, it too has been replaced by free_irq().

[1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---

Since cc'ing cover letter to all maintainers/reviewers would be too
many, refer for cover letter,
 https://lkml.kernel.org/r/cover.1581478323.git.afzal.mohd.ma@gmail.com

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
index da3e10d5f7fe..fe46a7bdbf68 100644
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
+init_rtc_irq(irqreturn_t handler)
 {
 	irq_set_chip_and_handler_name(RTC_IRQ, &dummy_irq_chip,
 				      handle_percpu_irq, "RTC");
-	setup_irq(RTC_IRQ, &timer_irqaction);
+	if (!handler)
+		handler = rtc_timer_interrupt;
+	if (request_irq(RTC_IRQ, handler, 0, "timer", NULL))
+		pr_err("request_irq() for %s failed\n", "timer");
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
index 5d54c076a8ae..29e03a2773b3 100644
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
+		pr_err("request_irq() on %s failed\n", "cascade");
 }
 
 
diff --git a/arch/alpha/kernel/irq_impl.h b/arch/alpha/kernel/irq_impl.h
index 16f2b0276f3a..7ac58be4ccf4 100644
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
+extern void init_rtc_irq(irqreturn_t handler);
 
 extern void common_init_isa_dma(void);
 
diff --git a/arch/alpha/kernel/irq_pyxis.c b/arch/alpha/kernel/irq_pyxis.c
index a968b10e687d..41b613f44da0 100644
--- a/arch/alpha/kernel/irq_pyxis.c
+++ b/arch/alpha/kernel/irq_pyxis.c
@@ -107,5 +107,6 @@ init_pyxis_irqs(unsigned long ignore_mask)
 		irq_set_status_flags(i, IRQ_LEVEL);
 	}
 
-	setup_irq(16+7, &isa_cascade_irqaction);
+	if (request_irq(16 + 7, no_action, 0, "isa-cascade", NULL))
+		pr_err("request_irq() for %s failed\n", "isa-cascade");
 }
diff --git a/arch/alpha/kernel/sys_alcor.c b/arch/alpha/kernel/sys_alcor.c
index e56efd5b855f..2db834bf7a84 100644
--- a/arch/alpha/kernel/sys_alcor.c
+++ b/arch/alpha/kernel/sys_alcor.c
@@ -133,7 +133,8 @@ alcor_init_irq(void)
 	init_i8259a_irqs();
 	common_init_isa_dma();
 
-	setup_irq(16+31, &isa_cascade_irqaction);
+	if (request_irq(16 + 31, no_action, 0, "isa-cascade", NULL))
+		pr_err("request_irq() for %s failed\n", "isa-cascade");
 }
 
 
diff --git a/arch/alpha/kernel/sys_cabriolet.c b/arch/alpha/kernel/sys_cabriolet.c
index 10bc46a4ec40..3d4ee60ca930 100644
--- a/arch/alpha/kernel/sys_cabriolet.c
+++ b/arch/alpha/kernel/sys_cabriolet.c
@@ -112,7 +112,8 @@ common_init_irq(void (*srm_dev_int)(unsigned long v))
 	}
 
 	common_init_isa_dma();
-	setup_irq(16+4, &isa_cascade_irqaction);
+	if (request_irq(16 + 4, no_action, 0, "isa-cascade", NULL))
+		pr_err("request_irq() for %s failed\n", "isa-cascade");
 }
 
 #ifndef CONFIG_ALPHA_PC164
diff --git a/arch/alpha/kernel/sys_eb64p.c b/arch/alpha/kernel/sys_eb64p.c
index 5251937ec1b4..6c7f15703dad 100644
--- a/arch/alpha/kernel/sys_eb64p.c
+++ b/arch/alpha/kernel/sys_eb64p.c
@@ -123,7 +123,8 @@ eb64p_init_irq(void)
 	}
 
 	common_init_isa_dma();
-	setup_irq(16+5, &isa_cascade_irqaction);
+	if (request_irq(16 + 5, no_action, 0, "isa-cascade", NULL))
+		pr_err("request_irq() for %s failed\n", "isa-cascade");
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
index 6fa07dc5339d..edff228ae451 100644
--- a/arch/alpha/kernel/sys_miata.c
+++ b/arch/alpha/kernel/sys_miata.c
@@ -81,8 +81,10 @@ miata_init_irq(void)
 	init_pyxis_irqs(0x63b0000);
 
 	common_init_isa_dma();
-	setup_irq(16+2, &halt_switch_irqaction);	/* SRM only? */
-	setup_irq(16+6, &timer_cascade_irqaction);
+	if (request_irq(16 + 2, no_action, 0, "halt-switch", NULL))
+		pr_err("request_irq() for %s failed\n", "halt-switch");
+	if (request_irq(16 + 6, no_action, 0, "timer-cascade", NULL))
+		pr_err("request_irq() for %s failed\n", "timer-cascade");
 }
 
 
diff --git a/arch/alpha/kernel/sys_ruffian.c b/arch/alpha/kernel/sys_ruffian.c
index 07830cccabf9..f2ff64b6553e 100644
--- a/arch/alpha/kernel/sys_ruffian.c
+++ b/arch/alpha/kernel/sys_ruffian.c
@@ -82,7 +82,8 @@ ruffian_init_rtc(void)
 	outb(0x31, 0x42);
 	outb(0x13, 0x42);
 
-	setup_irq(0, &timer_irqaction);
+	if (request_irq(0, rtc_timer_interrupt, 0, "timer", NULL))
+		pr_err("request_irq() for %s failed\n", "timer");
 }
 
 static void
diff --git a/arch/alpha/kernel/sys_rx164.c b/arch/alpha/kernel/sys_rx164.c
index a3db719d3c38..46c3bd7ed910 100644
--- a/arch/alpha/kernel/sys_rx164.c
+++ b/arch/alpha/kernel/sys_rx164.c
@@ -106,7 +106,8 @@ rx164_init_irq(void)
 	init_i8259a_irqs();
 	common_init_isa_dma();
 
-	setup_irq(16+20, &isa_cascade_irqaction);
+	if (request_irq(16 + 20, no_action, 0, "isa-cascade", NULL))
+		pr_err("request_irq() for %s failed\n", "isa-cascade");
 }
 
 
diff --git a/arch/alpha/kernel/sys_sx164.c b/arch/alpha/kernel/sys_sx164.c
index 1ec638a2746a..f6f85b2a9c96 100644
--- a/arch/alpha/kernel/sys_sx164.c
+++ b/arch/alpha/kernel/sys_sx164.c
@@ -54,7 +54,8 @@ sx164_init_irq(void)
 	else
 		init_pyxis_irqs(0xff00003f0000UL);
 
-	setup_irq(16+6, &timer_cascade_irqaction);
+	if (request_irq(16 + 6, no_action, 0, "timer-cascade", NULL))
+		pr_err("request_irq() for %s failed\n", "timer-cascade");
 }
 
 /*
diff --git a/arch/alpha/kernel/sys_wildfire.c b/arch/alpha/kernel/sys_wildfire.c
index 8e64052811ab..9e0283857ffc 100644
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
+		pr_err("request_irq() on %s failed\n", "isa_enable");
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
2.24.1

