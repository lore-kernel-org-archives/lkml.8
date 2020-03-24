Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF3EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCDB420789
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585062745;
	bh=XZ3Y86z3O6BjtKlt2lONWLkUBnw+fq+ymmnvaf69kFk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=uDTyf2v3fv3g8nFWVf56IHI3hPybu8EVwBSCCNlpg9u4y/On03qlUWxvq8e8d72C+
	 f+4IBle9zdsLZl1KjDWE+MNJkY64g9rVUaI3t0dPTb6PA/VDZurzDZCmM4HN0gOLAG
	 oJiOjxzwgxlJmAz7z74uIfQr9Jo8i5g6AtQfAa/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgCXPMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:12:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727480AbgCXPMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:12:24 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95AE220775;
        Tue, 24 Mar 2020 15:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585062743;
        bh=XZ3Y86z3O6BjtKlt2lONWLkUBnw+fq+ymmnvaf69kFk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Lwn33DQoqpNsQ8uAI0rQnq1QzoTMfd7slf1CUGTF30UwG7KwmQDynrPGtuUXgFlc5
         qbQRR9D4TcFjAKnlPau/DlKnHZBVwinkA/3H5whShpzBs+C2Rsuvvi0W9ACwfUXV1I
         geCmRZFUMZGaL1WMN6yt9gpev2+b2mbec/HlHEiQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 31B413522ACE; Tue, 24 Mar 2020 08:12:23 -0700 (PDT)
Date:   Tue, 24 Mar 2020 08:12:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, vpillai <vpillai@digitalocean.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, peterz@infradead.org,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched: Use RCU-sched in core-scheduling balancing logic
Message-ID: <20200324151223.GA19722@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200313232918.62303-1-joel@joelfernandes.org>
 <20200314003004.GI3199@paulmck-ThinkPad-P72>
 <f77b9432-933c-a9fe-5541-437cf0094a65@linux.intel.com>
 <20200323152126.GA141027@google.com>
 <6d933ce2-75e3-6469-4bb0-08ce9df29139@linux.intel.com>
 <20200324133012.GW3199@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324133012.GW3199@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 06:30:12AM -0700, Paul E. McKenney wrote:
