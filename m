Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FA4C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 16:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61542078E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 16:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEFhYYF3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgDKQFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 12:05:00 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39120 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgDKQE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 12:04:59 -0400
Received: by mail-pj1-f67.google.com with SMTP id o1so1069311pjs.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 09:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CNSQoXFlKgWCIOZrqLUl6wID11RTUmYQHQ0/BX2/sHE=;
        b=VEFhYYF3p5KxrLWRGJDL2N667q1ZPkgv86jZsYij0iLgeLWIpZQfWcmyAdgWzke6Ec
         3hGjBRqZVbY8UfHcUIU7gvVNpklYSPllx6G44rJ0TY8EDVXanDjWa372sWVfYEG7PMH0
         rnO/sXOpExMeG45YOWnS0ogFehdn439ohjZTVbD56ByhtXpxZ9P6XzKAtUzDtKSlQOKG
         prXjsy7a8660CL/9yOGNaP3d7kt65hdRbipohCxoO8QdCFBkmbMb7gZ7PG4/dAxA59sa
         csrhYFVtWytlUPL+JpDotta1x0+qwvbRbsz1iGjC05n8qM+PHrPAyEqgneYsBBN39dxa
         TJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CNSQoXFlKgWCIOZrqLUl6wID11RTUmYQHQ0/BX2/sHE=;
        b=jiB/uU+Xdcs9mg0XiaNJIoLIL4Ecu2DZw4C1TaK6psRcrz6KfSezZQrs2SEuZzA9wN
         5KWuFlKn1jWnxxOShmqzEMHs/fbuT6kliu+eG+x2MtTI9V4saBE+6ED29PXuqoWtolYw
         gK1QWe4SM8E1nuY0Jrr6t4CcG/+KKeuvmuAzLoHOqHn+F35RRZ8Tzgam5syf62T1X55W
         sdycvz9FxR62cnjK1CyFoDDkZKAMlq6khnqXsxVbzgNmsBJaqaB2k2M0y9eo4adBM0FV
         5pkrSNaOqTinuxz8T/yqohXVcpxBWYW9QXb4phe260YclkqtlJG8JXfJp8LfK6ATHSWT
         yCkA==
X-Gm-Message-State: AGi0PuaB7Fd1hlk7QepLS8p61fkKFSBWNKid4kok2o+2tvgNrFCkCrfn
        12zn8Pn5kMv5TjnL1s/7Rc8=
X-Google-Smtp-Source: APiQypKGVreOobFj/XPBTpEVM66f9CRTl6UpjQ9o5SIOdhFaMgxEdy4aIl3AUpcEUnqa38aNXeOyng==
X-Received: by 2002:a17:90a:9318:: with SMTP id p24mr11553177pjo.163.1586621097496;
        Sat, 11 Apr 2020 09:04:57 -0700 (PDT)
Received: from localhost ([183.82.183.27])
        by smtp.gmail.com with ESMTPSA id jx1sm2117538pjb.5.2020.04.11.09.04.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Apr 2020 09:04:57 -0700 (PDT)
Date:   Sat, 11 Apr 2020 21:34:55 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] clocksource/drivers/mips-gic-timer: Replace
 setup_percpu_irq() by request_percpu_irq() variant
Message-ID: <4b0bc8921daea49636a604259025c65f358ab9c8.1586434781.git.afzal.mohd.ma@gmail.com>
References: <cover.1586434781.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1586434781.git.afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently all usages of setup_irq() was replaced by request_irq() as
allocators are ready by the time setup_irq() was invoked. Similarly
setup_percpu_irq() can be replaced by request_percpu_irq(). But in the
callers handled here __request_percpu_irq() has to be used as
request_percpu_irq() does not give the user a chance to pass the flags,
and IRQF_TIMER has to be passed here, so the variant
__request_percpu_irq() is used.

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---
 drivers/clocksource/mips-gic-timer.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index 37671a5d4ed9..e8e6bb6159f5 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -67,13 +67,6 @@ static irqreturn_t gic_compare_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction gic_compare_irqaction = {
-	.handler = gic_compare_interrupt,
-	.percpu_dev_id = &gic_clockevent_device,
-	.flags = IRQF_PERCPU | IRQF_TIMER,
-	.name = "timer",
-};
-
 static void gic_clockevent_cpu_init(unsigned int cpu,
 				    struct clock_event_device *cd)
 {
@@ -137,7 +130,8 @@ static int gic_clockevent_init(void)
 	if (!gic_frequency)
 		return -ENXIO;
 
-	ret = setup_percpu_irq(gic_timer_irq, &gic_compare_irqaction);
+	ret = __request_percpu_irq(gic_timer_irq, gic_compare_interrupt,
+				   IRQF_TIMER, "timer", &gic_clockevent_device);
 	if (ret < 0) {
 		pr_err("IRQ %d setup failed (%d)\n", gic_timer_irq, ret);
 		return ret;
-- 
2.18.0

