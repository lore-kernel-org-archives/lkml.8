Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2060C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AE6122B4D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XRdjG9aG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgGTL0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 07:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbgGTL0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 07:26:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5A8C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 04:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QmcR/WJErNktzhfvR+IA0nw9TgotnNIvGmU7PfPVzvg=; b=XRdjG9aG2kS8rwH2hl32koil68
        Dp8p+RYnmwsLnvrXWPUnHM9N7abUWnwea9XbLKuB2fY2dGgaaJmbSytclyWQgT++ZuTwp/ajcubKL
        xW/771Is76m7rAk6Ffu/wgLd5oFlqEXzz0aw1yPKk8mFfVD/+vHhSRFOujzc+KwQtc8Z3l9janFtB
        pi7HBZZY8iPautC6idjRjwcUmptbeGhUHnjj3z8O1OzVUFpffzsdyhTKvExk6Tf2N1ylw0b4MtzoS
        5mfgqXBdwwliGo9fOZzkpaSnIODjCKaXTyH0Yn3YaBMB6kWXB1Bi5WfdrVJG1b4MTonR7g56n8BRO
        KwUkizXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxTw8-0000Bv-1y; Mon, 20 Jul 2020 11:26:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 633C3301AC6;
        Mon, 20 Jul 2020 13:26:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 506ED200D4EAD; Mon, 20 Jul 2020 13:26:23 +0200 (CEST)
Date:   Mon, 20 Jul 2020 13:26:23 +0200
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
Message-ID: <20200720112623.GF43129@hirez.programming.kicks-ass.net>
References: <20200717122651.GA6067@redhat.com>
 <20200717124017.GB6067@redhat.com>
 <2c8ef23c-43b4-39d4-8e84-92769c948da9@kernel.org>
 <20200718171406.GB16791@redhat.com>
 <20200718174448.4btbjcvp6wbbdgts@wittgenstein>
 <badcb9d5-f628-2be1-7a72-902cf08010bd@kernel.org>
 <20200720064326.GA6612@redhat.com>
 <20200720082657.GC6612@redhat.com>
 <20200720084106.GJ10769@hirez.programming.kicks-ass.net>
 <20200720105924.GE43129@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720105924.GE43129@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 12:59:24PM +0200, peterz@infradead.org wrote:
> On Mon, Jul 20, 2020 at 10:41:06AM +0200, Peter Zijlstra wrote:
> > On Mon, Jul 20, 2020 at 10:26:58AM +0200, Oleg Nesterov wrote:
> > > Peter,
> > > 
> > > Let me add another note. TASK_TRACED/TASK_STOPPED was always protected by
> > > ->siglock. In particular, ttwu(__TASK_TRACED) must be always called with
> > > ->siglock held. That is why ptrace_freeze_traced() assumes it can safely
> > > do s/TASK_TRACED/__TASK_TRACED/ under spin_lock(siglock).
> > > 
> > > Can this change race with
> > > 
> > > 		if (signal_pending_state(prev->state, prev)) {
> > > 			prev->state = TASK_RUNNING;
> > > 		}
> > > 
> > > in __schedule() ? Hopefully not, signal-state is protected by siglock too.
> > > 
> > > So I think this logic was correct even if it doesn't look nice. But "doesn't
> > > look nice" is true for the whole ptrace code ;)
> > 
> > *groan*... another bit of obscure magic :-(
> > 
> > let me go try and wake up and figure out how best to deal with this.

This then? That seems to survive the strace thing.

---
 kernel/sched/core.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e15543cb84812..b5973d7fa521c 100644
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
+		/*
+		 * ptrace_{,un}freeze_traced() think it is cool to change
+		 * ->state around behind our backs between TASK_TRACED and
+		 *  __TASK_TRACED.
+		 *
+		 * This is safe because this, as well as any __TASK_TRACED
+		 * wakeups are under siglock.
+		 *
+		 * For any other case, a changed prev_state must be to
+		 * TASK_RUNNING, such that when it blocks, the load has
+		 * happened before the smp_mb().
+		 *
+		 * Also see the comment with deactivate_task().
+		 */
+		SCHED_WARN_ON(tmp_state && (prev_state & __TASK_TRACED &&
+					   !(tmp_state & __TASK_TRACED)));
+
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
