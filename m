Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7908C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 20:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79D4220809
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 20:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SOtl6w1u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fJ9UbVAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgGPUW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 16:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgGPUWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 16:22:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20949C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 13:22:13 -0700 (PDT)
Message-Id: <20200716202044.625081169@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594930931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=NAU4ADTPI7vnkbKFUaJB3IWe3HW6RGl/KgL/tK4wrYI=;
        b=SOtl6w1uIaT2yl7e4uS1orZaEPGmggsr9lC9kOV9VNC4fZ+LSIP2MJ8awcqu6C34AkgxjO
        pf3AQMuqXUCrDkvt2kypnZreb4qdewmPrDgld65dhpwlxrCUJDjZjoblHUBI0uOg/9NjIF
        xKHJdqLOgsJyvBZwnQ83gzSIuV9zw1XA5jGJkK2754GsWiQpKMGi9ax0xHAig3W0w537/Z
        LgFOfHUauOUdZtgxXKLUkJVsDIzMOKFLKw5A26GRfaFHq4uWZy7pkcMTiEASdf9bea6BJ+
        ODTTU2f4m/9qZYVLFd6YQb4i2IhmIigcdmEqoAFJ1Yvn5WKgWJuiuUy8Zmyv7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594930931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=NAU4ADTPI7vnkbKFUaJB3IWe3HW6RGl/KgL/tK4wrYI=;
        b=fJ9UbVAmUqHcYGOOLE9dCK+g8nJd821+oQipMQ8gJVtdGd/cCb6EPTSMfYEiPQd7N42hIH
        GuZogQD6Y+NVXUBA==
Date:   Thu, 16 Jul 2020 22:19:25 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [patch V2 2/5] posix-cpu-timers: Convert the flags to a bitmap
References: <20200716201923.228696399@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For splitting the posix cpu timer code into an interrupt context check and
the actual expiry and signal handling it's required to be able to set and
test for the flags atomically.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h   |   16 +++++++--------
 include/linux/sched/cputime.h  |    2 -
 kernel/time/posix-cpu-timers.c |   43 ++++++++++++++++++-----------------------
 3 files changed, 28 insertions(+), 33 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -109,20 +109,20 @@ struct posix_cputimer_base {
 	struct timerqueue_head	tqhead;
 };
 
+enum {
+	CPUTIMERS_ACTIVE,
+	CPUTIMERS_EXPIRING,
+};
+
 /**
  * posix_cputimers - Container for posix CPU timer related data
- * @bases:		Base container for posix CPU clocks
- * @timers_active:	Timers are queued.
- * @expiry_active:	Timer expiry is active. Used for
- *			process wide timers to avoid multiple
- *			task trying to handle expiry concurrently
- *
+ * @bases:	Base container for posix CPU clocks
+ * @flags:	Flags for various CPUTIMERS_* states
  * Used in task_struct and signal_struct
  */
 struct posix_cputimers {
 	struct posix_cputimer_base	bases[CPUCLOCK_MAX];
-	unsigned int			timers_active;
-	unsigned int			expiry_active;
+	unsigned long			flags;
 };
 
 static inline void posix_cputimers_init(struct posix_cputimers *pct)
--- a/include/linux/sched/cputime.h
+++ b/include/linux/sched/cputime.h
@@ -84,7 +84,7 @@ struct thread_group_cputimer *get_runnin
 	 * Check whether posix CPU timers are active. If not the thread
 	 * group accounting is not active either. Lockless check.
 	 */
-	if (!READ_ONCE(tsk->signal->posix_cputimers.timers_active))
+	if (!test_bit(CPUTIMERS_ACTIVE, &tsk->signal->posix_cputimers.flags))
 		return NULL;
 
 	/*
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -25,7 +25,7 @@ void posix_cputimers_group_init(struct p
 	posix_cputimers_init(pct);
 	if (cpu_limit != RLIM_INFINITY) {
 		pct->bases[CPUCLOCK_PROF].nextevt = cpu_limit * NSEC_PER_SEC;
-		pct->timers_active = true;
+		set_bit(CPUTIMERS_ACTIVE, &pct->flags);
 	}
 }
 
@@ -269,7 +269,7 @@ void thread_group_sample_cputime(struct
 	struct thread_group_cputimer *cputimer = &tsk->signal->cputimer;
 	struct posix_cputimers *pct = &tsk->signal->posix_cputimers;
 
-	WARN_ON_ONCE(!pct->timers_active);
+	WARN_ON_ONCE(!test_bit(CPUTIMERS_ACTIVE, &pct->flags));
 
 	proc_sample_cputime_atomic(&cputimer->cputime_atomic, samples);
 }
@@ -292,7 +292,7 @@ static void thread_group_start_cputime(s
 	struct posix_cputimers *pct = &tsk->signal->posix_cputimers;
 
 	/* Check if cputimer isn't running. This is accessed without locking. */
