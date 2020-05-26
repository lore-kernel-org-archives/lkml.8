Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53071C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B80520776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590510589;
	bh=iIFUslWtwI40OMXT1aeqlbfaOzNfGCbK/LRCf941q+I=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=yksdR4R6M33VROZ8gjbFlOi+MitW+UNgZ2TahariU9wa12K2K93bmGZQ5U+j9whTj
	 D/bfAvXhQUR4/EXyhLcYHNvzk3z6IQ08eo3PMXHhZeVHZhL7IsXNtPocOFf+Tni5Ep
	 rdaFJwZRo+xl2adheL9qn+2EFz/whFzsmTAu+OPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388568AbgEZQ3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 12:29:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388061AbgEZQ3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:29:47 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 409762073B;
        Tue, 26 May 2020 16:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590510586;
        bh=iIFUslWtwI40OMXT1aeqlbfaOzNfGCbK/LRCf941q+I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=o/NHRjqfspPUgK8Wx5pjLVmBUYeJiL/5do0/QfWWFsEiCjGwVMMxINUKWqcbbA2om
         mQwBIPLZVJ2JKxnl39Ob/dmrkGgrHQei/ACZW2oucn40QEK/vVK0zGEZfr3+NCNX2q
         u0SiUZps9CCqdvHezZZn4xlsfaeMYw2IW8H45TM8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 117413522A8B; Tue, 26 May 2020 09:29:46 -0700 (PDT)
Date:   Tue, 26 May 2020 09:29:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 01/10] rcu: Directly lock rdp->nocb_lock on nocb code
 entrypoints
Message-ID: <20200526162946.GK2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-2-frederic@kernel.org>
 <20200520122949.GB16672@google.com>
 <20200522175739.GM2869@paulmck-ThinkPad-P72>
 <20200526152137.GB76276@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526152137.GB76276@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 11:21:37AM -0400, Joel Fernandes wrote:
> Hi Paul,
> 
> On Fri, May 22, 2020 at 10:57:39AM -0700, Paul E. McKenney wrote:
> > On Wed, May 20, 2020 at 08:29:49AM -0400, Joel Fernandes wrote:
> > > On Wed, May 13, 2020 at 06:47:05PM +0200, Frederic Weisbecker wrote:
> > > > Pure NOCB code entrypoints (nocb_cb kthread, nocb_gp kthread, nocb
> > > > timers) can unconditionally lock rdp->nocb_lock as they always execute
> > > > in the context of an offloaded rdp.
> > > > 
> > > > This also prepare for toggling CPUs to/from callback's offloaded mode
> > > > where the offloaded state will possibly change when rdp->nocb_lock
> > > > isn't taken. We'll still want the entrypoints to lock the rdp in any
> > > > case.
> > > 
> > > Suggested rewrite for change log:
> > > <wordsmithing>
> > > Make pure NOCB code entrypoints (nocb_cb kthread, nocb_gp kthread, nocb
> > > timers) unconditionally lock rdp->nocb_lock as they always execute in the
> > > context of an offloaded rdp.
> > > 
> > > This prepares for future toggling of CPUs to/from callback's offloaded mode
> > > where the offloaded state can change when rdp->nocb_lock is not held. We'll
> > > still want the entrypoints to lock the rdp in any case.
> > > </wordsmithing>
> > > 
> > > Also, can we inline rcu_nocb_lock_irqsave() into
> > > do_nocb_deferred_wakeup_common() since that's the only user, and then delete
> > > rcu_nocb_lock_irqsave() and the corresponding unlock? That would also remove
> > > confusion about which API to use for nocb locking (i.e. whether to directly
> > > acquire lock or call rcu_nocb_lock_irqsave()).
> > > 
> > > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > Thank you for looking this over, Joel!
> > 
> > Is it feasible to make rcu_nocb_lock*() and rcu_nocb_unlock*() "do the
> > right thing", even when things are changing?
> 
> One way to prevent things from changing could be to employ Steven's
> poor-man's RCU to mediate the "changing state" itself assuming the switch
> from the fast-path to the slow-path does not happen often. :) So whichever
> path is changing the state needs to wait for that poor-man's GP.

That should not be needed, given that acquiring ->nocb_lock on the CPU
corresponding to that lock suffices in both cases.  The trick is making
sure that the release matches the acquire.

> Any case, are you concerned with the performance issues with the
> unconditional locking and that's why you suggest still keeping it conditional?

My concerns are more about maintainability.

> Also, coming back to my point of inline the helper into the last caller -
> do_nocb_deferred_wakeup_common(). I think since we don't need to check if the
> rdp is offloaded and do any conditional locking. The timer can be called only
> with offloaded rdp. So we can directly do the unconditional spinlock instead
> of using the rcu_nocb_lock helper there.

Indeed we can.  But should we?

> > would prevent any number of "interesting" copy-pasta and "just now became
> > common code" bugs down the road.  And because irqs are disabled while
> > holding the lock, it should be possible to keep state on a per-CPU basis.
> 
> Agreed, that would be nice. Though if we could keep simple, that'd be nice
> too.

Having one set of functions/macros that are always used to protect
the ->cblist, no matter what the context, is a very attractive form of
simple.  ;-)

> > The ugliest scenario is callback adoption, where there are two ->cblist
> > structures in need of being locked.  In that case, changes are excluded
> > (because that is in CPU hotplug code), but is it possible to take
> > advantage of that reasonably?
> 
> Could you describe this a bit more? Thanks.

