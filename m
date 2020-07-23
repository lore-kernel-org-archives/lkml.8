Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4AEC433EB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ED1A20737
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eFMeajpC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z9wT+dzh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgGWTJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 15:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgGWTJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 15:09:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3637CC0619DC;
        Thu, 23 Jul 2020 12:09:41 -0700 (PDT)
Date:   Thu, 23 Jul 2020 19:09:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595531379;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jHAEzeXiywKr0hwihLh1/TPPBoNTspu1YlA6nyxknew=;
        b=eFMeajpCGibecWAOvzzkVzm7y+R6ye6Vrza+PpJd+MPINwcrSguLrY9s/1PZthJFUMFJ0F
        Q7/iyGvk7kBQAgODwn1xJrA4MMsy2Ts8AqqI7fOyuBUhYZSH5gy9tyGLmDIfMhGXuhRDL2
        cZM0jXhOS3Q9YiXSXm7S8bRn0GoNCgIonOBWHqL/18RGG8jCkYDD7eeN7lk3dkxqDRLiZ3
        ndd5FXbNkS2r6ohd82HUm6nvWUoWQjsaEz2vw+ohsJAMpO12o6+4cEKLIMCR8RQAKHrCSc
        56pS7eToh/OQvXDDvYi5aVL9QBfUQ2pji9UEudTYF6im6kq/3ejXkARFyRJUwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595531379;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jHAEzeXiywKr0hwihLh1/TPPBoNTspu1YlA6nyxknew=;
        b=Z9wT+dzhSDoisJ8J+5esyP/2M28kz3mVifY+U/0n7QfVkAelJeF/zZvGmvWes/MzOrzz5S
        8md9Qb1M8HqkNmBg==
From:   "tip-bot2 for Linus Walleij" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/nomadik-mtu: Handle 32kHz clock
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200628220153.67011-1-linus.walleij@linaro.org>
References: <20200628220153.67011-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Message-ID: <159553137912.4006.8159842673078944988.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     aaea0b83458cdb3467e27deb7403b4403152dbd6
Gitweb:        https://git.kernel.org/tip/aaea0b83458cdb3467e27deb7403b4403152dbd6
Author:        Linus Walleij <linus.walleij@linaro.org>
AuthorDate:    Mon, 29 Jun 2020 00:01:53 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 23 Jul 2020 16:57:43 +02:00

clocksource/drivers/nomadik-mtu: Handle 32kHz clock

It happens on the U8420-sysclk Ux500 PRCMU firmware
variant that the MTU clock is just 32768 Hz, and in this
mode the minimum ticks is 5 rather than two.

I think this is simply so that there is enough time
for the register write to propagate through the
interconnect to the registers.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200628220153.67011-1-linus.walleij@linaro.org
---
 drivers/clocksource/nomadik-mtu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/nomadik-mtu.c b/drivers/clocksource/nomadik-mtu.c
index f49a631..1cf3304 100644
--- a/drivers/clocksource/nomadik-mtu.c
+++ b/drivers/clocksource/nomadik-mtu.c
@@ -186,6 +186,7 @@ static int __init nmdk_timer_init(void __iomem *base, int irq,
 {
 	unsigned long rate;
 	int ret;
+	int min_ticks;
 
 	mtu_base = base;
 
@@ -194,7 +195,8 @@ static int __init nmdk_timer_init(void __iomem *base, int irq,
 
 	/*
 	 * Tick rate is 2.4MHz for Nomadik and 2.4Mhz, 100MHz or 133 MHz
-	 * for ux500.
+	 * for ux500, and in one specific Ux500 case 32768 Hz.
+	 *
 	 * Use a divide-by-16 counter if the tick rate is more than 32MHz.
 	 * At 32 MHz, the timer (with 32 bit counter) can be programmed
 	 * to wake-up at a max 127s a head in time. Dividing a 2.4 MHz timer
@@ -230,7 +232,12 @@ static int __init nmdk_timer_init(void __iomem *base, int irq,
 		pr_err("%s: request_irq() failed\n", "Nomadik Timer Tick");
 	nmdk_clkevt.cpumask = cpumask_of(0);
 	nmdk_clkevt.irq = irq;
-	clockevents_config_and_register(&nmdk_clkevt, rate, 2, 0xffffffffU);
+	if (rate < 100000)
+		min_ticks = 5;
+	else
+		min_ticks = 2;
+	clockevents_config_and_register(&nmdk_clkevt, rate, min_ticks,
+					0xffffffffU);
 
 	mtu_delay_timer.read_current_timer = &nmdk_timer_read_current_timer;
 	mtu_delay_timer.freq = rate;
