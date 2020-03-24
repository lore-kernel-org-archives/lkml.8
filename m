Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D056DC54EEB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF2F2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgCXJSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:18:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44084 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbgCXJRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:17:06 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfgH-0008DJ-7D; Tue, 24 Mar 2020 10:17:05 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2CC3A1C048C;
        Tue, 24 Mar 2020 10:16:49 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:48 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Fix rcu_barrier_callback() race condition
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504140877.28353.8781282513260518428.tip-bot2@tip-bot2>
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

Commit-ID:     aa24f93753e256c4b14fe46f7261f150cff2a50c
Gitweb:        https://git.kernel.org/tip/aa24f93753e256c4b14fe46f7261f150cff2a50c
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 20 Jan 2020 15:43:45 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 15:58:23 -08:00

rcu: Fix rcu_barrier_callback() race condition

The rcu_barrier_callback() function does an atomic_dec_and_test(), and
if it is the last CPU to check in, does the required wakeup.  Either way,
it does an event trace.  Unfortunately, this is susceptible to the
following sequence of events:

o	CPU 0 invokes rcu_barrier_callback(), but atomic_dec_and_test()
	says that it is not last.  But at this point, CPU 0 is delayed,
	perhaps due to an NMI, SMI, or vCPU preemption.

o	CPU 1 invokes rcu_barrier_callback(), and atomic_dec_and_test()
	says that it is last.  So CPU 1 traces completion and does
	the needed wakeup.

o	The awakened rcu_barrier() function does cleanup and releases
	rcu_state.barrier_mutex.

o	Another CPU now acquires rcu_state.barrier_mutex and starts
	another round of rcu_barrier() processing, including updating
	rcu_state.barrier_sequence.

o	CPU 0 gets its act back together and does its tracing.  Except
	that rcu_state.barrier_sequence has already been updated, so
	its tracing is incorrect and probably quite confusing.
	(Wait!  Why did this CPU check in twice for one rcu_barrier()
	invocation???)

This commit therefore causes rcu_barrier_callback() to take a
snapshot of the value of rcu_state.barrier_sequence before invoking
atomic_dec_and_test(), thus guaranteeing that the event-trace output
is sensible, even if the timing of the event-trace output might still
be confusing.  (Wait!  Why did the old rcu_barrier() complete before
all of its CPUs checked in???)  But being that this is RCU, only so much
confusion can reasonably be eliminated.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely and due to the mild consequences of the
failure, namely a confusing event trace.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index be59a5d..62383ce 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3077,15 +3077,22 @@ static void rcu_barrier_trace(const char *s, int cpu, unsigned long done)
 /*
  * RCU callback function for rcu_barrier().  If we are last, wake
  * up the task executing rcu_barrier().
+ *
+ * Note that the value of rcu_state.barrier_sequence must be captured
+ * before the atomic_dec_and_test().  Otherwise, if this CPU is not last,
+ * other CPUs might count the value down to zero before this CPU gets
+ * around to invoking rcu_barrier_trace(), which might result in bogus
+ * data from the next instance of rcu_barrier().
  */
 static void rcu_barrier_callback(struct rcu_head *rhp)
 {
+	unsigned long __maybe_unused s = rcu_state.barrier_sequence;
+
 	if (atomic_dec_and_test(&rcu_state.barrier_cpu_count)) {
-		rcu_barrier_trace(TPS("LastCB"), -1,
-				  rcu_state.barrier_sequence);
+		rcu_barrier_trace(TPS("LastCB"), -1, s);
 		complete(&rcu_state.barrier_completion);
 	} else {
-		rcu_barrier_trace(TPS("CB"), -1, rcu_state.barrier_sequence);
+		rcu_barrier_trace(TPS("CB"), -1, s);
 	}
 }
 
