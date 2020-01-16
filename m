Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40317C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E7E20730
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436511AbgAPSRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:17:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52900 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436474AbgAPSRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:17:17 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1is9hX-0003ni-5o; Thu, 16 Jan 2020 19:17:03 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 92A16101226; Thu, 16 Jan 2020 19:17:02 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH] watchdog/softlockup: Enforce that timestamp is valid on boot
In-Reply-To: <20200116151146.wn6ec7igl2bfk4c2@rric.localdomain>
References: <20200103151032.19590-1-longman@redhat.com> <87sgkgw3xq.fsf@nanos.tec.linutronix.de> <87blr3wrqw.fsf@nanos.tec.linutronix.de> <20200116151146.wn6ec7igl2bfk4c2@rric.localdomain>
Date:   Thu, 16 Jan 2020 19:17:02 +0100
Message-ID: <87o8v3uuzl.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert reported that during boot the watchdog timestamp is set to 0 for one
second which is the indicator for a watchdog reset.

The reason for this is that the timestamp is in seconds and the time is
taken from sched clock and divided by ~1e9. sched clock starts at 0 which
means that for the first second during boot the watchdog timestamp is 0,
i.e. reset.

Use ULONG_MAX as the reset indicator value so the watchdog works correctly
right from the start. ULONG_MAX would only conflict with a real timestamp
if the system reaches an uptime of 136 years on 32bit and almost eternity
on 64bit.

Reported-by: Robert Richter <rrichter@marvell.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/watchdog.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -161,6 +161,8 @@ static void lockup_detector_update_enabl
 
 #ifdef CONFIG_SOFTLOCKUP_DETECTOR
 
+#define SOFTLOCKUP_RESET	ULONG_MAX
+
 /* Global variables, exported for sysctl */
 unsigned int __read_mostly softlockup_panic =
 			CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE;
@@ -272,7 +274,7 @@ notrace void touch_softlockup_watchdog_s
 	 * Preemption can be enabled.  It doesn't matter which CPU's timestamp
 	 * gets zeroed here, so use the raw_ operation.
 	 */
-	raw_cpu_write(watchdog_touch_ts, 0);
+	raw_cpu_write(watchdog_touch_ts, SOFTLOCKUP_RESET);
 }
 
 notrace void touch_softlockup_watchdog(void)
@@ -296,14 +298,14 @@ void touch_all_softlockup_watchdogs(void
 	 * the softlockup check.
 	 */
 	for_each_cpu(cpu, &watchdog_allowed_mask)
-		per_cpu(watchdog_touch_ts, cpu) = 0;
+		per_cpu(watchdog_touch_ts, cpu) = SOFTLOCKUP_RESET;
 	wq_watchdog_touch(-1);
 }
 
 void touch_softlockup_watchdog_sync(void)
 {
 	__this_cpu_write(softlockup_touch_sync, true);
-	__this_cpu_write(watchdog_touch_ts, 0);
+	__this_cpu_write(watchdog_touch_ts, SOFTLOCKUP_RESET);
 }
 
 static int is_softlockup(unsigned long touch_ts)
@@ -379,7 +381,7 @@ static enum hrtimer_restart watchdog_tim
 	/* .. and repeat */
 	hrtimer_forward_now(hrtimer, ns_to_ktime(sample_period));
 
-	if (touch_ts == 0) {
+	if (touch_ts == SOFTLOCKUP_RESET) {
 		if (unlikely(__this_cpu_read(softlockup_touch_sync))) {
 			/*
 			 * If the time stamp was touched atomically
