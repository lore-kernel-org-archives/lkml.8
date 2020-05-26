Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A278C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7482D20776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aG5nD1W/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388339AbgEZQY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 12:24:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35180 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbgEZQYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=SZDV5djZEEGks8Rsfo0VC59d+OI58hadDxXrlOiA/0Q=; b=aG5nD1W/Y2jXtiFwpF5mukzbVq
        10OV6FJqpekLGCAPPUWZDaXKEkvP4z/8mmY/HHELADou3plKE5g+j2KhEi6y/I+dE42TfZvA5gO7X
        8gV/SfzN75LySTVWiXE6Hu2GTbYsfqv6FoEW0+7e/+oLkT4o+7MOOg2gpMZZoSnKvUejSvLOqvTdx
        nLFB81AT4xkEMhk+DpQMuQU1ezsqQ24lkxfJEIgwgtwYkomsPl1UiSKLlq0brqzFpug2C0CULUu1N
        90u1LR3MudB+6I2OChTj+G1jl7ROffxWOGZaqkW9oCFuCCB7gDPyAs9CSd8Og2vtjWpEr8l/d4B8s
        pbjUy6nQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdcIv-0005Te-7p; Tue, 26 May 2020 16:19:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C4CC9306A8C;
        Tue, 26 May 2020 18:19:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5E61120FF793A; Tue, 26 May 2020 18:19:41 +0200 (CEST)
Message-ID: <20200526161908.070399698@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 26 May 2020 18:11:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, cai@lca.pw,
        mgorman@techsingularity.net, peterz@infradead.org
Subject: [RFC][PATCH 6/7] sched: Add rq::ttwu_pending
References: <20200526161057.531933155@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of removing rq->wake_list, replace the
!list_empty(rq->wake_list) with rq->ttwu_pending. This is not fully
equivalent as this new variable is racy.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  |   13 +++++++++++--
 kernel/sched/debug.c |    1 -
 kernel/sched/fair.c  |    2 +-
 kernel/sched/sched.h |    4 +++-
 4 files changed, 15 insertions(+), 5 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2275,13 +2275,21 @@ static int ttwu_remote(struct task_struc
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
 
@@ -2312,6 +2320,7 @@ static void ttwu_queue_remote(struct tas
 
 	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
 
+	WRITE_ONCE(rq->ttwu_pending, 1);
 	if (llist_add(&p->wake_entry, &rq->wake_list)) {
 		if (!set_nr_if_polling(rq->idle))
 			smp_call_function_single_async(cpu, &rq->wake_csd);
@@ -4668,7 +4677,7 @@ int idle_cpu(int cpu)
 		return 0;
 
 #ifdef CONFIG_SMP
-	if (!llist_empty(&rq->wake_list))
+	if (rq->ttwu_pending)
 		return 0;
 #endif
 
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -638,7 +638,6 @@ do {									\
 
 	P(nr_running);
 	P(nr_switches);
-	P(nr_load_updates);
 	P(nr_uninterruptible);
 	PN(next_balance);
 	SEQ_printf(m, "  .%-30s: %ld\n", "curr->pid", (long)(task_pid_nr(rq->curr)));
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8590,7 +8590,7 @@ static int idle_cpu_without(int cpu, str
 	 */
 
 #ifdef CONFIG_SMP
-	if (!llist_empty(&rq->wake_list))
+	if (rq->ttwu_pending)
 		return 0;
 #endif
 
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


