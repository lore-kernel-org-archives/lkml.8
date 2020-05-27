Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06162C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDD972078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbgE0PUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgE0PUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:20:06 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6169BC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 08:20:06 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jdxqe-0006nB-Ed; Wed, 27 May 2020 17:20:04 +0200
Date:   Wed, 27 May 2020 17:20:04 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/3] workqueue: Make the workqueue code PREEMPT_RT safe
Message-ID: <20200527152004.z3n5ccajp6stdcno@linutronix.de>
References: <20200513162732.977489-1-bigeasy@linutronix.de>
 <20200526194641.GF83516@mtj.thefacebook.com>
 <CAHk-=wjHgkama3SYOcYCYt_F-sxV8h4+kQ5aQSMgK7PtiQ=Nkw@mail.gmail.com>
 <CAHk-=wgrG--AdCUBF9jR=zMm=cUn+6VaeOmmbbRFxx1YOx3RiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgrG--AdCUBF9jR=zMm=cUn+6VaeOmmbbRFxx1YOx3RiA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-26 14:46:59 [-0700], Linus Torvalds wrote:
> On Tue, May 26, 2020 at 2:41 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Almost all users of swait have historically been buggy and/or
> > pointless.
> 
> Yeah, looking at this one, it really seems to fundamentally fall in
> the "pointless" category.
> 
> So yeah - instead of extending swait with a new primitive that nobody
> else wants than this pointless case, just don't use swait at all.
> 
> We have better models. We have "rcuwait", and we have
> "wake_up_process()". Either of which is simpler and more efficient
> than swait, and are actually useful. rcuwait isn't exactly widely
> used, but it has very nice semantics for when that is what you want.
> And wake_up_process() is both simple and straightforward, particularly
> when you already have a spinlock for protecting whatever state it is
> you're waking up on or waiting for.

rcuwait would be this:

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 891ccad5f2716..3259f52bfe765 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -301,7 +301,7 @@ static struct workqueue_attrs *wq_update_unbound_numa_attrs_buf;
 static DEFINE_MUTEX(wq_pool_mutex);	/* protects pools and workqueues list */
 static DEFINE_MUTEX(wq_pool_attach_mutex); /* protects worker attach/detach */
 static DEFINE_SPINLOCK(wq_mayday_lock);	/* protects wq->maydays list */
-static DECLARE_WAIT_QUEUE_HEAD(wq_manager_wait); /* wait for manager to go away */
+static struct rcuwait manager_wait;	/* wait for manager to go away */
 
 static LIST_HEAD(workqueues);		/* PR: list of all workqueues */
 static bool workqueue_freezing;		/* PL: have wqs started freezing? */
@@ -2140,7 +2140,7 @@ static bool manage_workers(struct worker *worker)
 
 	pool->manager = NULL;
 	pool->flags &= ~POOL_MANAGER_ACTIVE;
-	wake_up(&wq_manager_wait);
+	rcuwait_wake_up(&manager_wait);
 	return true;
 }
 
@@ -3504,6 +3504,17 @@ static void rcu_free_pool(struct rcu_head *rcu)
 	kfree(pool);
 }
 
+static bool wq_manager_inactive(struct worker_pool *pool)
+{
+	spin_lock_irq(&pool->lock);
+
+	if (pool->flags & POOL_MANAGER_ACTIVE) {
+		spin_unlock_irq(&pool->lock);
+		return false;
+	}
+	return true;
+}
+
 /**
  * put_unbound_pool - put a worker_pool
  * @pool: worker_pool to put
@@ -3540,9 +3551,8 @@ static void put_unbound_pool(struct worker_pool *pool)
 	 * @pool's workers from blocking on attach_mutex.  We're the last
 	 * manager and @pool gets freed with the flag set.
 	 */
-	spin_lock_irq(&pool->lock);
-	wait_event_lock_irq(wq_manager_wait,
-			    !(pool->flags & POOL_MANAGER_ACTIVE), pool->lock);
+	rcuwait_wait_event(&manager_wait, wq_manager_inactive(pool),
+			   TASK_UNINTERRUPTIBLE);
 	pool->flags |= POOL_MANAGER_ACTIVE;
 
 	while ((worker = first_idle_worker(pool)))

There is the unbalanced lock/unlock in wq_manager_inactive() which
sparse complains about. Other than that it looks straight forward.

>                  Linus

Sebastian
