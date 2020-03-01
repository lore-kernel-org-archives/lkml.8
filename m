Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194ECC3F2D4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 12:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E043920880
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 12:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNpiy/uV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgCAMWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 07:22:16 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37233 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgCAMWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 07:22:15 -0500
Received: by mail-pj1-f67.google.com with SMTP id o2so1300492pjp.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 04:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6RuW8LcV5g6WypRcQIvGZ/SRPet4fNoET5RxUt4w0FQ=;
        b=hNpiy/uVydyqMqWo83KwxexQEzJHid6YWnsfsiep0CUh6gNn2RqgFVOHvY6gTJMyiD
         Eaf+TcdWuvFMS9DJRFcH8XWQIPeCCtXML4Tfwek2bBmaDjtfksppHrMIi956IGrBqndC
         PfLL+9/TpG6+hrDk75dDl8tT3Q5nRU5IxaR8VBwW8cRm8PCEtRhEV8gZacp3OzWY76Sj
         28ihxoPU2aHwvBHH47CDcophZnBA8/6n2cc65GE3Ml8tigk18JQXpqOUuvrx9hnS19xE
         +8GMnkBaopOecBmMKgif+qRehxN4EtqVMmQyydbabPUWMgomywtsCBaIumrlucE4PeKy
         syAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6RuW8LcV5g6WypRcQIvGZ/SRPet4fNoET5RxUt4w0FQ=;
        b=PA67OD+bcVKKKFY1iJ2OyrXKWP59HkZqWcDEqoXESTLirJIJOFFlSL3PFaJGn4JFx1
         TBsks914rvZL0hx7hKmvp7j1aHqLUGCQp6WwHqZZ0B4uXJ3AMhPFBTqAF/AMEj71Rsel
         dZgt4rdik81vriuDqkot3dHsBT2fOImMI+P7i2TsU5osVvayBVv1rbssV8EOuTgHmC3U
         AR/5v2D186Dp1VI9vWTvbn16l5HFee15JDrJmDXN6dGarPGH1ojjTgg+EkUcvRdslHLE
         kDQMDPtceIIrGRSX+M3/2txHW/wMHvAzV6tNyNnH7PcNpttSdf9GQIlKfn8bX94vBZEe
         X6WQ==
X-Gm-Message-State: APjAAAVgUXB2GvCt52GIvp4/nW/WwTmhWqcsA35mGZWSIkC01kcBVCj3
        l1ewLxuijLuItpJ43yfDWW/vSi0x
X-Google-Smtp-Source: APXvYqxFvG3KgjDCtFOpqiwrVA/h5V0iFoU894xpJ/5CjNJFPDjijl8I9D/82NNQ22uympXnuRaCXA==
X-Received: by 2002:a17:902:4a:: with SMTP id 68mr13359156pla.245.1583065334897;
        Sun, 01 Mar 2020 04:22:14 -0800 (PST)
Received: from localhost.localdomain ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id e1sm17520364pff.188.2020.03.01.04.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 04:22:14 -0800 (PST)
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>
Subject: [PATCH v3] ARM: ebsa110: replace setup_irq() by request_irq()
Date:   Sun,  1 Mar 2020 17:52:09 +0530
Message-Id: <20200301122210.4013-1-afzal.mohd.ma@gmail.com>
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
 * Split out from series, also split out from ARM patch to subarch level
	as Thomas suggested to take it thr' respective maintainers
 * Modify string displayed in case of error as suggested by Thomas
 * Re-arrange code as required to improve readability
 * Remove irrelevant parts from commit message & improve
 
v2:
 * Replace pr_err("request_irq() on %s failed" by
           pr_err("%s: request_irq() failed"
 * Commit message massage

 arch/arm/mach-ebsa110/core.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-ebsa110/core.c b/arch/arm/mach-ebsa110/core.c
index da2ff4f61d6b..575b2e2b6759 100644
--- a/arch/arm/mach-ebsa110/core.c
+++ b/arch/arm/mach-ebsa110/core.c
@@ -201,17 +201,13 @@ ebsa110_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction ebsa110_timer_irq = {
-	.name		= "EBSA110 Timer Tick",
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= ebsa110_timer_interrupt,
-};
-
 /*
  * Set up timer interrupt.
  */
 void __init ebsa110_timer_init(void)
 {
+	int irq = IRQ_EBSA110_TIMER0;
+
 	arch_gettimeoffset = ebsa110_gettimeoffset;
 
 	/*
@@ -221,7 +217,9 @@ void __init ebsa110_timer_init(void)
 	__raw_writeb(COUNT & 0xff, PIT_T1);
 	__raw_writeb(COUNT >> 8, PIT_T1);
 
-	setup_irq(IRQ_EBSA110_TIMER0, &ebsa110_timer_irq);
+	if (request_irq(irq, ebsa110_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
+			"EBSA110 Timer Tick", NULL))
+		pr_err("Failed to request irq %d (EBSA110 Timer Tick)\n", irq);
 }
 
 static struct plat_serial8250_port serial_platform_data[] = {
-- 
2.25.1

