Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A47EC43458
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 544E422B40
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M+M4qD+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbgGWP1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbgGWP1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:27:11 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42E6C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 08:27:10 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j18so5328217wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 08:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KXR0KFepvyeg+U0v87jwQjr7s+Msp1vc0GJ40vDF1Ko=;
        b=M+M4qD+ILkw91XTtuo45wNwv6ENaH7FRJ7/e845oxWByk2TRlajf3Dsr4Tuf+sEXGd
         uPT6XWZlK35pMrqDcnx8IQ+CEwmlZXDFi8g2cen0VdRpSUEC4q6fUPwct+leCQ9Yd4tV
         XVuHkkOXMDxBmzeeFSi80ndg/VwVGWt3rXS04p2u58cG6osFAWC05NAh3EyC8GINg64d
         ND/taqFhtT2mvmL7toGQIElX3Gaj7kM2C7FIQ+OqJ1UQF7JdW/WwYg3QcWEz/ou+43fR
         dXL51iVmh3GrFkvUg6HPZgOZXc+i6eoOdyMQdlESaLADVRcRpUisJIPtyaW7ckr5YsfP
         73/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KXR0KFepvyeg+U0v87jwQjr7s+Msp1vc0GJ40vDF1Ko=;
        b=YdhbS3kxCrzKI6A8/6SFLpGcsxBOSedt6+tvvII9VtrQ6vk6Bj21gUWLvt7o8IwpS2
         B/2KMgBIYVsrwD8pFblmz1mKAUXZnE6A5oXSGgN4F8xI+sv2XgV8GdgUE4AKgH+xA74D
         uXUUpxvJszC0lQuvv1hKV1cVuiNjPgkexmk9/nz1XtGSsASYKCm/FPhEgpnTqQx72il8
         MYTVqOdBgi2283Nn+tlrFs9/y2yXyVRM2O4eQQAyQBbIIH/66dngiZicfO9Cj1viUFV6
         hq2x2NXVUCAc+HbPWNuSvSoQQeG43/iMY9/ng0I+wH7+6tLPZUhBt8KQsan4KIVpvU6O
         48FQ==
X-Gm-Message-State: AOAM533hDd8M0UbnrbmkvNJdcoFKD6Y3A1Iwv24BYWI9hdJMpu36C6aH
        wot0tHKiwWNJA7NJCr6W6kYA2A==
X-Google-Smtp-Source: ABdhPJxR/ZxlbWgbc4W4/U5bcr9DOquzXPTO0/1K/0hF40hOboeq3emO0mVwjNbIZBHEAviNM8B4fg==
X-Received: by 2002:a1c:9e0d:: with SMTP id h13mr4901655wme.5.1595518029334;
        Thu, 23 Jul 2020 08:27:09 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:dca7:8d30:33fa:daac])
        by smtp.gmail.com with ESMTPSA id g145sm5963491wmg.23.2020.07.23.08.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 08:27:08 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org (open list:CLOCKSOURCE, CLOCKEVENT DRIVERS)
Subject: [PATCH 13/16] clocksource/drivers/nomadik-mtu: Handle 32kHz clock
Date:   Thu, 23 Jul 2020 17:26:33 +0200
Message-Id: <20200723152639.639771-13-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723152639.639771-1-daniel.lezcano@linaro.org>
References: <1b1122f4-bce9-f349-e602-ed8e14cbb501@linaro.org>
 <20200723152639.639771-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

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
2.25.1

