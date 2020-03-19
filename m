Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E111C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2A02072D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgCSIs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:48:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59783 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgCSIsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:48:01 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEqqJ-000334-Vo; Thu, 19 Mar 2020 09:47:56 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CFB871C229F;
        Thu, 19 Mar 2020 09:47:52 +0100 (CET)
Date:   Thu, 19 Mar 2020 08:47:52 -0000
From:   "tip-bot2 for Matheus Castello" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/owl: Improve owl_timer_init
 fail messages
Cc:     Matheus Castello <matheus@castello.eng.br>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200219004810.411190-1-matheus@castello.eng.br>
References: <20200219004810.411190-1-matheus@castello.eng.br>
MIME-Version: 1.0
Message-ID: <158460767257.28353.6675261030088110845.tip-bot2@tip-bot2>
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

Commit-ID:     ad1ded9d2e3d1eb452ff58d325aadf237e187bd9
Gitweb:        https://git.kernel.org/tip/ad1ded9d2e3d1eb452ff58d325aadf237e187bd9
Author:        Matheus Castello <matheus@castello.eng.br>
AuthorDate:    Tue, 18 Feb 2020 21:48:10 -03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 27 Feb 2020 09:42:00 +01:00

clocksource/drivers/owl: Improve owl_timer_init fail messages

Check the return from clocksource_mmio_init, add messages in case of
an error and in case of not having a defined clock property.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200219004810.411190-1-matheus@castello.eng.br
---
 drivers/clocksource/timer-owl.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-owl.c b/drivers/clocksource/timer-owl.c
index 900fe73..ac97420 100644
--- a/drivers/clocksource/timer-owl.c
+++ b/drivers/clocksource/timer-owl.c
@@ -135,8 +135,11 @@ static int __init owl_timer_init(struct device_node *node)
 	}
 
 	clk = of_clk_get(node, 0);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		pr_err("Failed to get clock for clocksource (%d)\n", ret);
+		return ret;
+	}
 
 	rate = clk_get_rate(clk);
 
@@ -144,8 +147,12 @@ static int __init owl_timer_init(struct device_node *node)
 	owl_timer_set_enabled(owl_clksrc_base, true);
 
 	sched_clock_register(owl_timer_sched_read, 32, rate);
-	clocksource_mmio_init(owl_clksrc_base + OWL_Tx_VAL, node->name,
-			      rate, 200, 32, clocksource_mmio_readl_up);
+	ret = clocksource_mmio_init(owl_clksrc_base + OWL_Tx_VAL, node->name,
+				    rate, 200, 32, clocksource_mmio_readl_up);
+	if (ret) {
+		pr_err("Failed to register clocksource (%d)\n", ret);
+		return ret;
+	}
 
 	owl_timer_reset(owl_clkevt_base);
 
