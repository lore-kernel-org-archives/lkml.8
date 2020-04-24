Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5074DC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 233FB206B9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZTU8P6Ke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgDXRkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727091AbgDXRkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:40:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D200CC09B047
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=zzp1PXduTBOR5pus+27/P6alfMcVeBPitOiCMWKgMpE=; b=ZTU8P6KeykB2MOY9WKsLWch94c
        yF9ECKyMaJ0/3QHymAdAIi/vkKaQe5bzlaC7erwfG1esaagSo8gpCzXult0RkELSiH4GaoerZ2Lp3
        2XQt80wTPDWYpkV/4I+MDBK5jSOMbqrrOGDtqxZ0eq2BKLT6Ox8zRod9mrRMBlNYzBcuM8CSEmylv
        rCgFTfJGlopsz2uAqZuurphua+ztTjhEAScsnA5aLRTQiuhy7+XNp1TrwDJwiOrEg9sfeHGyoFrEK
        o47qtm8ZbOkSoqxze1iqLFiF0ehTH5VjkB80PIbL3BY0a9BCEfCnIxxiZlql3XN+Wf6Y9vXG+Fp5S
        lvBLdhYw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jS2JP-0003UG-T7; Fri, 24 Apr 2020 17:40:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4A9B0300B38;
        Fri, 24 Apr 2020 19:40:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2542A20BECBBF; Fri, 24 Apr 2020 19:40:25 +0200 (CEST)
Date:   Fri, 24 Apr 2020 19:40:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, will@kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: lockdep warning about possible circular dependency in PSI
Message-ID: <20200424174025.GA13592@hirez.programming.kicks-ass.net>
References: <CAJuCfpG4NkhpQvZjgXZ_3gm6Hf1QgN_eUOQ8iX9Cv1k9whLwSQ@mail.gmail.com>
 <CAJuCfpGMdegJvLO-o-96PNf6iV5sWcmj=WUovi9ixRbeiHX70w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGMdegJvLO-o-96PNf6iV5sWcmj=WUovi9ixRbeiHX70w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 09:34:42AM -0700, Suren Baghdasaryan wrote:
> Sorry to bother you again folks. Any suggestions on how to silence
> this lockdep warning which I believe to be a false positive?
> 
> On Wed, Apr 15, 2020 at 4:01 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > I received a report about possible circular locking dependency warning
> > generated from PSI polling code. I think we are protected from this
> > scenario by poll_scheduled atomic but wanted to double-check and I’m
> > looking for an advice on how to annotate this case to fix the lockdep
> > warning. I copied the detailed information at the end of this email
> > but the short story is this:
> >
> > "WARNING: possible circular locking dependency detected" is generated
> > with CONFIG_PSI and CONFIG_LOCKDEP enabled. The dependency chain it
> > describes is:
> >
> > #0
> > kthread_delayed_work_timer_fn()
> >  |
> > worker->lock
> >  |
> > try_to_wake_up()
> >  |
> > p->pi_lock
> >
> > #1
> > sched_fork()
> >  |
> > p->pi_lock
> >  |
> > task_fork_fair()
> >  |
> > rq->lock
> >
> > #2
> > psi_memstall_enter
> >  |
> > rq->lock
> >  |
> > kthread_queue_delayed_work()
> >  |
> > worker->lock

Irrespective of it actually being a deadlock or not, it is fairly
fragile. Ideally we'd fix #2, we really should minimize the number of
locks nested under rq->lock.

That said, here's the easy fix, which breaks #0.

---
diff --git a/kernel/kthread.c b/kernel/kthread.c
index bfbfa481be3a..b443bba7dd21 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -806,14 +806,15 @@ static void kthread_insert_work_sanity_check(struct kthread_worker *worker,
 /* insert @work before @pos in @worker */
 static void kthread_insert_work(struct kthread_worker *worker,
 				struct kthread_work *work,
-				struct list_head *pos)
+				struct list_head *pos,
+				struct wake_q_head *wake_q)
 {
 	kthread_insert_work_sanity_check(worker, work);
 
 	list_add_tail(&work->node, pos);
 	work->worker = worker;
 	if (!worker->current_work && likely(worker->task))
-		wake_up_process(worker->task);
+		wake_q_add(wake_q, worker->task);
 }
 
 /**
@@ -831,15 +832,19 @@ static void kthread_insert_work(struct kthread_worker *worker,
 bool kthread_queue_work(struct kthread_worker *worker,
 			struct kthread_work *work)
 {
-	bool ret = false;
+	DEFINE_WAKE_Q(wake_q);
 	unsigned long flags;
+	bool ret = false;
 
 	raw_spin_lock_irqsave(&worker->lock, flags);
 	if (!queuing_blocked(worker, work)) {
-		kthread_insert_work(worker, work, &worker->work_list);
+		kthread_insert_work(worker, work, &worker->work_list, &wake_q);
 		ret = true;
 	}
 	raw_spin_unlock_irqrestore(&worker->lock, flags);
+
+	wake_up_q(&wake_q);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kthread_queue_work);
@@ -857,6 +862,7 @@ void kthread_delayed_work_timer_fn(struct timer_list *t)
 	struct kthread_delayed_work *dwork = from_timer(dwork, t, timer);
 	struct kthread_work *work = &dwork->work;
 	struct kthread_worker *worker = work->worker;
+	DEFINE_WAKE_Q(wake_q);
 	unsigned long flags;
 
 	/*
@@ -873,15 +879,18 @@ void kthread_delayed_work_timer_fn(struct timer_list *t)
 	/* Move the work from worker->delayed_work_list. */
 	WARN_ON_ONCE(list_empty(&work->node));
 	list_del_init(&work->node);
