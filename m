Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2C4C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 22:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 355CE20672
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 22:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qmcbALNN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgF1WB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 18:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgF1WB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 18:01:59 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8DEC03E979
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 15:01:58 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id t74so8027799lff.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 15:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bj6QkIDzzkCIfOkrIbu+GINbgYLt6UK0AtVxnJ8Cnxk=;
        b=qmcbALNNsTXojxTBCj/5TWAKBWZ3Zf31GEiSNX8zonaIQvdLJ9pRonuNuVosdFTl+J
         5JF+eFxYNgsQmp/cjq4lGnoYghAGRm/0gq3zW5w6domow3l5xbiinXbi8SFAPSA7lPos
         wc+k1JjxZ0JXuMAE7cz/CpI+yUImvkeNf2lgRBlCHKdGjD18tzI67ujW+ynIRzJzy90C
         jSMrYQXZQXWq2JXz8uCkpjAIlFGbroc3uLQmF/L//Eo9/+qjvqFovPlgIWYGECO5CwCd
         /fCNMap1mlHj0XNmYVf9OFyBk9h9FV0f37wVTAuHBfRSGwTrW+oLA3TV+N8EWJNN0W6B
         etBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bj6QkIDzzkCIfOkrIbu+GINbgYLt6UK0AtVxnJ8Cnxk=;
        b=t5JHKXsapk/1S0RxxKlI6fTv72ZFOHn9BACdacimPkYeQfdETMgUioIFTFN8pd/crM
         hOfBI6lZjc+IAaVbf670ZVuJTjUQjYhO9vi7+fzmKzeGYjlOCYykHzmTgIr1Q11NOd4t
         8Tp1dCvMzYF3Xd9QhNFRk2HlLGFaJfkmYFj3qTzLcGR/3F9wEzBKIjwK4NL1gMtiuH80
         aBUnil539A0m8HuyBzwfQ5ooTRNz55ah+qE+mQ3rINEeqduzVMF9yHqC/m6QXyRy47RF
         HfJr9AMXqNl/ZgTKE9zGD6ItNDOHckt7OAWsfKYOSRUqPRLGnDVwCT9EadnY3ZBuh6s+
         B7gA==
X-Gm-Message-State: AOAM533kTqvexvRdL+63SKfCDHtsnRawiA/BW7Eb5JdsB9pQPXabx+nu
        yiCei49aroje8jaufW8Kxl/Lxq2YkoE/XQ==
X-Google-Smtp-Source: ABdhPJzlxfrAhq2FKIoGbL8Werl/DvfpJeChyF419Nedp+rKK/YSBA86PaQrcQ2xK01SHTJdPgitKg==
X-Received: by 2002:a05:6512:4c6:: with SMTP id w6mr5355901lfq.76.1593381717215;
        Sun, 28 Jun 2020 15:01:57 -0700 (PDT)
Received: from localhost.bredbandsbolaget (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id s62sm6723773lja.100.2020.06.28.15.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 15:01:56 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] clocksource: nomadik-mtu: Handle 32kHz clock
Date:   Mon, 29 Jun 2020 00:01:53 +0200
Message-Id: <20200628220153.67011-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It happens on the U8420-sysclk Ux500 PRCMU firmware
variant that the MTU clock is just 32768 Hz, and in this
mode the minimum ticks is 5 rather than two.

I think this is simply so that there is enough time
for the register write to propagate through the
interconnect to the registers.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clocksource/nomadik-mtu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/nomadik-mtu.c b/drivers/clocksource/nomadik-mtu.c
index f49a631d8f58..1cf3304652d6 100644
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
-- 
2.26.2

