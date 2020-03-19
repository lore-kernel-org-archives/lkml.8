Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8155C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A752070A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgCSSy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 14:54:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33984 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCSSy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 14:54:28 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jF0JD-0007lm-PT; Thu, 19 Mar 2020 19:54:23 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 528201C22B7;
        Thu, 19 Mar 2020 19:54:23 +0100 (CET)
Date:   Thu, 19 Mar 2020 18:54:22 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] Revert "tick/common: Make tick_periodic() check
 for missing ticks"
Cc:     Qian Cai <cai@lca.pw>, Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158464406295.28353.3230662958771714087.tip-bot2@tip-bot2>
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

Commit-ID:     52da479a9aee630d2cdf37d05edfe5bcfff3e17f
Gitweb:        https://git.kernel.org/tip/52da479a9aee630d2cdf37d05edfe5bcfff3e17f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 19 Mar 2020 19:47:06 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 19 Mar 2020 19:47:48 +01:00

Revert "tick/common: Make tick_periodic() check for missing ticks"

This reverts commit d441dceb5dce71150f28add80d36d91bbfccba99 due to
boot failures.

Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
---
 kernel/time/tick-common.c | 36 +++---------------------------------
 1 file changed, 3 insertions(+), 33 deletions(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index cce4ed1..7e5d352 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -16,7 +16,6 @@
 #include <linux/profile.h>
 #include <linux/sched.h>
 #include <linux/module.h>
-#include <linux/sched/clock.h>
 #include <trace/events/power.h>
 
 #include <asm/irq_regs.h>
@@ -85,41 +84,12 @@ int tick_is_oneshot_available(void)
 static void tick_periodic(int cpu)
 {
 	if (tick_do_timer_cpu == cpu) {
-		/*
-		 * Use running_clock() as reference to check for missing ticks.
-		 */
-		static ktime_t last_update;
-		ktime_t now;
-		int ticks = 1;
-
-		now = ns_to_ktime(running_clock());
 		write_seqlock(&jiffies_lock);
 
-		if (last_update) {
-			u64 delta = ktime_sub(now, last_update);
-
-			/*
-			 * Check for eventually missed ticks
-			 *
-			 * There is likely a persistent delta between
-			 * last_update and tick_next_period. So they are
-			 * updated separately.
-			 */
-			if (delta >= 2 * tick_period) {
-				s64 period = ktime_to_ns(tick_period);
-
-				ticks = ktime_divns(delta, period);
-			}
-			last_update = ktime_add(last_update,
-						ticks * tick_period);
-		} else {
-			last_update = now;
-		}
-
 		/* Keep track of the next tick event */
-		tick_next_period = ktime_add(tick_next_period,
-					     ticks * tick_period);
-		do_timer(ticks);
+		tick_next_period = ktime_add(tick_next_period, tick_period);
+
+		do_timer(1);
 		write_sequnlock(&jiffies_lock);
 		update_wall_time();
 	}
