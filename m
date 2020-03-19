Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA674C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA5120732
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgCSIs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:48:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59805 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbgCSIsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:48:04 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEqqH-00031l-S8; Thu, 19 Mar 2020 09:47:54 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 252261C229E;
        Thu, 19 Mar 2020 09:47:52 +0100 (CET)
Date:   Thu, 19 Mar 2020 08:47:51 -0000
From:   "tip-bot2 for Suman Anna" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Drop bogus
 omap_dm_timer_of_set_source()
Cc:     Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Keerthy <j-keerthy@ti.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>, Suman Anna <s-anna@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200213053504.22638-1-s-anna@ti.com>
References: <20200213053504.22638-1-s-anna@ti.com>
MIME-Version: 1.0
Message-ID: <158460767187.28353.4410336602856187146.tip-bot2@tip-bot2>
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

Commit-ID:     753e83408b7f2980b7a5bfcf01f1175a937a2340
Gitweb:        https://git.kernel.org/tip/753e83408b7f2980b7a5bfcf01f1175a937a2340
Author:        Suman Anna <s-anna@ti.com>
AuthorDate:    Wed, 12 Feb 2020 23:35:04 -06:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 27 Feb 2020 10:32:11 +01:00

clocksource/drivers/timer-ti-dm: Drop bogus omap_dm_timer_of_set_source()

The function omap_dm_timer_of_set_source() was originally added in
commit 31a7448f4fa8a ("ARM: OMAP: dmtimer: Add clock source from DT"),
and is designed to set a clock source from DT using the clocks property
of a timer node. This design choice is okay for clk provider nodes but
otherwise is a bad design as typically the clocks property is used to
specify the functional clocks for a device, and not its parents.

The timer nodes now all define a timer functional clock after the
conversion to ti-sysc and the new clkctrl layout, and this results
in an attempt to set the same functional clock as its parent when a
consumer driver attempts to acquire any of these timers in the
omap_dm_timer_prepare() function. This was masked and worked around
in commit 983a5a43ec25 ("clocksource: timer-ti-dm: Fix pwm dmtimer
usage of fck reparenting"). Fix all of this by simply dropping the
entire function.

Any DT configuration of clock sources should be achieved using
assigned-clocks and assigned-clock-parents properties provided
by the Common Clock Framework.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: H. Nikolaus Schaller <hns@goldelico.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Ladislav Michl <ladis@linux-mips.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Suman Anna <s-anna@ti.com>
Tested-by: Lokesh Vutla <lokeshvutla@ti.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200213053504.22638-1-s-anna@ti.com
---
 drivers/clocksource/timer-ti-dm.c | 33 +------------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index acc9360..6a0adb7 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -138,35 +138,6 @@ static int omap_dm_timer_reset(struct omap_dm_timer *timer)
 	return 0;
 }
 
-static int omap_dm_timer_of_set_source(struct omap_dm_timer *timer)
-{
-	int ret;
-	struct clk *parent;
-
-	/*
-	 * FIXME: OMAP1 devices do not use the clock framework for dmtimers so
-	 * do not call clk_get() for these devices.
-	 */
-	if (!timer->fclk)
-		return -ENODEV;
-
-	parent = clk_get(&timer->pdev->dev, NULL);
-	if (IS_ERR(parent))
-		return -ENODEV;
-
-	/* Bail out if both clocks point to fck */
-	if (clk_is_match(parent, timer->fclk))
-		return 0;
-
-	ret = clk_set_parent(timer->fclk, parent);
-	if (ret < 0)
-		pr_err("%s: failed to set parent\n", __func__);
-
-	clk_put(parent);
-
-	return ret;
-}
-
 static int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 {
 	int ret;
@@ -276,9 +247,7 @@ static int omap_dm_timer_prepare(struct omap_dm_timer *timer)
 	__omap_dm_timer_enable_posted(timer);
 	omap_dm_timer_disable(timer);
 
-	rc = omap_dm_timer_of_set_source(timer);
-	if (rc == -ENODEV)
-		return omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
+	rc = omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
 
 	return rc;
 }