-	if (!READ_ONCE(pct->timers_active)) {
+	if (!test_bit(CPUTIMERS_ACTIVE, &pct->flags)) {
 		struct task_cputime sum;
 
 		/*
@@ -304,13 +304,12 @@ static void thread_group_start_cputime(s
 		update_gt_cputime(&cputimer->cputime_atomic, &sum);
 
 		/*
-		 * We're setting timers_active without a lock. Ensure this
-		 * only gets written to in one operation. We set it after
-		 * update_gt_cputime() as a small optimization, but
+		 * We're setting CPUTIMERS_ACTIVE without a lock. We set it
+		 * after update_gt_cputime() as a small optimization, but
 		 * barriers are not required because update_gt_cputime()
 		 * can handle concurrent updates.
 		 */
-		WRITE_ONCE(pct->timers_active, true);
+		set_bit(CPUTIMERS_ACTIVE, &pct->flags);
 	}
 	proc_sample_cputime_atomic(&cputimer->cputime_atomic, samples);
 }
@@ -335,7 +334,7 @@ static u64 cpu_clock_sample_group(const
 	struct posix_cputimers *pct = &p->signal->posix_cputimers;
 	u64 samples[CPUCLOCK_MAX];
 
-	if (!READ_ONCE(pct->timers_active)) {
+	if (!test_bit(CPUTIMERS_ACTIVE, &pct->flags)) {
 		if (start)
 			thread_group_start_cputime(p, samples);
 		else
@@ -862,7 +861,7 @@ static inline void stop_process_timers(s
 	struct posix_cputimers *pct = &sig->posix_cputimers;
 
 	/* Turn off the active flag. This is done without locking. */
-	WRITE_ONCE(pct->timers_active, false);
+	clear_bit(CPUTIMERS_ACTIVE, &pct->flags);
 	tick_dep_clear_signal(sig, TICK_DEP_BIT_POSIX_TIMER);
 }
 
@@ -906,16 +905,11 @@ static void check_process_timers(struct
 	 * RLIMIT_CPU) nothing to check. Also skip the process wide timer
 	 * processing when there is already another task handling them.
 	 */
-	if (!READ_ONCE(pct->timers_active) || pct->expiry_active)
+	if (!test_bit(CPUTIMERS_ACTIVE, &pct->flags) ||
+	    test_and_set_bit(CPUTIMERS_EXPIRING, &pct->flags))
 		return;
 
 	/*
-	 * Signify that a thread is checking for process timers.
-	 * Write access to this field is protected by the sighand lock.
-	 */
-	pct->expiry_active = true;
-
-	/*
 	 * Collect the current process totals. Group accounting is active
 	 * so the sample can be taken directly.
 	 */
@@ -959,7 +953,7 @@ static void check_process_timers(struct
 	if (expiry_cache_is_inactive(pct))
 		stop_process_timers(sig);
 
-	pct->expiry_active = false;
+	clear_bit(CPUTIMERS_EXPIRING, &pct->flags);
 }
 
 /*
@@ -1057,14 +1051,15 @@ static inline bool fastpath_timer_check(
 	 * a fastpath heuristic to determine whether we should try to
 	 * acquire the sighand lock to handle timer expiry.
 	 *
-	 * In the worst case scenario, if concurrently timers_active is set
-	 * or expiry_active is cleared, but the current thread doesn't see
-	 * the change yet, the timer checks are delayed until the next
-	 * thread in the group gets a scheduler interrupt to handle the
-	 * timer. This isn't an issue in practice because these types of
-	 * delays with signals actually getting sent are expected.
+	 * In the worst case scenario, if concurrently CPUTIMERS_ACTIVE is
+	 * set or CPUTIMERS_EXPIRING is cleared, but the current thread
+	 * doesn't see the change yet, the timer checks are delayed until
+	 * the next thread in the group gets a scheduler interrupt to
+	 * handle the timer. This isn't an issue in practice because these
+	 * types of delays with signals actually getting sent are expected.
 	 */
-	if (READ_ONCE(pct->timers_active) && !READ_ONCE(pct->expiry_active)) {
+	if (test_bit(CPUTIMERS_ACTIVE, &pct->flags) &&
+	    !test_bit(CPUTIMERS_EXPIRING, &pct->flags)) {
 		u64 samples[CPUCLOCK_MAX];
 
 		proc_sample_cputime_atomic(&sig->cputimer.cputime_atomic,

