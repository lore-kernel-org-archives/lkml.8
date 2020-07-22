Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608E9C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37E662077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Ef6DFxX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6P67u8ld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731173AbgGVJMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:12:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46884 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgGVJM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:12:27 -0400
Date:   Wed, 22 Jul 2020 09:12:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595409143;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=z1qh6CSfw9mrQCVNV5ghiXKMtbtljaK+YtCwdajf64o=;
        b=3Ef6DFxXuzKOIAnMqLrT29a09z5KCKybKm9H9nJPUGkpGHzH1KkEhrA+r82MmRU6EZ863H
        dqVH2wBWqEPjPAq8qH5vCSZHxBvbPjl4P40y+87hfeNGa9E7MX4la1uRQZHxDFaodcuXd3
        51iZP32jmcIcv/K1+oHwNB0880mkeZVdz/J6c71zkfT30DYbDoFKl4Q/SskO3dz7Fg1xJm
        PZQBJp8XUrhAWLOlSOe3Aip+kfpaStfNpQhL0HS+6P1RN5M8wy4Klg6lZDUyPKpF4Qilic
        4IvpFEqrJGy8Y7js3JtxWZIRLq/+MCVPihQBIbKsm5PEHEuW0zk0a4g1bRqNPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595409143;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=z1qh6CSfw9mrQCVNV5ghiXKMtbtljaK+YtCwdajf64o=;
        b=6P67u8ldZozTPG2baKfnJrUdRxFUfbKtE7BUtNHefbENijSxzxbHNLREMp/d3KTbaFqnG6
        1gsl0Cpk8ghK3zBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Fix race against ptrace_freeze_trace()
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159540914264.4006.8441424283734137782.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     d136122f58458479fd8926020ba2937de61d7f65
Gitweb:        https://git.kernel.org/tip/d136122f58458479fd8926020ba2937de61d7f65
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 20 Jul 2020 17:20:21 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Jul 2020 10:22:00 +02:00

sched: Fix race against ptrace_freeze_trace()

There is apparently one site that violates the rule that only current
and ttwu() will modify task->state, namely ptrace_{,un}freeze_traced()
will change task->state for a remote task.

Oleg explains:

  "TASK_TRACED/TASK_STOPPED was always protected by siglock. In
particular, ttwu(__TASK_TRACED) must be always called with siglock
held. That is why ptrace_freeze_traced() assumes it can safely do
s/TASK_TRACED/__TASK_TRACED/ under spin_lock(siglock)."

This breaks the ordering scheme introduced by commit:

  dbfb089d360b ("sched: Fix loadavg accounting race")

Specifically, the reload not matching no longer implies we don't have
to block.

Simply things by noting that what we need is a LOAD->STORE ordering
and this can be provided by a control dependency.

So replace:

	prev_state = prev->state;
	raw_spin_lock(&rq->lock);
	smp_mb__after_spinlock(); /* SMP-MB */
	if (... && prev_state && prev_state == prev->state)
		deactivate_task();

with:

	prev_state = prev->state;
	if (... && prev_state) /* CTRL-DEP */
		deactivate_task();

Since that already implies the 'prev->state' load must be complete
before allowing the 'prev->on_rq = 0' store to become visible.

Fixes: dbfb089d360b ("sched: Fix loadavg accounting race")
Reported-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Tested-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Tested-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 kernel/sched/core.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e15543c..5dece9b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4119,9 +4119,6 @@ static void __sched notrace __schedule(bool preempt)
 	local_irq_disable();
 	rcu_note_context_switch(preempt);
 
-	/* See deactivate_task() below. */
-	prev_state = prev->state;
-
 	/*
 	 * Make sure that signal_pending_state()->signal_pending() below
 	 * can't be reordered with __set_current_state(TASK_INTERRUPTIBLE)
@@ -4145,11 +4142,16 @@ static void __sched notrace __schedule(bool preempt)
 	update_rq_clock(rq);
 
 	switch_count = &prev->nivcsw;
+
 	/*
-	 * We must re-load prev->state in case ttwu_remote() changed it
-	 * before we acquired rq->lock.
+	 * We must load prev->state once (task_struct::state is volatile), such
+	 * that:
+	 *
+	 *  - we form a control dependency vs deactivate_task() below.
+	 *  - ptrace_{,un}freeze_traced() can change ->state underneath us.
 	 */
-	if (!preempt && prev_state && prev_state == prev->state) {
+	prev_state = prev->state;
+	if (!preempt && prev_state) {
 		if (signal_pending_state(prev_state, prev)) {
 			prev->state = TASK_RUNNING;
 		} else {
@@ -4163,10 +4165,12 @@ static void __sched notrace __schedule(bool preempt)
 
 			/*
 			 * __schedule()			ttwu()
-			 *   prev_state = prev->state;	  if (READ_ONCE(p->on_rq) && ...)
-			 *   LOCK rq->lock		    goto out;
-			 *   smp_mb__after_spinlock();	  smp_acquire__after_ctrl_dep();
-			 *   p->on_rq = 0;		  p->state = TASK_WAKING;
+			 *   prev_state = prev->state;    if (p->on_rq && ...)
+			 *   if (prev_state)		    goto out;
+			 *     p->on_rq = 0;		  smp_acquire__after_ctrl_dep();
+			 *				  p->state = TASK_WAKING
+			 *
+			 * Where __schedule() and ttwu() have matching control dependencies.
 			 *
 			 * After this, schedule() must not care about p->state any more.
 			 */