-	kthread_insert_work(worker, work, &worker->work_list);
+	kthread_insert_work(worker, work, &worker->work_list, &wake_q);
 
 	raw_spin_unlock_irqrestore(&worker->lock, flags);
+
+	wake_up_q(&wake_q);
 }
 EXPORT_SYMBOL(kthread_delayed_work_timer_fn);
 
 static void __kthread_queue_delayed_work(struct kthread_worker *worker,
 					 struct kthread_delayed_work *dwork,
-					 unsigned long delay)
+					 unsigned long delay,
+					 struct wake_q_head *wake_q)
 {
 	struct timer_list *timer = &dwork->timer;
 	struct kthread_work *work = &dwork->work;
@@ -895,7 +904,7 @@ static void __kthread_queue_delayed_work(struct kthread_worker *worker,
 	 * on that there's no such delay when @delay is 0.
 	 */
 	if (!delay) {
-		kthread_insert_work(worker, work, &worker->work_list);
+		kthread_insert_work(worker, work, &worker->work_list, wake_q);
 		return;
 	}
 
@@ -928,17 +937,21 @@ bool kthread_queue_delayed_work(struct kthread_worker *worker,
 				unsigned long delay)
 {
 	struct kthread_work *work = &dwork->work;
+	DEFINE_WAKE_Q(wake_q);
 	unsigned long flags;
 	bool ret = false;
 
 	raw_spin_lock_irqsave(&worker->lock, flags);
 
 	if (!queuing_blocked(worker, work)) {
-		__kthread_queue_delayed_work(worker, dwork, delay);
+		__kthread_queue_delayed_work(worker, dwork, delay, &wake_q);
 		ret = true;
 	}
 
 	raw_spin_unlock_irqrestore(&worker->lock, flags);
+
+	wake_up_q(&wake_q);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kthread_queue_delayed_work);
@@ -967,6 +980,7 @@ void kthread_flush_work(struct kthread_work *work)
 		KTHREAD_WORK_INIT(fwork.work, kthread_flush_work_fn),
 		COMPLETION_INITIALIZER_ONSTACK(fwork.done),
 	};
+	DEFINE_WAKE_Q(wake_q);
 	struct kthread_worker *worker;
 	bool noop = false;
 
@@ -979,15 +993,17 @@ void kthread_flush_work(struct kthread_work *work)
 	WARN_ON_ONCE(work->worker != worker);
 
 	if (!list_empty(&work->node))
-		kthread_insert_work(worker, &fwork.work, work->node.next);
+		kthread_insert_work(worker, &fwork.work, work->node.next, &wake_q);
 	else if (worker->current_work == work)
 		kthread_insert_work(worker, &fwork.work,
-				    worker->work_list.next);
+				    worker->work_list.next, &wake_q);
 	else
 		noop = true;
 
 	raw_spin_unlock_irq(&worker->lock);
 
+	wake_up_q(&wake_q);
+
 	if (!noop)
 		wait_for_completion(&fwork.done);
 }
@@ -1065,6 +1081,7 @@ bool kthread_mod_delayed_work(struct kthread_worker *worker,
 			      unsigned long delay)
 {
 	struct kthread_work *work = &dwork->work;
+	DEFINE_WAKE_Q(wake_q);
 	unsigned long flags;
 	int ret = false;
 
@@ -1083,9 +1100,12 @@ bool kthread_mod_delayed_work(struct kthread_worker *worker,
 
 	ret = __kthread_cancel_work(work, true, &flags);
 fast_queue:
-	__kthread_queue_delayed_work(worker, dwork, delay);
+	__kthread_queue_delayed_work(worker, dwork, delay, &wake_q);
 out:
 	raw_spin_unlock_irqrestore(&worker->lock, flags);
+
+	wake_up_q(&wake_q);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kthread_mod_delayed_work);

