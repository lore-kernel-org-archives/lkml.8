Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C12C32771
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 00:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992C82467C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 00:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgA1AGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 19:06:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47597 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgA1AGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 19:06:31 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iwEOh-00033R-QF; Tue, 28 Jan 2020 01:06:28 +0100
Date:   Mon, 27 Jan 2020 23:49:25 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/core for
References: <158016896586.31887.7695979159638645055.tglx@nanos.tec.linutronix.de>
Message-ID: <158016896589.31887.11649925452756898441.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-core-2020-01-28

up to:  11e31f608b49: watchdog/softlockup: Enforce that timestamp is valid on boot

A set of watchdog/softlockup related improvements:

 - Enforce that the watchdog timestamp is always valid on boot. The
   original implementation caused a watchdog disabled gap of one second in
   the boot process due to truncation of the underlying sched clock. The
   sched clock is divided by 1e9 to convert nanoseconds to seconds. So for
   the first second of the boot process the result is 0 which is at the
   same time the indicator to disable the watchdog. The trivial fix is to
   change the disabled indicator to ULONG_MAX.

 - Two cleanup patches removing unused and redundant code which got
   forgotten to be cleaned up in previous changes.

Thanks,

	tglx

------------------>
Jisheng Zhang (1):
      watchdog: Remove soft_lockup_hrtimer_cnt and related code

Petr Mladek (1):
      watchdog/softlockup: Remove obsolete check of last reported task

Thomas Gleixner (1):
      watchdog/softlockup: Enforce that timestamp is valid on boot


 kernel/watchdog.c | 31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index f41334ef0971..b6b1f54a7837 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -161,6 +161,8 @@ static void lockup_detector_update_enable(void)
 
 #ifdef CONFIG_SOFTLOCKUP_DETECTOR
 
+#define SOFTLOCKUP_RESET	ULONG_MAX
+
 /* Global variables, exported for sysctl */
 unsigned int __read_mostly softlockup_panic =
 			CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE;
@@ -173,8 +175,6 @@ static DEFINE_PER_CPU(struct hrtimer, watchdog_hrtimer);
 static DEFINE_PER_CPU(bool, softlockup_touch_sync);
 static DEFINE_PER_CPU(bool, soft_watchdog_warn);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
-static DEFINE_PER_CPU(unsigned long, soft_lockup_hrtimer_cnt);
-static DEFINE_PER_CPU(struct task_struct *, softlockup_task_ptr_saved);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
 static unsigned long soft_lockup_nmi_warn;
 
@@ -274,7 +274,7 @@ notrace void touch_softlockup_watchdog_sched(void)
 	 * Preemption can be enabled.  It doesn't matter which CPU's timestamp
 	 * gets zeroed here, so use the raw_ operation.
 	 */
-	raw_cpu_write(watchdog_touch_ts, 0);
+	raw_cpu_write(watchdog_touch_ts, SOFTLOCKUP_RESET);
 }
 
 notrace void touch_softlockup_watchdog(void)
@@ -298,14 +298,14 @@ void touch_all_softlockup_watchdogs(void)
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
@@ -350,8 +350,6 @@ static DEFINE_PER_CPU(struct cpu_stop_work, softlockup_stop_work);
  */
 static int softlockup_fn(void *data)
 {
-	__this_cpu_write(soft_lockup_hrtimer_cnt,
-			 __this_cpu_read(hrtimer_interrupts));
 	__touch_watchdog();
 	complete(this_cpu_ptr(&softlockup_completion));
 
@@ -383,7 +381,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	/* .. and repeat */
 	hrtimer_forward_now(hrtimer, ns_to_ktime(sample_period));
 
-	if (touch_ts == 0) {
+	if (touch_ts == SOFTLOCKUP_RESET) {
 		if (unlikely(__this_cpu_read(softlockup_touch_sync))) {
 			/*
 			 * If the time stamp was touched atomically
@@ -416,22 +414,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 			return HRTIMER_RESTART;
 
 		/* only warn once */
-		if (__this_cpu_read(soft_watchdog_warn) == true) {
-			/*
-			 * When multiple processes are causing softlockups the
-			 * softlockup detector only warns on the first one
-			 * because the code relies on a full quiet cycle to
-			 * re-arm.  The second process prevents the quiet cycle
-			 * and never gets reported.  Use task pointers to detect
-			 * this.
-			 */
-			if (__this_cpu_read(softlockup_task_ptr_saved) !=
-			    current) {
-				__this_cpu_write(soft_watchdog_warn, false);
-				__touch_watchdog();
-			}
+		if (__this_cpu_read(soft_watchdog_warn) == true)
 			return HRTIMER_RESTART;
-		}
 
 		if (softlockup_all_cpu_backtrace) {
 			/* Prevent multiple soft-lockup reports if one cpu is already
@@ -447,7 +431,6 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
 			smp_processor_id(), duration,
 			current->comm, task_pid_nr(current));
-		__this_cpu_write(softlockup_task_ptr_saved, current);
 		print_modules();
 		print_irqtrace_events(current);
 		if (regs)

