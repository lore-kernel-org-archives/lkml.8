Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45DDC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987A520740
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCSIr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:47:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59715 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgCSIry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:47:54 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEqqE-000307-U8; Thu, 19 Mar 2020 09:47:51 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 946381C2298;
        Thu, 19 Mar 2020 09:47:50 +0100 (CET)
Date:   Thu, 19 Mar 2020 08:47:50 -0000
From:   "tip-bot2 for afzal mohammed" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-cs5535: Request irq with
 non-NULL dev_id
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200312064817.19000-1-afzal.mohd.ma@gmail.com>
References: <20200312064817.19000-1-afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Message-ID: <158460767029.28353.2138334938469821354.tip-bot2@tip-bot2>
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

Commit-ID:     470cf1c28d2f601ea666a96d676c10b09b2321ab
Gitweb:        https://git.kernel.org/tip/470cf1c28d2f601ea666a96d676c10b09b2321ab
Author:        afzal mohammed <afzal.mohd.ma@gmail.com>
AuthorDate:    Thu, 12 Mar 2020 12:18:17 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 12 Mar 2020 19:23:06 +01:00

clocksource/drivers/timer-cs5535: Request irq with non-NULL dev_id

Recently all usages of setup_irq() was replaced by request_irq().
request_irq() does a few sanity checks that were not done in
setup_irq(), if they fail irq registration will fail. One of the check
is to ensure that non-NULL dev_id is passed in the case of shared irq.

Fix it by passing non-NULL dev_id while registering the shared irq.

Fixes: cc2550b421aa ("clocksource: Replace setup_irq() by request_irq()")
Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200312064817.19000-1-afzal.mohd.ma@gmail.com
---
 drivers/clocksource/timer-cs5535.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-cs5535.c b/drivers/clocksource/timer-cs5535.c
index 51ea050..d47acfe 100644
--- a/drivers/clocksource/timer-cs5535.c
+++ b/drivers/clocksource/timer-cs5535.c
@@ -133,6 +133,7 @@ static irqreturn_t mfgpt_tick(int irq, void *dev_id)
 
 static int __init cs5535_mfgpt_init(void)
 {
+	unsigned long flags = IRQF_NOBALANCING | IRQF_TIMER | IRQF_SHARED;
 	struct cs5535_mfgpt_timer *timer;
 	int ret;
 	uint16_t val;
@@ -152,9 +153,7 @@ static int __init cs5535_mfgpt_init(void)
 	}
 
 	/* And register it with the kernel */
-	ret = request_irq(timer_irq, mfgpt_tick,
-			  IRQF_NOBALANCING | IRQF_TIMER | IRQF_SHARED,
-			  DRV_NAME, NULL);
+	ret = request_irq(timer_irq, mfgpt_tick, flags, DRV_NAME, timer);
 	if (ret) {
 		printk(KERN_ERR DRV_NAME ": Unable to set up the interrupt.\n");
 		goto err_irq;
