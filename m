Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D7FC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78401206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YNa1RUNr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgGUMNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 08:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgGUMNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 08:13:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F9EC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 05:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KDfz+fImwH1fddn6fZkMotr7dFr06pVdhVjh3Sgs7KM=; b=YNa1RUNr7BQ62+t00ANCFEdvzP
        WjIVk5xuNVl+HpJLngRrsmYke7fLZpHNYBmkLRrr5CzIKcERUT8jW/HhAC+dHpNjwL8Fq6UfYcEku
        Dgvd56l46AjVFEe/XngA5R+LIpxTMT+0kJfdFubImMQdNaCdQrHW901/Tpcpqn2ondqnXvDSbDT5j
        8Zo2GrC09f9r5+KHklj60sqC0Q2jIhyn7QJlyh//zLJMhyFHJo+u5cPucAa3xNCdO26nfqM2HxKZe
        O4RVv9qqZ1zls6ac0OZUg5u3++AmOunkdTHob8fn6yYTpoxd8UcutOvIH/QkUWYXmiwTZUdCneG8d
        nsA0PLcg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxr8v-0001Ze-Kl; Tue, 21 Jul 2020 12:13:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7F7E3301AC6;
        Tue, 21 Jul 2020 14:13:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5012220D27A9D; Tue, 21 Jul 2020 14:13:08 +0200 (CEST)
Date:   Tue, 21 Jul 2020 14:13:08 +0200
From:   peterz@infradead.org
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Jiri Slaby <jirislaby@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Dave Jones <davej@codemonkey.org.uk>
Subject: [PATCH] sched: Fix race against ptrace_freeze_trace()
Message-ID: <20200721121308.GH43129@hirez.programming.kicks-ass.net>
References: <20200718174448.4btbjcvp6wbbdgts@wittgenstein>
 <badcb9d5-f628-2be1-7a72-902cf08010bd@kernel.org>
 <20200720064326.GA6612@redhat.com>
 <20200720082657.GC6612@redhat.com>
 <20200720084106.GJ10769@hirez.programming.kicks-ass.net>
 <20200720105924.GE43129@hirez.programming.kicks-ass.net>
 <20200720140224.GD6612@redhat.com>
 <20200720142105.GR10769@hirez.programming.kicks-ass.net>
 <20200721045251.GA28481@windriver.com>
 <20200721083753.GH119549@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721083753.GH119549@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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
Tested-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4193,9 +4193,6 @@ static void __sched notrace __schedule(b
 	local_irq_disable();
 	rcu_note_context_switch(preempt);
 
-	/* See deactivate_task() below. */
-	prev_state = prev->state;
-
 	/*
 	 * Make sure that signal_pending_state()->signal_pending() below
 	 * can't be reordered with __set_current_state(TASK_INTERRUPTIBLE)
@@ -4219,11 +4216,16 @@ static void __sched notrace __schedule(b
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
@@ -4237,10 +4239,12 @@ static void __sched notrace __schedule(b
 
 			/*
 			 * __schedule()			ttwu()
-			 *   prev_state = prev->state;	  if (READ_ONCE(p->on_rq) && ...)
-			 *   LOCK rq->lock		    goto out;
-			 *   smp_mb__after_spinlock();	  smp_acquire__after_ctrl_dep();
-			 *   p->on_rq = 0;		  p->state = TASK_WAKING;
+			 *   if (prev_state)		  if (p->on_rq && ...)
+			 *     p->on_rq = 0;		    goto out;
+			 *				  smp_acquire__after_ctrl_dep();
+			 *				  p->state = TASK_WAKING
+			 *
+			 * Where __schedule() and ttwu() have matching control dependencies.
 			 *
 			 * After this, schedule() must not care about p->state any more.
 			 */
