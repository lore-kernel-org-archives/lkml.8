Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D42DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F13242074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgFANMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 09:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgFANLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 09:11:52 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAC7C08C5C0;
        Mon,  1 Jun 2020 06:11:51 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jfkEB-000751-50; Mon, 01 Jun 2020 15:11:43 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C68931C0244;
        Mon,  1 Jun 2020 15:11:42 +0200 (CEST)
Date:   Mon, 01 Jun 2020 13:11:42 -0000
From:   "tip-bot2 for Tony Lindgren" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Fix warning for
 set but not used
Cc:     kbuild test robot <lkp@intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200519155157.12804-1-tony@atomide.com>
References: <20200519155157.12804-1-tony@atomide.com>
MIME-Version: 1.0
Message-ID: <159101710255.17951.4636349672483050545.tip-bot2@tip-bot2>
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

Commit-ID:     c177e2975430cec296aa52a0d413e447417d6cf9
Gitweb:        https://git.kernel.org/tip/c177e2975430cec296aa52a0d413e447417d6cf9
Author:        Tony Lindgren <tony@atomide.com>
AuthorDate:    Tue, 19 May 2020 08:51:57 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 23 May 2020 00:01:05 +02:00

clocksource/drivers/timer-ti-dm: Fix warning for set but not used

We can get a warning for dmtimer_clocksource_init() with 'pa' set but
not used. This was used in the earlier revisions of the code but no
longer needed, so let's remove the unused pa and of_translate_address().
Let's also do it for dmtimer_clockevent_init() that has a similar issue.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200519155157.12804-1-tony@atomide.com
---
 drivers/clocksource/timer-ti-dm-systimer.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource/timer-ti-dm-systimer.c
index 1495618..7da998d 100644
--- a/drivers/clocksource/timer-ti-dm-systimer.c
+++ b/drivers/clocksource/timer-ti-dm-systimer.c
@@ -514,7 +514,6 @@ static int __init dmtimer_clockevent_init(struct device_node *np)
 	struct clock_event_device *dev;
 	struct dmtimer_systimer *t;
 	int error;
-	u32 pa;
 
 	clkevt = kzalloc(sizeof(*clkevt), GFP_KERNEL);
 	if (!clkevt)
@@ -563,7 +562,6 @@ static int __init dmtimer_clockevent_init(struct device_node *np)
 	writel_relaxed(OMAP_TIMER_INT_OVERFLOW, t->base + t->irq_ena);
 	writel_relaxed(OMAP_TIMER_INT_OVERFLOW, t->base + t->wakeup);
 
-	pa = of_translate_address(np, of_get_address(np, 0, NULL, NULL));
 	pr_info("TI gptimer clockevent: %s%lu Hz at %pOF\n",
 		of_find_property(np, "ti,timer-alwon", NULL) ?
 		"always-on " : "", t->rate, np->parent);
@@ -637,7 +635,6 @@ static int __init dmtimer_clocksource_init(struct device_node *np)
 	struct dmtimer_systimer *t;
 	struct clocksource *dev;
 	int error;
-	u32 pa;
 
 	clksrc = kzalloc(sizeof(*clksrc), GFP_KERNEL);
 	if (!clksrc)
@@ -666,7 +663,6 @@ static int __init dmtimer_clocksource_init(struct device_node *np)
 	writel_relaxed(OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR,
 		       t->base + t->ctrl);
 
-	pa = of_translate_address(np, of_get_address(np, 0, NULL, NULL));
 	pr_info("TI gptimer clocksource: %s%pOF\n",
 		of_find_property(np, "ti,timer-alwon", NULL) ?
 		"always-on " : "", np->parent);