> On Tue, Mar 24, 2020 at 11:01:27AM +0800, Li, Aubrey wrote:
> > On 2020/3/23 23:21, Joel Fernandes wrote:
> > > On Mon, Mar 23, 2020 at 02:58:18PM +0800, Li, Aubrey wrote:
> > >> On 2020/3/14 8:30, Paul E. McKenney wrote:
> > >>> On Fri, Mar 13, 2020 at 07:29:18PM -0400, Joel Fernandes (Google) wrote:
> > >>>> rcu_read_unlock() can incur an infrequent deadlock in
> > >>>> sched_core_balance(). Fix this by using the RCU-sched flavor instead.
> > >>>>
> > >>>> This fixes the following spinlock recursion observed when testing the
> > >>>> core scheduling patches on PREEMPT=y kernel on ChromeOS:
> > >>>>
> > >>>> [   14.998590] watchdog: BUG: soft lockup - CPU#0 stuck for 11s! [kworker/0:10:965]
> > >>>>
> > >>>
> > >>> The original could indeed deadlock, and this would avoid that deadlock.
> > >>> (The commit to solve this deadlock is sadly not yet in mainline.)
> > >>>
> > >>> Acked-by: Paul E. McKenney <paulmck@kernel.org>
> > >>
> > >> I saw this in dmesg with this patch, is it expected?
> > >>
> > >> [  117.000905] =============================
> > >> [  117.000907] WARNING: suspicious RCU usage
> > >> [  117.000911] 5.5.7+ #160 Not tainted
> > >> [  117.000913] -----------------------------
> > >> [  117.000916] kernel/sched/core.c:4747 suspicious rcu_dereference_check() usage!
> > >> [  117.000918] 
> > >>                other info that might help us debug this:
> > > 
> > > Sigh, this is because for_each_domain() expects rcu_read_lock(). From an RCU
> > > PoV, the code is correct (warning doesn't cause any issue).
> > > 
> > > To silence warning, we could replace the rcu_read_lock_sched() in my patch with:
> > > preempt_disable();
> > > rcu_read_lock();
> > > 
> > > and replace the unlock with:
> > > 
> > > rcu_read_unlock();
> > > preempt_enable();
> > > 
> > > That should both take care of both the warning and the scheduler-related
> > > deadlock. Thoughts?
> > > 
> > 
> > How about this?
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index a01df3e..7ff694e 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4743,7 +4743,6 @@ static void sched_core_balance(struct rq *rq)
> >  	int cpu = cpu_of(rq);
> >  
> >  	rcu_read_lock();
> > -	raw_spin_unlock_irq(rq_lockp(rq));
> >  	for_each_domain(cpu, sd) {
> >  		if (!(sd->flags & SD_LOAD_BALANCE))
> >  			break;
> > @@ -4754,7 +4753,6 @@ static void sched_core_balance(struct rq *rq)
> >  		if (steal_cookie_task(cpu, sd))
> >  			break;
> >  	}
> > -	raw_spin_lock_irq(rq_lockp(rq));
> >  	rcu_read_unlock();
> >  }
> 
> As an alternative, I am backporting the -rcu commit 2b5e19e20fc2 ("rcu:
> Make rcu_read_unlock_special() safe for rq/pi locks") to v5.6-rc6 and
> testing it.  The other support for this is already in mainline.  I just
> now started testing it, and will let you know how it goes.
> 
> If that works for you, and if the bug you are looking to fix is also
> in v5.5 or earlier, please let me know so that we can work out how to
> deal with the older releases.

And the backported patch below passes moderate rcutorture testing.
But the big question...  Does it work for you?

							Thanx, Paul

------------------------------------------------------------------------

commit 0ed0648e23f6aca2a6543fee011d74ab674e08e8
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Mar 24 06:20:14 2020 -0700

    rcu: Make rcu_read_unlock_special() safe for rq/pi locks
    
    The scheduler is currently required to hold rq/pi locks across the entire
    RCU read-side critical section or not at all.  This is inconvenient and
    leaves traps for the unwary, including the author of this commit.
    
    But now that excessively ong grace periods enable scheduling-clock
    interrupts for holdout nohz_full CPUs, the nohz_full rescue logic in
    rcu_read_unlock_special() can be dispensed with.  In other words, the
    rcu_read_unlock_special() function can refrain from doing wakeups unless
    such wakeups are guaranteed safe.
    
    This commit therefore avoids unsafe wakeups, freeing the scheduler to
    hold rq/pi locks across rcu_read_unlock() even if the corresponding RCU
    read-side critical section might have been preempted.
    
    This commit is inspired by a patch from Lai Jiangshan:
    https://lore.kernel.org/lkml/20191102124559.1135-2-laijs@linux.alibaba.com
    This commit is further intended to be a step towards his goal of permitting
    the inlining of RCU-preempt's rcu_read_lock() and rcu_read_unlock().
    
    Cc: Lai Jiangshan <laijs@linux.alibaba.com>
    [ paulmck: Backported to v5.6-rc6. ]
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c6ea81cd4189..2e1bfa0cc393 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -614,18 +614,16 @@ static void rcu_read_unlock_special(struct task_struct *t)
 		struct rcu_node *rnp = rdp->mynode;
 
 		exp = (t->rcu_blocked_node && t->rcu_blocked_node->exp_tasks) ||
-		      (rdp->grpmask & READ_ONCE(rnp->expmask)) ||
-		      tick_nohz_full_cpu(rdp->cpu);
+		      (rdp->grpmask & READ_ONCE(rnp->expmask));
 		// Need to defer quiescent state until everything is enabled.
-		if (irqs_were_disabled && use_softirq &&
-		    (in_interrupt() ||
-		     (exp && !t->rcu_read_unlock_special.b.deferred_qs))) {
-			// Using softirq, safe to awaken, and we get
-			// no help from enabling irqs, unlike bh/preempt.
+		if (use_softirq && (in_irq() || (exp && !irqs_were_disabled))) {
+			// Using softirq, safe to awaken, and either the
+			// wakeup is free or there is an expedited GP.
 			raise_softirq_irqoff(RCU_SOFTIRQ);
 		} else {
 			// Enabling BH or preempt does reschedule, so...
-			// Also if no expediting or NO_HZ_FULL, slow is OK.
+			// Also if no expediting, slow is OK.
+			// Plus nohz_full CPUs eventually get tick enabled.
 			set_tsk_need_resched(current);
 			set_preempt_need_resched();
 			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