Right now, callbacks are merged directly from the outgoing CPU's ->cblist
to the surviving CPU's ->cblist.  This means that both ->cblist structures
must be locked at the same time, which would require additional state.
After all, if only the one ->cblist were to be locked at a given time,
a per-CPU variable could be used to track what method should be used to
unlock the ->cblist.

This could be restructured to use an intermediate private ->cblist,
but care would be required with the counts, as it is a very bad idea
for a large group of callbacks to become invisible.  (This is not a
problem for rcu_barrier(), which excludes CPU hotplug, but it could
be a serious problem for callback-flood-mitigation mechanisms.  Yes,
they are heuristic, but...)

> > Maybe these changes are the best we can do, but it would be good to
> > if the same primitive locked a ->cblist regardless of context.
> 
> Here you are comparing 2 primitives. Do you mean that just IRQs being
> disabled is another primitive, and rcu_nocb_lock is another one?

I am not sure what this question means, but I am advocating looking
into retaining a single wrapper that decides instead of direct use of
the underlying primitives.

Or are you instead asking why there are two different methods of
protecting the ->cblist structures?  (If so, because call_rcu() happens
often enough that we don't want lock-acquisition overhead unless we
absolutely need it, which we do on nohz_full CPUs but not otherwise.)

> BTW, I'm really itching to give it a try to make the scheduler more deadlock
> resilient (that is, if the scheduler wake up path detects a deadlock, then it
> defers the wake up using timers, or irq_work on its own instead of passing
> the burden of doing so to the callers). Thoughts?

I have used similar approaches within RCU, but on the other hand the
scheduler often has tighter latency constraints than RCU does.	So I
think that is a better question for the scheduler maintainers than it
is for me.  ;-)

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> > Can that be made to work reasonably?
> > 
> > 							Thanx, Paul
> > 
> > > thanks,
> > > 
> > >  - Joel
> > > 
> > > 
> > > > 
> > > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > > ---
> > > >  kernel/rcu/tree_plugin.h | 14 +++++++-------
> > > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > > index 097635c41135..523570469864 100644
> > > > --- a/kernel/rcu/tree_plugin.h
> > > > +++ b/kernel/rcu/tree_plugin.h
> > > > @@ -1909,7 +1909,7 @@ static void do_nocb_bypass_wakeup_timer(struct timer_list *t)
> > > >  	struct rcu_data *rdp = from_timer(rdp, t, nocb_bypass_timer);
> > > >  
> > > >  	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Timer"));
> > > > -	rcu_nocb_lock_irqsave(rdp, flags);
> > > > +	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
> > > >  	smp_mb__after_spinlock(); /* Timer expire before wakeup. */
> > > >  	__call_rcu_nocb_wake(rdp, true, flags);
> > > >  }
> > > > @@ -1942,7 +1942,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
> > > >  	 */
> > > >  	for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_cb_rdp) {
> > > >  		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
> > > > -		rcu_nocb_lock_irqsave(rdp, flags);
> > > > +		raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
> > > >  		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> > > >  		if (bypass_ncbs &&
> > > >  		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
> > > > @@ -1951,7 +1951,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
> > > >  			(void)rcu_nocb_try_flush_bypass(rdp, j);
> > > >  			bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> > > >  		} else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
> > > > -			rcu_nocb_unlock_irqrestore(rdp, flags);
> > > > +			raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
> > > >  			continue; /* No callbacks here, try next. */
> > > >  		}
> > > >  		if (bypass_ncbs) {
> > > > @@ -1996,7 +1996,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
> > > >  		} else {
> > > >  			needwake = false;
> > > >  		}
> > > > -		rcu_nocb_unlock_irqrestore(rdp, flags);
> > > > +		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
> > > >  		if (needwake) {
> > > >  			swake_up_one(&rdp->nocb_cb_wq);
> > > >  			gotcbs = true;
> > > > @@ -2084,7 +2084,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
> > > >  	rcu_do_batch(rdp);
> > > >  	local_bh_enable();
> > > >  	lockdep_assert_irqs_enabled();
> > > > -	rcu_nocb_lock_irqsave(rdp, flags);
> > > > +	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
> > > >  	if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
> > > >  	    rcu_seq_done(&rnp->gp_seq, cur_gp_seq) &&
> > > >  	    raw_spin_trylock_rcu_node(rnp)) { /* irqs already disabled. */
> > > > @@ -2092,7 +2092,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
> > > >  		raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
> > > >  	}
> > > >  	if (rcu_segcblist_ready_cbs(&rdp->cblist)) {
> > > > -		rcu_nocb_unlock_irqrestore(rdp, flags);
> > > > +		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
> > > >  		if (needwake_gp)
> > > >  			rcu_gp_kthread_wake();
> > > >  		return;
> > > > @@ -2100,7 +2100,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
> > > >  
> > > >  	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("CBSleep"));
> > > >  	WRITE_ONCE(rdp->nocb_cb_sleep, true);
> > > > -	rcu_nocb_unlock_irqrestore(rdp, flags);
> > > > +	raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
> > > >  	if (needwake_gp)
> > > >  		rcu_gp_kthread_wake();
> > > >  	swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
> > > > -- 
> > > > 2.25.0
> > > > 
