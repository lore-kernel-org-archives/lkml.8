Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B02C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B430420B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PgWjM+3f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgGTOVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgGTOVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:21:18 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AD3C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 07:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XhKiPHw8NMvO7D68bNb7M0LivUfDDlMFnTxSdNpiGKA=; b=PgWjM+3fjAMff/9vy9gToJwMTJ
        lmKeKQmrvMl08Va47cNbBg32SRBjsUZZqg3KOQoHsoQg+Rj7yk1ZUWnVLbBFyx43vPrH1sulWj4+e
        gcLCaPKLDF7dazrcnGaF4ChyfwOLTdZ7YkRTotqCCuDdB0BfkUClozQVBBoa0ikpDv2rzzay5H/n/
        Iw7lwanBlbl3xMQQvjX6z4ZGRxjxaSK2g5NI4GDb73cr0rvfp8fIlYGbgBZ0AcPhuYvajBy4vb3M3
        y85gHXKFiOv3izj2rNzK7J8S0ouHaAxPQx6euB7vwcOaxMsQWZsCod4tQkKaJtjAF/RULJOOPmZB0
        sCqLM0kA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxWfF-0002VE-Sh; Mon, 20 Jul 2020 14:21:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1A4933056DE;
        Mon, 20 Jul 2020 16:21:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F135D2120BDC0; Mon, 20 Jul 2020 16:21:05 +0200 (CEST)
Date:   Mon, 20 Jul 2020 16:21:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        christian@brauner.io, "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Dave Jones <davej@codemonkey.org.uk>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: 5.8-rc*: kernel BUG at kernel/signal.c:1917
Message-ID: <20200720142105.GR10769@hirez.programming.kicks-ass.net>
References: <20200717124017.GB6067@redhat.com>
 <2c8ef23c-43b4-39d4-8e84-92769c948da9@kernel.org>
 <20200718171406.GB16791@redhat.com>
 <20200718174448.4btbjcvp6wbbdgts@wittgenstein>
 <badcb9d5-f628-2be1-7a72-902cf08010bd@kernel.org>
 <20200720064326.GA6612@redhat.com>
 <20200720082657.GC6612@redhat.com>
 <20200720084106.GJ10769@hirez.programming.kicks-ass.net>
 <20200720105924.GE43129@hirez.programming.kicks-ass.net>
 <20200720140224.GD6612@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720140224.GD6612@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 04:02:24PM +0200, Oleg Nesterov wrote:
> I have to admit, I do not understand the usage of prev_state in schedule(),
> it looks really, really subtle...

Right, so commit dbfb089d360 solved a problem where schedule() re-read
prev->state vs prev->on_rq = 0. That is, schedule()'s dequeue and
ttwu()'s enqueue disagreed over sched_contributes_to_load. and as a
result load-accounting went wobbly.

Now, looking at that commit again, I might've solved the problem twice
:-P

So on the one hand, I provider ordering:

	LOAD p->state		LOAD-ACQUIRE p->on_rq == 0
	MB
	STORE p->on_rq, 0	STORE p->state, TASK_WAKING

such that ttwu() will only change p->state, after on_rq==0, which is
after loading p->state in schedule().

At the same time, I also had schedule() set
p->sched_contributes_to_load once, and then consistently used that value
throughout, without ever looking at p->state again, which too makes it
much harder to mess load-avg up.


Now, the ordering in schedule(), relies on doing the p->state load
before:

	spin_lock(rq->lock)
	smp_mb__after_spinlock();

and doing a re-load check after, with the assumption that if the reload
is different, it will not block.

That said, in a crossed email, I just proposed we could simplify all
this like so.. but now I need to go ask people to re-validate that
loadavg muck again :-/


diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a2a244af9a53..437fc3b241f2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4193,9 +4193,6 @@ static void __sched notrace __schedule(bool preempt)
 	local_irq_disable();
 	rcu_note_context_switch(preempt);
 
-	/* See deactivate_task() below. */
-	prev_state = prev->state;
-
 	/*
 	 * Make sure that signal_pending_state()->signal_pending() below
 	 * can't be reordered with __set_current_state(TASK_INTERRUPTIBLE)
@@ -4223,7 +4220,8 @@ static void __sched notrace __schedule(bool preempt)
 	 * We must re-load prev->state in case ttwu_remote() changed it
 	 * before we acquired rq->lock.
 	 */
-	if (!preempt && prev_state && prev_state == prev->state) {
+	prev_state = prev->state;
+	if (!preempt && prev_state) {
 		if (signal_pending_state(prev_state, prev)) {
 			prev->state = TASK_RUNNING;
 		} else {
@@ -4237,10 +4235,12 @@ static void __sched notrace __schedule(bool preempt)
 
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
