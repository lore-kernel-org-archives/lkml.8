Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1621BC3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 12:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88EC20880
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 12:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViNPVmmL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgCAMVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 07:21:50 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41389 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgCAMVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 07:21:50 -0500
Received: by mail-pl1-f196.google.com with SMTP id t14so3067409plr.8
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 04:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=w0c1c1TYgjKKGwrCeZ2Sljbbbzmh76leW+pgvpNj85Y=;
        b=ViNPVmmLWxxG/CwD68Lub0v7mK66X9tJA70hy1uU8/SPwC6X+9VMTqtZznRl12WxTR
         9wDgN577CZ+EFavhIg89mRV7RrP4stiPWpdlr1q2Qf/LbfZmSwAbFFc/Wi/G9RjNCbvi
         +GaYEy/9aYJNwDrr8mNeBtOr5ecCLNvCNhfqtypZ0v47wRZR1uI8lPDmWRoMoXNqDeOd
         908Bbq/i6tzTrJwWnYRcDmZLSEhRgPr7qp+UkwAauY9NvwU6b2J57Sq72atp0YKXySs0
         Q1FOkmAVvn232wbubQg3qvRLrGpYoxD6weNXmzkNcpXYmcTRi5MhJYxAcFRBtPHinw4e
         SDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w0c1c1TYgjKKGwrCeZ2Sljbbbzmh76leW+pgvpNj85Y=;
        b=Y5ksw7IOs61Po+Lyp7AuGCcR8QIuJpcHQSizHzKsB0HtfHX+5BIylA635gbOZiuu7l
         LYnYcx8Ff9JyQVtNxRAHPqaM2ppsm+GGsy1guy/wQS/a7mcP2YMedRgeOU5w1JHJJIRt
         qv+nBMd/SiRi6ZHpFn54xBcU5Vogn/DSbt15MpI7qJgeACz52FuwzD8d4RhKtCa0/Nub
         9F7fmS4XxfRaN1Kj0ie96iAAivCDlHrZqnwJuPrHId7guPly7AaBzf0Q2vqbVw62eBIY
         R9ao4BSiWtz9WurooJ38z0+hm2wngmkDM2p18XKn6zDkETY6H4fApdKSvxKnNZmasAhO
         QzuA==
X-Gm-Message-State: APjAAAXh6X+uME+5KuWGRrPe5eKNXHzRuRddZ879fZOFshQFN9ZDZckp
        m7OeXNOsS1ZMvLN75Pw27RY=
X-Google-Smtp-Source: APXvYqwMFvJWHsyQrA7KFM/r4/41Gk9jRdjsEvQG+mOPx10nGLsQdSxf9naUiKWaF6kk2cwtz6BvAA==
X-Received: by 2002:a17:90a:c78b:: with SMTP id gn11mr15416280pjb.97.1583065308737;
        Sun, 01 Mar 2020 04:21:48 -0800 (PST)
Received: from localhost.localdomain ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id j21sm8227043pji.13.2020.03.01.04.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 04:21:48 -0800 (PST)
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>
Subject: [PATCH v3] ARM: footbridge: replace setup_irq() by request_irq()
Date:   Sun,  1 Mar 2020 17:51:31 +0530
Message-Id: <20200301122131.3902-1-afzal.mohd.ma@gmail.com>
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
Hi sub-arch maintainers,

If the patch is okay, please take it thr' your tree.

Regards
afzal

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
index 88a553932c33..16c5455199e8 100644
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
@@ -146,6 +141,8 @@ void __init isa_init_irq(unsigned int host_irq)
 	}
 
 	if (host_irq != (unsigned int)-1) {
+		int irq = IRQ_ISA_CASCADE;
+
 		for (irq = _ISA_IRQ(0); irq < _ISA_IRQ(8); irq++) {
 			irq_set_chip_and_handler(irq, &isa_lo_chip,
 						 handle_level_irq);
@@ -160,7 +157,8 @@ void __init isa_init_irq(unsigned int host_irq)
 
 		request_resource(&ioport_resource, &pic1_resource);
 		request_resource(&ioport_resource, &pic2_resource);
-		setup_irq(IRQ_ISA_CASCADE, &irq_cascade);
+		if (request_irq(irq, no_action, 0, "cascade", NULL))
+			pr_err("Failed to request irq %d (cascade)\n", irq);
 
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

