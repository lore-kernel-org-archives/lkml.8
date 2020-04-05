Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1452C2BA1B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 07:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A955A2072F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 07:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgDEHcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 03:32:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42496 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgDEHcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 03:32:21 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKzlP-0001xP-FA; Sun, 05 Apr 2020 09:32:15 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 529E11C01BB;
        Sun,  5 Apr 2020 09:32:14 +0200 (CEST)
Date:   Sun, 05 Apr 2020 07:32:13 -0000
From:   "tip-bot2 for afzal mohammed" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] clocksource/drivers/timer-vf-pit: Add missing
 parenthesis
Cc:     kbuild test robot <lkp@intel.com>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200323061130.GA6286@afzalpc>
References: <20200323061130.GA6286@afzalpc>
MIME-Version: 1.0
Message-ID: <158607193357.28353.3365476438962871660.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     760a53768610d427990192b5cfdb71310e1373db
Gitweb:        https://git.kernel.org/tip/760a53768610d427990192b5cfdb71310e1373db
Author:        afzal mohammed <afzal.mohd.ma@gmail.com>
AuthorDate:    Mon, 23 Mar 2020 11:41:30 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 05 Apr 2020 09:24:58 +02:00

clocksource/drivers/timer-vf-pit: Add missing parenthesis

Recently all usage of setup_irq() was replaced by request_irq(). The
replacement in timer-vf-pit.c missed closing parentheses resulting in a build
error (vf610m4_defconfig). Fix it.

Fixes: cc2550b421aa ("clocksource: Replace setup_irq() by request_irq()")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200323061130.GA6286@afzalpc

---
 drivers/clocksource/timer-vf-pit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-vf-pit.c
index 7ad4a8b..1a86a4e 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -129,7 +129,7 @@ static int __init pit_clockevent_init(unsigned long rate, int irq)
 	__raw_writel(PITTFLG_TIF, clkevt_base + PITTFLG);
 
 	BUG_ON(request_irq(irq, pit_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
-			   "VF pit timer", &clockevent_pit);
+			   "VF pit timer", &clockevent_pit));
 
 	clockevent_pit.cpumask = cpumask_of(0);
 	clockevent_pit.irq = irq;
