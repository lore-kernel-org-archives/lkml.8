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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76CBC3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 12:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A82A21D56
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 12:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYTmSmLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgCAMVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 07:21:19 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35058 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgCAMVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 07:21:19 -0500
Received: by mail-pj1-f68.google.com with SMTP id s8so1422726pjq.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 04:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SeyPb7WMW17xLR/bm3Ntk537LqOC2X0/Y+QRTFUIpng=;
        b=gYTmSmLm0AA3xBssbb96lsImcBDraglC9axNZh2y1xQlXQsekc+prcCDs7sG/v5n7V
         wP1Wq6ae/TAp00TCaPwQYxFEF6uodaMyUfhvI8y7kFA+lAgeSJlaHvE4AOtkBRFDIuzC
         LwGYnImY1c37asiv6eBOWXHwHZh2YtpGAuH86HNnk16Kasgd+oSUPbXPJU5hkngAvIBx
         FvKcfwGOaawjZfuPL+trJFAW6nsJ44kIe2KBTjhTJsTDX4fY9wXFcd0XlKlA3pUyldnU
         bGz+oLsFQkIaZgAtMu2PloaoWsfwlNTfIHn1biiFDBOL4G5pr7/xsH77w7vpr9akIP6J
         ktIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SeyPb7WMW17xLR/bm3Ntk537LqOC2X0/Y+QRTFUIpng=;
        b=jasvHobnJpkozrT5VnlAPVoLBCEl6XGHgKg11vtV2vomnwYhO7NLimT99Y+HzBmhtv
         8R4MRTKg5AI9LHOKJ7QgGz41/TEKI1gO6hwvuV3BxroVfTesJWL8ZVx+y3tWdWv6pwZQ
         XHPnbZQUr4iRPaObQB4hH6+LFkWY0W4aMjYvzx7FwHKGCEtW43i5EsiPSo7oVnNObdj4
         U4Y6E9syUj4gPKLzZhPJnToBweRhnQa1Rc9NKMj2GzkKxDc1Zq/XX6E5fDUy3I9R8sPP
         tbKN9MVmnXIApuZpB0S+sk+jY9Bn3Q6JsMDtAyAEeMovCnj20+fvEAWUk/mJemWdhbKd
         VaoA==
X-Gm-Message-State: ANhLgQ0w5g37arDFj5TBfHKXw/0mcYCz02fj0B3/VGCvGEHzL98dCgCE
        hDFc82EfBOmGASDK66Kbv5o=
X-Google-Smtp-Source: ADFU+vtbfOxxW02DEXdbQIlTCcOsl0UNSCTpDU/wzpXXvmQ+19XZuiOceoT26cJh9xRGHzUzN7YlVQ==
X-Received: by 2002:a17:90b:30c2:: with SMTP id hi2mr943595pjb.7.1583065277013;
        Sun, 01 Mar 2020 04:21:17 -0800 (PST)
Received: from localhost.localdomain ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id k9sm17943013pfh.153.2020.03.01.04.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 04:21:16 -0800 (PST)
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>
Subject: [PATCH v3] ARM: ep93xx: Replace setup_irq() by request_irq()
Date:   Sun,  1 Mar 2020 17:51:12 +0530
Message-Id: <20200301122112.3847-1-afzal.mohd.ma@gmail.com>
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

 arch/arm/mach-ep93xx/timer-ep93xx.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-ep93xx/timer-ep93xx.c b/arch/arm/mach-ep93xx/timer-ep93xx.c
index de998830f534..dd4b164d1831 100644
--- a/arch/arm/mach-ep93xx/timer-ep93xx.c
+++ b/arch/arm/mach-ep93xx/timer-ep93xx.c
@@ -117,15 +117,11 @@ static irqreturn_t ep93xx_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction ep93xx_timer_irq = {
-	.name		= "ep93xx timer",
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= ep93xx_timer_interrupt,
-	.dev_id		= &ep93xx_clockevent,
-};
-
 void __init ep93xx_timer_init(void)
 {
+	int irq = IRQ_EP93XX_TIMER3;
+	unsigned long flags = IRQF_TIMER | IRQF_IRQPOLL;
+
 	/* Enable and register clocksource and sched_clock on timer 4 */
 	writel(EP93XX_TIMER4_VALUE_HIGH_ENABLE,
 	       EP93XX_TIMER4_VALUE_HIGH);
@@ -136,7 +132,9 @@ void __init ep93xx_timer_init(void)
 			     EP93XX_TIMER4_RATE);
 
 	/* Set up clockevent on timer 3 */
-	setup_irq(IRQ_EP93XX_TIMER3, &ep93xx_timer_irq);
+	if (request_irq(irq, ep93xx_timer_interrupt, flags, "ep93xx timer",
+			&ep93xx_clockevent))
+		pr_err("Failed to request irq %d (ep93xx timer)\n", irq);
 	clockevents_config_and_register(&ep93xx_clockevent,
 					EP93XX_TIMER123_RATE,
 					1,
-- 
2.25.1

