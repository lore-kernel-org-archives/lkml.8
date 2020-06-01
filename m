Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD81C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BE9C20772
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgFAJxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgFAJw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:52:27 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B482C08C5CB;
        Mon,  1 Jun 2020 02:52:25 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jfh7D-0003eU-Jj; Mon, 01 Jun 2020 11:52:19 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 368D61C0244;
        Mon,  1 Jun 2020 11:52:19 +0200 (CEST)
Date:   Mon, 01 Jun 2020 09:52:19 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Add rq::ttwu_pending
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200526161908.070399698@infradead.org>
References: <20200526161908.070399698@infradead.org>
MIME-Version: 1.0
Message-ID: <159100513908.17951.6891189145567674436.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     126c2092e5c8b28623cb890cd2930aa292410676
Gitweb:        https://git.kernel.org/tip/126c2092e5c8b28623cb890cd2930aa292410676
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 26 May 2020 18:11:03 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 28 May 2020 10:54:16 +02:00

sched: Add rq::ttwu_pending

In preparation of removing rq->wake_list, replace the
!list_empty(rq->wake_list) with rq->ttwu_pending. This is not fully
equivalent as this new variable is racy.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200526161908.070399698@infradead.org
---
 kernel/sched/core.c  | 13 +++++++++++--
 kernel/sched/debug.c |  1 -
 kernel/sched/fair.c  |  2 +-
 kernel/sched/sched.h |  4 +++-
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fa0d499..b71ed5e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2275,13 +2275,21 @@ static int ttwu_remote(struct task_struct *p, int wake_flags)
 void sched_ttwu_pending(void)
 {
 	struct rq *rq = this_rq();
-	struct llist_node *llist = llist_del_all(&rq->wake_list);
+	struct llist_node *llist;
 	struct task_struct *p, *t;
 	struct rq_flags rf;
 
+	llist = llist_del_all(&rq->wake_list);
 	if (!llist)
 		return;
 
+	/*
+	 * rq::ttwu_pending racy indication of out-standing wakeups.
+	 * Races such that false-negatives are possible, since they
+	 * are shorter lived that false-positives would be.
+	 */
+	WRITE_ONCE(rq->ttwu_pending, 0);
+
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
 
@@ -2318,6 +2326,7 @@ static void __ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags
 
 	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
 
+	WRITE_ONCE(rq->ttwu_pending, 1);
 	if (llist_add(&p->wake_entry, &rq->wake_list)) {
 		if (!set_nr_if_polling(rq->idle))
 			smp_call_function_single_async(cpu, &rq->wake_csd);
@@ -4705,7 +4714,7 @@ int idle_cpu(int cpu)
 		return 0;
 
 #ifdef CONFIG_SMP
-	if (!llist_empty(&rq->wake_list))
+	if (rq->ttwu_pending)
 		return 0;
 #endif
 
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 1c24a6b..36c5426 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -638,7 +638,6 @@ do {									\
 
 	P(nr_running);
 	P(nr_switches);
-	P(nr_load_updates);
 	P(nr_uninterruptible);
 	PN(next_balance);
 	SEQ_printf(m, "  .%-30s: %ld\n", "curr->pid", (long)(task_pid_nr(rq->curr)));
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2890bd5..0ed04d2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8590,7 +8590,7 @@ static int idle_cpu_without(int cpu, struct task_struct *p)
 	 */
 
 #ifdef CONFIG_SMP
-	if (!llist_empty(&rq->wake_list))
+	if (rq->ttwu_pending)
 		return 0;
 #endif
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 75b0629..c86fc94 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -895,7 +895,9 @@ struct rq {
 	atomic_t		nohz_flags;
 #endif /* CONFIG_NO_HZ_COMMON */
 
-	unsigned long		nr_load_updates;
+#ifdef CONFIG_SMP
+	unsigned int		ttwu_pending;
+#endif
 	u64			nr_switches;
 
 #ifdef CONFIG_UCLAMP_TASK
