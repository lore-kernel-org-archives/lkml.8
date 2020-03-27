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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4A5C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DAC20716
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+apzql9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgC0QJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 12:09:06 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34531 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbgC0QJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:09:05 -0400
Received: by mail-pj1-f65.google.com with SMTP id q16so4468696pje.1;
        Fri, 27 Mar 2020 09:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mesk2HVij+c+fu2GkmOK5sU6Y2qdFicQXPWh0pOAesQ=;
        b=n+apzql9bfX0wpUo9zsugctm/PUIs03xfNe2tKLVfxmX1QcTcZFFlU5e7egiKQZkis
         o6cETMt6dRJJAYzUw8eIaBk2NHIXYZouf7CQuKnfRJKoPxvTLyLC55D/Rj0KgL97MUqN
         vhYviCfBXMRqtVjCe0L96olyIngkpzsQ4V3iWRQmerYzv3Tjd8e0qOofkXMhl/3BUXsN
         sN4TPoiXwmXAlwT8DsGilAfEvjrmuonVqiOrqqdXL1TvdqtTPhSQm4wWuKsyVr+fHg+f
         ajsmFJhr9jeIRVmMZteh9m0CWG6GCZ6pxp6pWbSvdUwCsdLNdduccXnn1xZ5f4hriKCR
         Lg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mesk2HVij+c+fu2GkmOK5sU6Y2qdFicQXPWh0pOAesQ=;
        b=EHwlNUbnoSfUMpqjeXHIG7oj22u5x7Mo2PO8iHG6jNJ+/mjypaCqdrgZT5KgXRRMaP
         lOJ9zD3R2RzOeIDjIJ3we3Wi8jifpgRgQWdOqAMe1ATDUbZ0kzS/5AjQ6B1miPOH3U+T
         lzs1iq0t/t3IqzFsxKVMjleHs9bpZmc1lr+l2q0bq+CrO3c+Z+M5UAwbS+IYi/DKlyAp
         4BHYBcDKU4ereQ1MgDStZDCZ/zGd0Rk1Khf+TEZ/razYKQqGAQfmJwyUjwQG3Yk15o58
         T3oKgqcJNXiP9Er6y995o3smkbbEDBIcQvAMelBxG8irRq3EA7ONG0wjmI+xhR9XnHLg
         DLFg==
X-Gm-Message-State: ANhLgQ1+dPA20TkM9r7lQLfO9KpJPlxVrvrvr6sxeYbpjKrIYCUg/ml4
        DU7nKYutuLbCZT1viUSGBanJ0ckZ
X-Google-Smtp-Source: ADFU+vvL4aq/3zYP3a8H9W3S1j5Lt5VqLmPPgyHQtcDYC5hFwmIO7zcA+0+tS0DsupOPRDwWtdg2Tg==
X-Received: by 2002:a17:90a:e983:: with SMTP id v3mr169440pjy.62.1585325343548;
        Fri, 27 Mar 2020 09:09:03 -0700 (PDT)
Received: from localhost ([49.207.55.57])
        by smtp.gmail.com with ESMTPSA id s12sm4201406pgi.38.2020.03.27.09.09.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Mar 2020 09:09:03 -0700 (PDT)
Date:   Fri, 27 Mar 2020 21:39:01 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
Subject: [PATCH v5 1/6] alpha: Replace setup_irq() by request_irq()
Message-ID: <51f8ae7da9f47a23596388141933efa2bdef317b.1585320721.git.afzal.mohd.ma@gmail.com>
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
Acked-by: Matt Turner <mattst88@gmail.com>
---

Link to v4, v3, v2 & v1,
[v4] https://lkml.kernel.org/r/20200305130843.17989-1-afzal.mohd.ma@gmail.com
[v3] https://lkml.kernel.org/r/20200304005209.5636-1-afzal.mohd.ma@gmail.com
[v2] https://lkml.kernel.org/r/cover.1582471508.git.afzal.mohd.ma@gmail.com
[v1] https://lkml.kernel.org/r/cover.1581478323.git.afzal.mohd.ma@gmail.com

v5:
 * Add tag
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
2.25.1

