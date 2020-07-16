Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8DCC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 20:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61BC0207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 20:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xCMiFAxN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OQ1wX4c5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgGPUWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 16:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgGPUWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 16:22:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601F2C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 13:22:14 -0700 (PDT)
Message-Id: <20200716202044.734067877@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594930933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=rxlF2U74TqQoYQ5EOFGtAMYCE09nlq1RO3/GYBz2Boc=;
        b=xCMiFAxNuIulICj7DCsiVPB4uzKiHNtSOgbX/HC44TXld747/Y6PcHEKwpGpyQYtqZon+P
        jwhZDduRy1u+cf4oZ1j8dd3l8iigiiwDZWyDGvoarjww8xJnZdKMTr6Cj31IeUoABEXk5s
        h1qg2TcvZi4CwImtiJArDfcFm93fvIAS2MozK7s7C4N3SKTGswXkOJnFx/wethTW3UL52G
        2N7yZj8iERPtJHKw3nW4CeP8OUUv1RxmF91T/HuK9riStNRUOkA//NDMjLK7c2n4hg8Hci
        fDNwx8x/1FI5CZuFLrkna6obcx94tPvr+xKYguQ7eTnXtZQO8LTRXsN+q4QO5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594930933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=rxlF2U74TqQoYQ5EOFGtAMYCE09nlq1RO3/GYBz2Boc=;
        b=OQ1wX4c5THPjcpDIDbZAUThX4eHzSWmO+5dBnnEkCasLnrSTJ9tvFX1+Wd6wnnUfTMrOw4
        Lje1zgOvlDSXDUAA==
Date:   Thu, 16 Jul 2020 22:19:26 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [patch V2 3/5] posix-cpu-timers: Provide mechanisms to defer timer
 handling to task_work
References: <20200716201923.228696399@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running posix cpu timers in hard interrupt context has a few downsides:

 - For PREEMPT_RT it cannot work as the expiry code needs to take
   sighand lock, which is a 'sleeping spinlock' in RT. The original RT
   approach of offloading the posix CPU timer handling into a high
   priority thread was clumsy and provided no real benefit in general.

 - For fine grained accounting it's just wrong to run this in context of
   the timer interrupt because that way a process specific cpu time is
   accounted to the timer interrupt.

 - Long running timer interrupts caused by a large amount of expiring
   timers which can be created and armed by unpriviledged user space.

There is no hard requirement to expire them in interrupt context.

Provide infrastructure to schedule task work which allows splitting the
posix CPU timer code into a quick check in interrupt context and a thread
context expiry and signal delivery function. This has to be enabled by
architectures as it requires that the architecture specific KVM
implementation handles pending task work before exiting to guest mode.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h   |   17 ++++++++++++++++
 kernel/time/Kconfig            |    5 ++++
 kernel/time/posix-cpu-timers.c |   42 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 63 insertions(+), 1 deletion(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -112,25 +112,42 @@ struct posix_cputimer_base {
 enum {
 	CPUTIMERS_ACTIVE,
 	CPUTIMERS_EXPIRING,
+	CPUTIMERS_WORK_SCHEDULED,
 };
 
 /**
  * posix_cputimers - Container for posix CPU timer related data
  * @bases:	Base container for posix CPU clocks
  * @flags:	Flags for various CPUTIMERS_* states
+ * @task_work:	Task work to defer timer expiry into task context
  * Used in task_struct and signal_struct
  */
 struct posix_cputimers {
 	struct posix_cputimer_base	bases[CPUCLOCK_MAX];
 	unsigned long			flags;
+#ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
+	struct callback_head		task_work;
+#endif
 };
 
+#ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
+void posix_cpu_timers_work(struct callback_head *work);
+
+static inline void posix_cputimer_init_work(struct posix_cputimers *pct)
+{
+	pct->task_work.func = posix_cpu_timers_work;
+}
+#else
+static inline void posix_cputimer_init_work(struct posix_cputimers *pct) { }
+#endif
+
 static inline void posix_cputimers_init(struct posix_cputimers *pct)
 {
 	memset(pct, 0, sizeof(*pct));
 	pct->bases[0].nextevt = U64_MAX;
 	pct->bases[1].nextevt = U64_MAX;
 	pct->bases[2].nextevt = U64_MAX;
+	posix_cputimer_init_work(pct);
 }
 
 void posix_cputimers_group_init(struct posix_cputimers *pct, u64 cpu_limit);
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -52,6 +52,11 @@ config GENERIC_CLOCKEVENTS_MIN_ADJUST
 config GENERIC_CMOS_UPDATE
 	bool
 
+# Select to handle posix CPU timers from task_work
+# and not from the timer interrupt context
+config POSIX_CPU_TIMERS_TASK_WORK
+	bool
+
 if GENERIC_CLOCKEVENTS
 menu "Timers subsystem"
 
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -14,6 +14,7 @@
 #include <linux/tick.h>
 #include <linux/workqueue.h>
 #include <linux/compat.h>
+#include <linux/task_work.h>
 #include <linux/sched/deadline.h>
 
 #include "posix-timers.h"
@@ -1075,7 +1076,9 @@ static inline bool fastpath_timer_check(
 	return false;
 }
 
-static void __run_posix_cpu_timers(struct task_struct *tsk)
+static inline void posix_cpu_timers_enable_work(struct task_struct *tsk);
+
+static void handle_posix_cpu_timers(struct task_struct *tsk)
 {
 	struct k_itimer *timer, *next;
 	unsigned long flags;
@@ -1096,6 +1099,12 @@ static void __run_posix_cpu_timers(struc
 	check_process_timers(tsk, &firing);
 
 	/*
+	 * Allow new work to be scheduled. The expiry cache
+	 * is up to date.
+	 */
+	posix_cpu_timers_enable_work(tsk);
+
+	/*
 	 * We must release these locks before taking any timer's lock.
 	 * There is a potential race with timer deletion here, as the
 	 * siglock now protects our private firing list.  We have set
@@ -1130,6 +1139,37 @@ static void __run_posix_cpu_timers(struc
 	lockdep_posixtimer_exit();
 }
 
+#ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
+
+void posix_cpu_timers_work(struct callback_head *work)
+{
+	handle_posix_cpu_timers(current);
+}
+
+static void __run_posix_cpu_timers(struct task_struct *tsk)
+{
+	struct posix_cputimers *pct = &tsk->posix_cputimers;
+
+	if (!test_and_set_bit(CPUTIMERS_WORK_SCHEDULED, &pct->flags))
+		task_work_add(tsk, &pct->task_work, true);
+}
+
+static inline void posix_cpu_timers_enable_work(struct task_struct *tsk)
+{
+	clear_bit(CPUTIMERS_WORK_SCHEDULED, &tsk->posix_cputimers.flags);
+}
+
+#else
+
+static void __run_posix_cpu_timers(struct task_struct *tsk)
+{
+	handle_posix_cpu_timers(tsk);
+}
+
+static inline void posix_cpu_timers_enable_work(struct task_struct *tsk) { }
+
+#endif
+
 /*
  * This is called from the timer interrupt handler.  The irq handler has
  * already updated our counts.  We need to check if any timers fire now.

