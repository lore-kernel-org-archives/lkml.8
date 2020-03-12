Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD19C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D808206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvlWQc6W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgCLN1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:27:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45303 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgCLN1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:27:39 -0400
Received: by mail-pl1-f195.google.com with SMTP id b22so2660799pls.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 06:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JKFqhd+nMSKzAdoK7AjT9pTQERNeETS/59Lgbygkk7g=;
        b=OvlWQc6WNDKyowJH9y7kcTign22MgmP0oeefvShUzlLlMI4OJsS/HVZP5lLVLKdOaX
         PUSTrSA/qK7Ylf81hq66/4wLWraG0Ry8kSqXplcY9boO4EBryXKGH1l2XwYCMnB+heDX
         5Ks886ykbbEpB1U0DwnksAHNoP2WgQba7UO2ibSAqONwpzRK/YAJtGS1jdpXCF7UvgWh
         4PIIq+dMMtIyQPpEQRMZ+sLjLuSxEC8l+QyZprGHgFYGb86ECgAb1xV8+Xvsxx73iI3A
         DrsoB5yONwZFvex3s2IZmqYBpbt0VTWJTHYhQdohvi1zVPQ7EC1BNY0bfNsKHWq6Mzvv
         UpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JKFqhd+nMSKzAdoK7AjT9pTQERNeETS/59Lgbygkk7g=;
        b=KC3ffJa43eeuNV0Z/5D8Uo/nuHnX5fHUuqZneaNpiSxFZtL/FIvyoIF+o4NHQ6EcAv
         ERTwpiQIFX81G9rnMrkKCqI8uZLDJmhopo7VKDrAPuw3KnFzHBbaHASteXoOxtp5tTUg
         6/QvBn7u1OfcoMG5Opnp+vD+8a1+15C0NGHMpK5Y4xkmIRp9TSW2RMyCUH8F1cKHDLxc
         gIjAJU3LYMDcbpRv0OhQ18IncdO/gLMVJHoRPNIMbxee0ZLlb+CkjtxvxMTxByI3dp8E
         zzZIOA9r0E/Nc/3Fe/NEFM3thECHI9cmRzSLr0o/1+wInGi1wyNH7Vnz5EjPiBeprArT
         b+fA==
X-Gm-Message-State: ANhLgQ2rt99N+X+yrjpw75LO6gVfNEyRDa5BibcfWDWF4eplZIH2z+A6
        wXIqZqIYv2xIotXUOuaZkVk=
X-Google-Smtp-Source: ADFU+vv1g/KTsOCtkIcpAhvugu4fcEvtCVm20e2j1kQt3LgV/3Qdfaeon9yFI0blBvlDo9PwSbvnig==
X-Received: by 2002:a17:90a:ac05:: with SMTP id o5mr4331961pjq.143.1584019657326;
        Thu, 12 Mar 2020 06:27:37 -0700 (PDT)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id s13sm9204098pjp.1.2020.03.12.06.27.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Mar 2020 06:27:36 -0700 (PDT)
Date:   Thu, 12 Mar 2020 18:57:34 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] ARM: footbridge: replace setup_irq() by request_irq()
Message-ID: <20200312132734.GA5294@afzalpc>
References: <20200301122131.3902-1-afzal.mohd.ma@gmail.com>
 <20200312123432.GZ25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312123432.GZ25745@shell.armlinux.org.uk>
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

v4:
 * Fix build warning in isa-irq.c & ensure no build warnings
v3:
 * Split out from series, also create subarch level patch as Thomas
	suggested to take it thr' respective maintainers
 * Modify string displayed in case of error as suggested by Thomas
 * Re-arrange code as required to improve readability
 * Remove irrelevant parts from commit message & improve
 
v2:
 * Replace pr_err("request_irq() on %s failed" by
           pr_err("%s: request_irq() failed"
 * Commit message massage

 arch/arm/mach-footbridge/dc21285-timer.c | 11 +++--------
 arch/arm/mach-footbridge/isa-irq.c       | 10 ++++------
 arch/arm/mach-footbridge/isa-timer.c     | 11 +++--------
 3 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-footbridge/dc21285-timer.c b/arch/arm/mach-footbridge/dc21285-timer.c
index f76212d2dbf1..2908c9ef3c9b 100644
--- a/arch/arm/mach-footbridge/dc21285-timer.c
+++ b/arch/arm/mach-footbridge/dc21285-timer.c
@@ -101,13 +101,6 @@ static irqreturn_t timer1_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction footbridge_timer_irq = {
-	.name		= "dc21285_timer1",
-	.handler	= timer1_interrupt,
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.dev_id		= &ckevt_dc21285,
-};
-
 /*
  * Set up timer interrupt.
  */
@@ -118,7 +111,9 @@ void __init footbridge_timer_init(void)
 
 	clocksource_register_hz(&cksrc_dc21285, rate);
 
-	setup_irq(ce->irq, &footbridge_timer_irq);
+	if (request_irq(ce->irq, timer1_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
+			"dc21285_timer1", &ckevt_dc21285))
+		pr_err("Failed to request irq %d (dc21285_timer1)", ce->irq);
 
 	ce->cpumask = cpumask_of(smp_processor_id());
 	clockevents_config_and_register(ce, rate, 0x4, 0xffffff);
diff --git a/arch/arm/mach-footbridge/isa-irq.c b/arch/arm/mach-footbridge/isa-irq.c
index 88a553932c33..842ddb4121ef 100644
--- a/arch/arm/mach-footbridge/isa-irq.c
+++ b/arch/arm/mach-footbridge/isa-irq.c
@@ -96,11 +96,6 @@ static void isa_irq_handler(struct irq_desc *desc)
 	generic_handle_irq(isa_irq);
 }
 
-static struct irqaction irq_cascade = {
-	.handler = no_action,
-	.name = "cascade",
-};
-
 static struct resource pic1_resource = {
 	.name	= "pic1",
 	.start	= 0x20,
@@ -160,7 +155,10 @@ void __init isa_init_irq(unsigned int host_irq)
 
 		request_resource(&ioport_resource, &pic1_resource);
 		request_resource(&ioport_resource, &pic2_resource);
-		setup_irq(IRQ_ISA_CASCADE, &irq_cascade);
+
+		irq = IRQ_ISA_CASCADE;
+		if (request_irq(irq, no_action, 0, "cascade", NULL))
+			pr_err("Failed to request irq %u (cascade)\n", irq);
 
 		irq_set_chained_handler(host_irq, isa_irq_handler);
 
diff --git a/arch/arm/mach-footbridge/isa-timer.c b/arch/arm/mach-footbridge/isa-timer.c
index 82f45591fb2c..723e3eae995d 100644
--- a/arch/arm/mach-footbridge/isa-timer.c
+++ b/arch/arm/mach-footbridge/isa-timer.c
@@ -25,17 +25,12 @@ static irqreturn_t pit_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction pit_timer_irq = {
-	.name		= "pit",
-	.handler	= pit_timer_interrupt,
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.dev_id		= &i8253_clockevent,
-};
-
 void __init isa_timer_init(void)
 {
 	clocksource_i8253_init();
 
-	setup_irq(i8253_clockevent.irq, &pit_timer_irq);
+	if (request_irq(i8253_clockevent.irq, pit_timer_interrupt,
+			IRQF_TIMER | IRQF_IRQPOLL, "pit", &i8253_clockevent))
+		pr_err("Failed to request irq %d(pit)\n", i8253_clockevent.irq);
 	clockevent_i8253_init(false);
 }
-- 
2.25.1

