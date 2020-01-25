Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204A4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36E924125
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbgAYKnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:43:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44401 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729903AbgAYKn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:43:28 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIuS-0000G6-Ha; Sat, 25 Jan 2020 11:43:24 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F40131C1A93;
        Sat, 25 Jan 2020 11:42:57 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:57 -0000
From:   "tip-bot2 for Neeraj Upadhyay" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Allow only one expedited GP to run concurrently
 with wakeups
Cc:     Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994897779.396.13792639185111367021.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     4bc6b745e5cbefed92c48071e28a5f41246d0470
Gitweb:        https://git.kernel.org/tip/4bc6b745e5cbefed92c48071e28a5f41246d0470
Author:        Neeraj Upadhyay <neeraju@codeaurora.org>
AuthorDate:    Tue, 19 Nov 2019 11:50:52 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 09 Dec 2019 12:24:57 -08:00

rcu: Allow only one expedited GP to run concurrently with wakeups

The current expedited RCU grace-period code expects that a task
requesting an expedited grace period cannot awaken until that grace
period has reached the wakeup phase.  However, it is possible for a long
preemption to result in the waiting task never sleeping.  For example,
consider the following sequence of events:

1.	Task A starts an expedited grace period by invoking
	synchronize_rcu_expedited().  It proceeds normally up to the
	wait_event() near the end of that function, and is then preempted
	(or interrupted or whatever).

2.	The expedited grace period completes, and a kworker task starts
	the awaken phase, having incremented the counter and acquired
	the rcu_state structure's .exp_wake_mutex.  This kworker task
	is then preempted or interrupted or whatever.

3.	Task A resumes and enters wait_event(), which notes that the
	expedited grace period has completed, and thus doesn't sleep.

4.	Task B starts an expedited grace period exactly as did Task A,
	complete with the preemption (or whatever delay) just before
	the call to wait_event().

5.	The expedited grace period completes, and another kworker
	task starts the awaken phase, having incremented the counter.
	However, it blocks when attempting to acquire the rcu_state
	structure's .exp_wake_mutex because step 2's kworker task has
	not yet released it.

6.	Steps 4 and 5 repeat, resulting in overflow of the rcu_node
	structure's ->exp_wq[] array.

In theory, this is harmless.  Tasks waiting on the various ->exp_wq[]
array will just be spuriously awakened, but they will just sleep again
on noting that the rcu_state structure's ->expedited_sequence value has
not advanced far enough.

In practice, this wastes CPU time and is an accident waiting to happen.
This commit therefore moves the rcu_exp_gp_seq_end() call that officially
ends the expedited grace period (along with associate tracing) until
after the ->exp_wake_mutex has been acquired.  This prevents Task A from
awakening prematurely, thus preventing more than one expedited grace
period from being in flight during a previous expedited grace period's
wakeup phase.

Fixes: 3b5f668e715b ("rcu: Overlap wakeups with next expedited grace period")
Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
[ paulmck: Added updated comment. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index fa143e4..7a1f093 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -539,14 +539,13 @@ static void rcu_exp_wait_wake(unsigned long s)
 	struct rcu_node *rnp;
 
 	synchronize_sched_expedited_wait();
-	rcu_exp_gp_seq_end();
-	trace_rcu_exp_grace_period(rcu_state.name, s, TPS("end"));
 
-	/*
-	 * Switch over to wakeup mode, allowing the next GP, but -only- the
-	 * next GP, to proceed.
-	 */
+	// Switch over to wakeup mode, allowing the next GP to proceed.
+	// End the previous grace period only after acquiring the mutex
+	// to ensure that only one GP runs concurrently with wakeups.
 	mutex_lock(&rcu_state.exp_wake_mutex);
+	rcu_exp_gp_seq_end();
+	trace_rcu_exp_grace_period(rcu_state.name, s, TPS("end"));
 
 	rcu_for_each_node_breadth_first(rnp) {
 		if (ULONG_CMP_LT(READ_ONCE(rnp->exp_seq_rq), s)) {
