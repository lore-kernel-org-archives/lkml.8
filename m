Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38113C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 01:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055F920870
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 01:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583458830;
	bh=vAaXrFvvBzKC59uTVSh9ANdsT23g+5eypfwNYZ3kHAo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=rrKOVKhFAMF7gVnFbKOj/GvhCeievTrIjzGJq/4c9bSXK6PNMgCWbyivQlgwYjNpL
	 LUu7ItweYGRZxVgO+fXVZoVXkJ4Onind9lvSAkWgOmgq0eq8fd1Tg/VWuyWLudDVn6
	 jDlyW8oU/68nU9GglZ8jWYoa/F4xdwMyVkvfHpCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgCFBk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 20:40:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:39214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgCFBk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 20:40:28 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6208F2073B;
        Fri,  6 Mar 2020 01:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583458827;
        bh=vAaXrFvvBzKC59uTVSh9ANdsT23g+5eypfwNYZ3kHAo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=yhCBsvj0ROX4kmrkD2N2GOh7aZBfUK7c8brZu0wycjM3bsMV9JOwaq0yWEZEB7dXT
         G8Yjr2SAcIF/f2taE0xhWc3DZGdATLHEL2lKn8nFTkrqFeFFDrnFaPqetXpVhlCrq+
         zWQqBt9NwKgJsef9+lYfKQW//d56ml3Y2f84G44U=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 38F203522806; Thu,  5 Mar 2020 17:40:27 -0800 (PST)
Date:   Thu, 5 Mar 2020 17:40:27 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: Pinning down a blocked task to extract diagnostics
Message-ID: <20200306014027.GA11942@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200305005049.GA21120@paulmck-ThinkPad-P72>
 <20200305080755.GS2596@hirez.programming.kicks-ass.net>
 <20200305081337.GA2619@hirez.programming.kicks-ass.net>
 <20200305142245.GB2935@paulmck-ThinkPad-P72>
 <20200305092845.4296c35e@gandalf.local.home>
 <20200305153638.GC2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305153638.GC2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 07:36:38AM -0800, Paul E. McKenney wrote:
> On Thu, Mar 05, 2020 at 09:28:45AM -0500, Steven Rostedt wrote:
> > On Thu, 5 Mar 2020 06:22:45 -0800
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > > On Thu, Mar 05, 2020 at 09:13:37AM +0100, Peter Zijlstra wrote:

[ . . . ]

> > > How about if I add something like this, located right by try_to_wake_up()?
> > > 
> > > 	bool try_to_keep_sleeping(struct task_struct *t)
> > > 	{
> > > 		raw_spin_lock_irq(&t->pi_lock);
> > > 		switch (t->state) {
> > > 		case TASK_RUNNING:
> > > 		case TASK_WAKING:
> > > 			raw_spin_unlock_irq(&t->pi_lock);
> > > 			return false;
> > > 
> > > 		default:
> > > 			if (t->on_rq) {
> > 
> > Somehow I think there still needs to be a read barrier before the test to
> > on_rq.
> 
> This is nowhere near a fastpath, so if there is uncertainty it gets
> the smp_rmb().  Or an smp_load_acquire() on t->state.
> 
> > > 				raw_spin_unlock_irq(&t->pi_lock);
> > > 				return false;
> > > 			}
> > > 
> > > 			/* OK to extract consistent diagnostic information. */
> > > 			return true;
> > > 		}
> > > 		/* NOTREACHED */
> > > 	}
> > > 
> > > Then a use might look like this:
> > > 
> > > 	if (try_to_keep_sleeping(t))
> > > 		/* Extract consistent diagnostic information. */
> > > 		raw_spin_unlock_irq(&t->pi_lock);
> > 
> > Perhaps we should have a allow_awake(t) to match it?
> > 
> > 		allow_awake(t);
> > 
> > Where we have:
> > 
> > static inline allow_awake(struct task_struct *t)
> > {
> > 	raw_spin_unlock_irq(&t->pi_lock);
> > }
> 
> Makes sense to me!

So how about like this?

							Thanx, Paul

------------------------------------------------------------------------

commit e2821ae6c6a6adaabc89ccd9babf4375a78e0626
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Mar 5 16:53:58 2020 -0800

    sched/core: Add functions to prevent sleepers from awakening
    
    In some cases, it is necessary to examine a consistent version of a
    sleeping process's state, in other words, it is necessary to keep
    that process in sleeping state.  This commit therefore provides a
    try_to_keep_sleeping() function that acquires ->pi_lock to prevent
    wakeups from proceeding, returning true if the function is still asleep,
    and otherwise releasing ->pi_lock and returning false.
    
    This commit also provides an allow_awake() function (as suggested by
    by Steven Rostedt) that reverses the effect of a successful call to
    try_to_keep_sleeping(), allowing the process to once again be awakened.
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    [ paulmck: Apply feedback from Peter Zijlstra and Steven Rostedt. ]
    Cc: Ingo Molnar <mingo@redhat.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Juri Lelli <juri.lelli@redhat.com>
    Cc: Vincent Guittot <vincent.guittot@linaro.org>
    Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
    Cc: Steven Rostedt <rostedt@goodmis.org>
    Cc: Ben Segall <bsegall@google.com>
    Cc: Mel Gorman <mgorman@suse.de>

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 3283c8d..aefea4a 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -1148,4 +1148,7 @@ int autoremove_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, i
 		(wait)->flags = 0;						\
 	} while (0)
 
+bool try_to_keep_sleeping(struct task_struct *p);
+void allow_awake(struct task_struct *p);
+
 #endif /* _LINUX_WAIT_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fc1dfc0..b665ff7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2654,6 +2654,48 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 }
 
 /**
+ * try_to_keep_sleeping - Attempt to force task to remain off runqueues
+ * @p: The process to remain asleep.
+ *
+ * Acquires the process's ->pi_lock and checks state.  If the process
+ * is still blocked, returns @true and leave ->pi_lock held, otherwise
+ * releases ->pi_locked and returns @false.
+ */
+bool try_to_keep_sleeping(struct task_struct *p)
+{
+	lockdep_assert_irqs_enabled();
+	raw_spin_lock_irq(&p->pi_lock);
+	switch (p->state) {
+	case TASK_RUNNING:
+	case TASK_WAKING:
+		raw_spin_unlock_irq(&p->pi_lock);
+		return false;
+
+	default:
+		smp_rmb(); /* See comments in try_to_wake_up(). */
+		if (p->on_rq) {
+			raw_spin_unlock_irq(&p->pi_lock);
+			return false;
+		}
+		return true;  /* Process is now stuck in blocked state. */
+	}
+	/* NOTREACHED */
+}
+
+/**
+ * allow_awake - Allow a kept-sleeping process to awaken
+ * @p: Process to be allowed to awaken.
+ *
+ * Given that @p was passed to an earlier call to try_to_keep_sleeping
+ * that returned @true, hence preventing @p from waking up, allow @p
+ * to once again be awakened.
+ */
+void allow_awake(struct task_struct *p)
+{
+	raw_spin_unlock_irq(&p->pi_lock);
+}
+
+/**
  * wake_up_process - Wake up a specific process
  * @p: The process to be woken up.
  *
