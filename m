Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12520C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE3672068F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q7yDDGuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgGTK7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 06:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbgGTK7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 06:59:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09476C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 03:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WkI8Ve7E4cYmGfDgoDIy+3v2c4Cg5HucNSZPRMZX6+M=; b=Q7yDDGuOyd/y4alAGQtdNMRItV
        AG8KGwE8L00CMSu2DUcoO1LsiULwNuSQOktbO3J1a9swL6dnK4Jnp8siDi3caDIiibOi7VJ4TuaIh
        gLYzmq0BGuCTnXnEsckOt1Ab/5S7T1J9MPDkseAI3b2SQjNsX+bP0HZVKP4mjUsA7HLIAWB20Ibn8
        p7S/l4LTVsOlNEbi4nX4jVT9v49GEUrRzgMESJxbgsXiMW7nVgfewIlaqii2sW7WwHYSOBNuPrRgD
        +j1Mdn/3zDs3HtPw+pQT6BJgjpwAGdPhaJ8w8hJWr2YpDxxr0kLSF2p8jrF8LRZvSsN74Jipd+H5G
        qN//LZiQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxTW3-00072M-Uy; Mon, 20 Jul 2020 10:59:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0682E300446;
        Mon, 20 Jul 2020 12:59:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E1BF1200D4EAD; Mon, 20 Jul 2020 12:59:24 +0200 (CEST)
Date:   Mon, 20 Jul 2020 12:59:24 +0200
From:   peterz@infradead.org
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        christian@brauner.io, "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Dave Jones <davej@codemonkey.org.uk>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: 5.8-rc*: kernel BUG at kernel/signal.c:1917
Message-ID: <20200720105924.GE43129@hirez.programming.kicks-ass.net>
References: <5a8c4c38-7aeb-981a-8d3b-a7a5c8ca5564@kernel.org>
 <20200717122651.GA6067@redhat.com>
 <20200717124017.GB6067@redhat.com>
 <2c8ef23c-43b4-39d4-8e84-92769c948da9@kernel.org>
 <20200718171406.GB16791@redhat.com>
 <20200718174448.4btbjcvp6wbbdgts@wittgenstein>
 <badcb9d5-f628-2be1-7a72-902cf08010bd@kernel.org>
 <20200720064326.GA6612@redhat.com>
 <20200720082657.GC6612@redhat.com>
 <20200720084106.GJ10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720084106.GJ10769@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 10:41:06AM +0200, Peter Zijlstra wrote:
> On Mon, Jul 20, 2020 at 10:26:58AM +0200, Oleg Nesterov wrote:
> > Peter,
> > 
> > Let me add another note. TASK_TRACED/TASK_STOPPED was always protected by
> > ->siglock. In particular, ttwu(__TASK_TRACED) must be always called with
> > ->siglock held. That is why ptrace_freeze_traced() assumes it can safely
> > do s/TASK_TRACED/__TASK_TRACED/ under spin_lock(siglock).
> > 
> > Can this change race with
> > 
> > 		if (signal_pending_state(prev->state, prev)) {
> > 			prev->state = TASK_RUNNING;
> > 		}
> > 
> > in __schedule() ? Hopefully not, signal-state is protected by siglock too.
> > 
> > So I think this logic was correct even if it doesn't look nice. But "doesn't
> > look nice" is true for the whole ptrace code ;)
> 
> *groan*... another bit of obscure magic :-(
> 
> let me go try and wake up and figure out how best to deal with this.

So clearly I'm still missing something, the below results in:

[   63.760863] ------------[ cut here ]------------
[   63.766019] !(tmp_state & __TASK_TRACED)
[   63.766030] WARNING: CPU: 33 PID: 33801 at kernel/sched/core.c:4158 __schedule+0x6bd/0x8e0

Also, is there any way to not have ptrace do this? How performance
critical is this ptrace path? Because I really hate having to add code
to __schedule() to deal with this horrible thing.


---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e15543cb84812..f65a801d268b6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4100,9 +4100,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  */
 static void __sched notrace __schedule(bool preempt)
 {
+	unsigned long prev_state, tmp_state;
 	struct task_struct *prev, *next;
 	unsigned long *switch_count;
-	unsigned long prev_state;
 	struct rq_flags rf;
 	struct rq *rq;
 	int cpu;
@@ -4140,16 +4140,38 @@ static void __sched notrace __schedule(bool preempt)
 	rq_lock(rq, &rf);
 	smp_mb__after_spinlock();
 
+	/*
+	 * We must re-load prev->state in case ttwu_remote() changed it
+	 * before we acquired rq->lock.
+	 */
+	tmp_state = prev->state;
+	if (unlikely(prev_state != tmp_state)) {
+		if (prev_state & __TASK_TRACED) {
+			/*
+			 * ptrace_{,un}freeze_traced() think it is cool
+			 * to change ->state around behind our backs
+			 * between TASK_TRACED and __TASK_TRACED.
+			 *
+			 * Luckily this transformation doesn't affect
+			 * sched_contributes_to_load.
+			 */
+			SCHED_WARN_ON(!(tmp_state & __TASK_TRACED));
+		} else {
+			/*
+			 * For any other case, a changed prev_state
+			 * must be to TASK_RUNNING, such that...
+			 */
+			SCHED_WARN_ON(tmp_state != TASK_RUNNING);
+		}
+		prev_state = tmp_state;
+	}
+
 	/* Promote REQ to ACT */
 	rq->clock_update_flags <<= 1;
 	update_rq_clock(rq);
 
 	switch_count = &prev->nivcsw;
-	/*
-	 * We must re-load prev->state in case ttwu_remote() changed it
-	 * before we acquired rq->lock.
-	 */
-	if (!preempt && prev_state && prev_state == prev->state) {
+	if (!preempt && prev_state) {
 		if (signal_pending_state(prev_state, prev)) {
 			prev->state = TASK_RUNNING;
 		} else {
