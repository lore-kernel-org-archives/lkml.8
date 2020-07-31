Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E179C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAEE8208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m/r311uI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ixRn1yl/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732742AbgGaJZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:25:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56564 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732494AbgGaJXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:35 -0400
Date:   Fri, 31 Jul 2020 09:23:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187413;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=gboqRKAb93jmSdoidRqAOCDhYFMRQ6WuqGYxjzaGUBc=;
        b=m/r311uIKhv57Vh81sCtACEOPewxz1d7Logn9tiHRignb6EmSzO8a2fgkqAFPYPDzgF0eo
        IHcWTGh8De8UO/48F/h2D6cKrl+DI2Y/D9ey9mMBIasyiBwm8uAejJHU6oDcezvizwdZFb
        H9eUkiBs/BygpQmbkQ3B/hj6mNqvlefiBmLOOKCUnq8BdzqGn68vYnrQUxOPFP6HaFsAb8
        rbYkMSz2ZsvJCMyymLxBB4sLlRzWcjp4up9y30TMmDUeYOtAeJ89dCLv3UQIdPVisqb+VA
        /FtggTkmJ9qZ+htGFZeZgxo0bO5rIPPa4jM+3wO9j0G6d8InSZ83BJo7eiwv+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187413;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=gboqRKAb93jmSdoidRqAOCDhYFMRQ6WuqGYxjzaGUBc=;
        b=ixRn1yl/qzaVSUOnaS4CaRZt3IKriGrFFwyemgHysSpsFjXdRv1aaHZSLwW5x/2j3JHwbC
        w8mHNeyZttDYhtCQ==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] tick/nohz: Narrow down noise while setting current
 task's tick dependency
Cc:     Matt Fleming <matt@codeblueprint.co.uk>,
        Frederic Weisbecker <frederic@kernel.org>, stable@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618741260.4006.6844787797487792202.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     3c8920e2dbd1a55f72dc14d656df9d0097cf5c72
Gitweb:        https://git.kernel.org/tip/3c8920e2dbd1a55f72dc14d656df9d0097cf5c72
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 15 May 2020 02:34:29 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:58:50 -07:00

tick/nohz: Narrow down noise while setting current task's tick dependency

Setting a tick dependency on any task, including the case where a task
sets that dependency on itself, triggers an IPI to all CPUs.  That is
of course suboptimal but it had previously not been an issue because it
was only used by POSIX CPU timers on nohz_full, which apparently never
occurs in latency-sensitive workloads in production.  (Or users of such
systems are suffering in silence on the one hand or venting their ire
on the wrong people on the other.)

But RCU now sets a task tick dependency on the current task in order
to fix stall issues that can occur during RCU callback processing.
Thus, RCU callback processing triggers frequent system-wide IPIs from
nohz_full CPUs.  This is quite counter-productive, after all, avoiding
IPIs is what nohz_full is supposed to be all about.

This commit therefore optimizes tasks' self-setting of a task tick
dependency by using tick_nohz_full_kick() to avoid the system-wide IPI.
Instead, only the execution of the one task is disturbed, which is
acceptable given that this disturbance is well down into the noise
compared to the degree to which the RCU callback processing itself
disturbs execution.

Fixes: 6a949b7af82d (rcu: Force on tick when invoking lots of callbacks)
Reported-by: Matt Fleming <matt@codeblueprint.co.uk>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: stable@kernel.org
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/time/tick-sched.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 3e2dc9b..f0199a4 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -351,16 +351,24 @@ void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit)
 EXPORT_SYMBOL_GPL(tick_nohz_dep_clear_cpu);
 
 /*
- * Set a per-task tick dependency. Posix CPU timers need this in order to elapse
- * per task timers.
+ * Set a per-task tick dependency. RCU need this. Also posix CPU timers
+ * in order to elapse per task timers.
  */
 void tick_nohz_dep_set_task(struct task_struct *tsk, enum tick_dep_bits bit)
 {
-	/*
-	 * We could optimize this with just kicking the target running the task
-	 * if that noise matters for nohz full users.
-	 */
-	tick_nohz_dep_set_all(&tsk->tick_dep_mask, bit);
+	if (!atomic_fetch_or(BIT(bit), &tsk->tick_dep_mask)) {
+		if (tsk == current) {
+			preempt_disable();
+			tick_nohz_full_kick();
+			preempt_enable();
+		} else {
+			/*
+			 * Some future tick_nohz_full_kick_task()
+			 * should optimize this.
+			 */
+			tick_nohz_full_kick_all();
+		}
+	}
 }
 EXPORT_SYMBOL_GPL(tick_nohz_dep_set_task);
 
