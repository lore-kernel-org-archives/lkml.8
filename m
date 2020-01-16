Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE94C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA37F207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389059AbgAPVbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:31:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53537 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbgAPVbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 16:31:06 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isCjE-0001W0-Mp; Thu, 16 Jan 2020 22:31:00 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4508C1C1970;
        Thu, 16 Jan 2020 22:31:00 +0100 (CET)
Date:   Thu, 16 Jan 2020 21:31:00 -0000
From:   "tip-bot2 for Tony Lindgren" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Fix uninitialized
 pointer access
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Olof Johansson <olof@lixom.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200106203700.21009-1-tony@atomide.com>
References: <20200106203700.21009-1-tony@atomide.com>
MIME-Version: 1.0
Message-ID: <157921026006.396.14675587072091976088.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     4341067cfc20582195f47383cf059589b2641465
Gitweb:        https://git.kernel.org/tip/4341067cfc20582195f47383cf059589b2641465
Author:        Tony Lindgren <tony@atomide.com>
AuthorDate:    Mon, 06 Jan 2020 12:37:00 -08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 16 Jan 2020 19:09:02 +01:00

clocksource/drivers/timer-ti-dm: Fix uninitialized pointer access

Clean-up commit 8c82723414d5 ("clocksource/drivers/timer-ti-dm: Switch to
platform_get_irq") caused a regression where we now try to access
uninitialized data for timer:

drivers/clocksource/timer-ti-dm.c: In function 'omap_dm_timer_probe':
drivers/clocksource/timer-ti-dm.c:798:13: warning: 'timer' may be used
uninitialized in this function [-Wmaybe-uninitialized]

On boot we now get:

Unable to handle kernel NULL pointer dereference at virtual address
00000004
...
(omap_dm_timer_probe) from [<c061ac7c>] (platform_drv_probe+0x48/0x98)
(platform_drv_probe) from [<c0618c04>] (really_probe+0x1dc/0x348)
(really_probe) from [<c0618ef4>] (driver_probe_device+0x5c/0x160)

Let's fix the issue by moving platform_get_irq to happen after timer has
been allocated.

Fixes: bc83caddf17b ("clocksource/drivers/timer-ti-dm: Switch to platform_get_irq")
Cc: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Acked-by: Olof Johansson <olof@lixom.net>
Acked-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200106203700.21009-1-tony@atomide.com
---
 drivers/clocksource/timer-ti-dm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index bd16efb..269a994 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -795,14 +795,14 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	timer->irq = platform_get_irq(pdev, 0);
-	if (timer->irq < 0)
-		return timer->irq;
-
 	timer = devm_kzalloc(dev, sizeof(*timer), GFP_KERNEL);
 	if (!timer)
 		return  -ENOMEM;
 
+	timer->irq = platform_get_irq(pdev, 0);
+	if (timer->irq < 0)
+		return timer->irq;
+
 	timer->fclk = ERR_PTR(-ENODEV);
 	timer->io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(timer->io_base))
