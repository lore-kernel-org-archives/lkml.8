Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC52C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6E22077C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389332AbgAPVbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:31:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53553 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388956AbgAPVbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 16:31:08 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isCjE-0001Vu-6T; Thu, 16 Jan 2020 22:31:00 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A81821C198B;
        Thu, 16 Jan 2020 22:30:59 +0100 (CET)
Date:   Thu, 16 Jan 2020 21:30:59 -0000
From:   "tip-bot2 for Claudiu Beznea" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-microchip-pit64b: Fix
 sparse warning
Cc:     kbuild test robot <lkp@intel.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1578304688-14882-1-git-send-email-claudiu.beznea@microchip.com>
References: <1578304688-14882-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Message-ID: <157921025951.396.5929727901438281211.tip-bot2@tip-bot2>
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

Commit-ID:     b9c60a741f06eda56d12c7216accb317b74266b4
Gitweb:        https://git.kernel.org/tip/b9c60a741f06eda56d12c7216accb317b74266b4
Author:        Claudiu Beznea <claudiu.beznea@microchip.com>
AuthorDate:    Mon, 06 Jan 2020 11:58:08 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 16 Jan 2020 19:09:02 +01:00

clocksource/drivers/timer-microchip-pit64b: Fix sparse warning

Fix sparse warning:
"warning: Using plain integer as NULL pointer"

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1578304688-14882-1-git-send-email-claudiu.beznea@microchip.com
---
 drivers/clocksource/timer-microchip-pit64b.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-microchip-pit64b.c b/drivers/clocksource/timer-microchip-pit64b.c
index 27a389a..bd63d34 100644
--- a/drivers/clocksource/timer-microchip-pit64b.c
+++ b/drivers/clocksource/timer-microchip-pit64b.c
@@ -248,6 +248,8 @@ static int __init mchp_pit64b_init_mode(struct mchp_pit64b_timer *timer,
 	if (!pclk_rate)
 		return -EINVAL;
 
+	timer->mode = 0;
+
 	/* Try using GCLK. */
 	gclk_round = clk_round_rate(timer->gclk, max_rate);
 	if (gclk_round < 0)
@@ -360,7 +362,7 @@ static int __init mchp_pit64b_dt_init_timer(struct device_node *node,
 					    bool clkevt)
 {
 	u32 freq = clkevt ? MCHP_PIT64B_DEF_CE_FREQ : MCHP_PIT64B_DEF_CS_FREQ;
-	struct mchp_pit64b_timer timer = { 0 };
+	struct mchp_pit64b_timer timer;
 	unsigned long clk_rate;
 	u32 irq = 0;
 	int ret;
