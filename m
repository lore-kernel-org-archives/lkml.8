Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF29AC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C14721741
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgCDJUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 04:20:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46364 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgCDJUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 04:20:15 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j9QCI-0007fx-Sd; Wed, 04 Mar 2020 10:20:10 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7A3911C20C4;
        Wed,  4 Mar 2020 10:20:10 +0100 (CET)
Date:   Wed, 04 Mar 2020 09:20:10 -0000
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick/common: Make tick_periodic() check for missing ticks
Cc:     Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200207193929.27308-1-longman@redhat.com>
References: <20200207193929.27308-1-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <158331361014.28353.17944601337064422508.tip-bot2@tip-bot2>
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

Commit-ID:     d441dceb5dce71150f28add80d36d91bbfccba99
Gitweb:        https://git.kernel.org/tip/d441dceb5dce71150f28add80d36d91bbfccba99
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Fri, 07 Feb 2020 14:39:29 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 04 Mar 2020 10:18:11 +01:00

tick/common: Make tick_periodic() check for missing ticks

The tick_periodic() function is used at the beginning part of the
bootup process for time keeping while the other clock sources are
being initialized.

The current code assumes that all the timer interrupts are handled in
a timely manner with no missing ticks. That is not actually true. Some
ticks are missed and there are some discrepancies between the tick time
(jiffies) and the timestamp reported in the kernel log.  Some systems,
however, are more prone to missing ticks than the others.  In the extreme
case, the discrepancy can actually cause a soft lockup message to be
printed by the watchdog kthread. For example, on a Cavium ThunderX2
Sabre arm64 system:

 [   25.496379] watchdog: BUG: soft lockup - CPU#14 stuck for 22s!

On that system, the missing ticks are especially prevalent during the
smp_init() phase of the boot process. With an instrumented kernel,
it was found that it took about 24s as reported by the timestamp for
the tick to accumulate 4s of time.

Investigation and bisection done by others seemed to point to the
commit 73f381660959 ("arm64: Advertise mitigation of Spectre-v2, or
lack thereof") as the culprit. It could also be a firmware issue as
new firmware was promised that would fix the issue.

To properly address this problem, stop assuming that there will be no
missing tick in tick_periodic(). Modify it to follow the example of
tick_do_update_jiffies64() by using another reference clock to check for
missing ticks. Since the watchdog timer uses running_clock(), it is used
here as the reference. With this applied, the soft lockup problem in the
affected arm64 system is gone and tick time tracks much more closely to the
timestamp time.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200207193929.27308-1-longman@redhat.com
---
 kernel/time/tick-common.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 7e5d352..cce4ed1 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -16,6 +16,7 @@
 #include <linux/profile.h>
 #include <linux/sched.h>
 #include <linux/module.h>
+#include <linux/sched/clock.h>
 #include <trace/events/power.h>
 
 #include <asm/irq_regs.h>
@@ -84,12 +85,41 @@ int tick_is_oneshot_available(void)
 static void tick_periodic(int cpu)
 {
 	if (tick_do_timer_cpu == cpu) {
+		/*
+		 * Use running_clock() as reference to check for missing ticks.
+		 */
+		static ktime_t last_update;
+		ktime_t now;
+		int ticks = 1;
+
+		now = ns_to_ktime(running_clock());
 		write_seqlock(&jiffies_lock);
 
-		/* Keep track of the next tick event */
-		tick_next_period = ktime_add(tick_next_period, tick_period);
+		if (last_update) {
+			u64 delta = ktime_sub(now, last_update);
 
-		do_timer(1);
+			/*
+			 * Check for eventually missed ticks
+			 *
+			 * There is likely a persistent delta between
+			 * last_update and tick_next_period. So they are
+			 * updated separately.
+			 */
+			if (delta >= 2 * tick_period) {
+				s64 period = ktime_to_ns(tick_period);
+
+				ticks = ktime_divns(delta, period);
+			}
+			last_update = ktime_add(last_update,
+						ticks * tick_period);
+		} else {
+			last_update = now;
+		}
+
+		/* Keep track of the next tick event */
+		tick_next_period = ktime_add(tick_next_period,
+					     ticks * tick_period);
+		do_timer(ticks);
 		write_sequnlock(&jiffies_lock);
 		update_wall_time();
 	}
