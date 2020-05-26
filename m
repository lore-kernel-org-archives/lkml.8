Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20C4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9B832088E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="vfyZkK/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391061AbgEZUSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 16:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389684AbgEZUSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 16:18:44 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EEDC03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 13:18:43 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id v4so17338018qte.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 13:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3ofTOchQCIWu4TALYz0jRG1x08XgIzbTAkfrEIscHEA=;
        b=vfyZkK/QFQhNze7sEOo/5ebC4rSIQbIvbiGDqsRhgVrtJat1huuX7CV9skOnCyV8bY
         QXhsYaGrfoxXbJF7xcqIq8Zwm7sNbMoP5febZTSvfztkfUHxOectvvvdonLhWs8fNBnJ
         Y2HpB98nMjAFkMHbxLp+WGnEkDmnHoS/i9yzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3ofTOchQCIWu4TALYz0jRG1x08XgIzbTAkfrEIscHEA=;
        b=awga1aC28qaUGV8x71Tq39TpqmhCo/FwC645wsTfASOFTTeS34AYZGtgp8SUG2f31C
         7fP/xFxNMdICyr7z+pSRLNJBB4Z5AqekODQf5iZrtwNlY8YM2Jr7mkHdxO/8Jw0Kw+Wk
         xJZOa5/Ensds0OnWSwZSZIJjsc3mchnqDqcFeONqcxVwuIluOFG9GxFBTHLk72bNPm4f
         sqggCNE2QTh0yWikTNs/FwjKEtLSkzjMgwlTYRlbvW5XptUrQckucgwvIxEq75+ii8q+
         hidfGG6kyuHUE1CUagAzxIraCG/VwcjlwFdXQrkYCGJ2u3ZrdcFMv1mh1zHiROGNlrPI
         qDTg==
X-Gm-Message-State: AOAM532VsCuJePSiEYS5XW5IP1A8hFJ54q6vHKIKEBxEA/GafRrLzwBq
        n917IKkbpYfX0qxwQ7f+zgoRMw==
X-Google-Smtp-Source: ABdhPJxHQXebvycZG0KwPJWaYC2SzAfr693uSXvVc4JZlC7sjvfQGtc5tecGxXr8TavPERjhIuSAfA==
X-Received: by 2002:aed:3009:: with SMTP id 9mr611878qte.191.1590524322596;
        Tue, 26 May 2020 13:18:42 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id e16sm672272qtc.71.2020.05.26.13.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 13:18:42 -0700 (PDT)
Date:   Tue, 26 May 2020 16:18:40 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 01/10] rcu: Directly lock rdp->nocb_lock on nocb code
 entrypoints
Message-ID: <20200526201840.GC76276@google.com>
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-2-frederic@kernel.org>
 <20200520122949.GB16672@google.com>
 <20200522175739.GM2869@paulmck-ThinkPad-P72>
 <20200526152137.GB76276@google.com>
 <20200526162946.GK2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526162946.GK2869@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 09:29:46AM -0700, Paul E. McKenney wrote:
> On Tue, May 26, 2020 at 11:21:37AM -0400, Joel Fernandes wrote:
> > Hi Paul,
> > 
> > On Fri, May 22, 2020 at 10:57:39AM -0700, Paul E. McKenney wrote:
> > > On Wed, May 20, 2020 at 08:29:49AM -0400, Joel Fernandes wrote:
> > > > On Wed, May 13, 2020 at 06:47:05PM +0200, Frederic Weisbecker wrote:
> > > > > Pure NOCB code entrypoints (nocb_cb kthread, nocb_gp kthread, nocb
> > > > > timers) can unconditionally lock rdp->nocb_lock as they always execute
> > > > > in the context of an offloaded rdp.
> > > > > 
> > > > > This also prepare for toggling CPUs to/from callback's offloaded mode
> > > > > where the offloaded state will possibly change when rdp->nocb_lock
> > > > > isn't taken. We'll still want the entrypoints to lock the rdp in any
> > > > > case.
> > > > 
> > > > Suggested rewrite for change log:
> > > > <wordsmithing>
> > > > Make pure NOCB code entrypoints (nocb_cb kthread, nocb_gp kthread, nocb
> > > > timers) unconditionally lock rdp->nocb_lock as they always execute in the
> > > > context of an offloaded rdp.
> > > > 
> > > > This prepares for future toggling of CPUs to/from callback's offloaded mode
> > > > where the offloaded state can change when rdp->nocb_lock is not held. We'll
> > > > still want the entrypoints to lock the rdp in any case.
> > > > </wordsmithing>
> > > > 
> > > > Also, can we inline rcu_nocb_lock_irqsave() into
> > > > do_nocb_deferred_wakeup_common() since that's the only user, and then delete
> > > > rcu_nocb_lock_irqsave() and the corresponding unlock? That would also remove
> > > > confusion about which API to use for nocb locking (i.e. whether to directly
> > > > acquire lock or call rcu_nocb_lock_irqsave()).
> > > > 
> > > > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > 
> > > Thank you for looking this over, Joel!
> > > 
> > > Is it feasible to make rcu_nocb_lock*() and rcu_nocb_unlock*() "do the
> > > right thing", even when things are changing?
> > 
> > One way to prevent things from changing could be to employ Steven's
> > poor-man's RCU to mediate the "changing state" itself assuming the switch
> > from the fast-path to the slow-path does not happen often. :) So whichever
> > path is changing the state needs to wait for that poor-man's GP.
> 
> That should not be needed, given that acquiring ->nocb_lock on the CPU
> corresponding to that lock suffices in both cases.  The trick is making
> sure that the release matches the acquire.

Revisiting what you meant by "when things are changing", I'm assuming you
meant a CPU is dynamically switched from non-offloaded mode to
offloaded-mode. Please correct me if I'm wrong.

Assuming that's true, you asked how do we "do the right thing" in the
lock/unlock APIs. I was also suggesting getting rid of them and directly
acquiring/releasing the spinlock, like Frederic does. It sounds like
that is not good enough and you want an API that can do conditional locking
(and the said complexity is hidden behind the API). Allow me to read more
code and see if I can understand that / how to do that.

> > Any case, are you concerned with the performance issues with the
> > unconditional locking and that's why you suggest still keeping it conditional?
> 
> My concerns are more about maintainability.

Ok.

> > Also, coming back to my point of inline the helper into the last caller -
> > do_nocb_deferred_wakeup_common(). I think since we don't need to check if the
> > rdp is offloaded and do any conditional locking. The timer can be called only
> > with offloaded rdp. So we can directly do the unconditional spinlock instead
> > of using the rcu_nocb_lock helper there.
> 
> Indeed we can.  But should we?

Yeah may be not, in the event that we could do conditional locking and
benefit.

> > > would prevent any number of "interesting" copy-pasta and "just now became
> > > common code" bugs down the road.  And because irqs are disabled while
> > > holding the lock, it should be possible to keep state on a per-CPU basis.
> > 
> > Agreed, that would be nice. Though if we could keep simple, that'd be nice
> > too.
> 
> Having one set of functions/macros that are always used to protect
> the ->cblist, no matter what the context, is a very attractive form of
> simple.  ;-)

I was thinking that API is already raw_spin_lock/unlock() but I'll revisit
everything.

> > > The ugliest scenario is callback adoption, where there are two ->cblist
> > > structures in need of being locked.  In that case, changes are excluded
> > > (because that is in CPU hotplug code), but is it possible to take
> > > advantage of that reasonably?
> > 
> > Could you describe this a bit more? Thanks.
> 
> Right now, callbacks are merged directly from the outgoing CPU's ->cblist
> to the surviving CPU's ->cblist.  This means that both ->cblist structures
> must be locked at the same time, which would require additional state.
> After all, if only the one ->cblist were to be locked at a given time,
> a per-CPU variable could be used to track what method should be used to
> unlock the ->cblist.

So you do mean conditional locking behind an API, and everyone call the API
whether they want do the conditional locking or not. Ok.

> This could be restructured to use an intermediate private ->cblist,
> but care would be required with the counts, as it is a very bad idea
> for a large group of callbacks to become invisible.  (This is not a
> problem for rcu_barrier(), which excludes CPU hotplug, but it could
> be a serious problem for callback-flood-mitigation mechanisms.  Yes,
> they are heuristic, but...)

Ok.

> > > Maybe these changes are the best we can do, but it would be good to
> > > if the same primitive locked a ->cblist regardless of context.
> > 
> > Here you are comparing 2 primitives. Do you mean that just IRQs being
> > disabled is another primitive, and rcu_nocb_lock is another one?
> 
> I am not sure what this question means, but I am advocating looking
> into retaining a single wrapper that decides instead of direct use of
> the underlying primitives.

Yep.

> Or are you instead asking why there are two different methods of
> protecting the ->cblist structures?  (If so, because call_rcu() happens
> often enough that we don't want lock-acquisition overhead unless we
> absolutely need it, which we do on nohz_full CPUs but not otherwise.)

Yeah that's what I was asking. About lock-acquisition overhead, I think its
still uncontended overhead though because even if the nocb lock is taken when
it was not needed, it is still to lock the local ->cblist. Correct me if I'm
wrong though!

> > BTW, I'm really itching to give it a try to make the scheduler more deadlock
> > resilient (that is, if the scheduler wake up path detects a deadlock, then it
> > defers the wake up using timers, or irq_work on its own instead of passing
> > the burden of doing so to the callers). Thoughts?
> 
> I have used similar approaches within RCU, but on the other hand the
> scheduler often has tighter latency constraints than RCU does.	So I
> think that is a better question for the scheduler maintainers than it
> is for me.  ;-)

Ok, it definitely keeps coming up in my radar first with the
rcu_read_unlock_special() stuff, and now the nocb ;-). Perhaps it could also
be good for a conference discussion!

thanks,

 - Joel

> 							Thanx, Paul
> 
> > thanks,
> > 
> >  - Joel
> > 
> > 
> > > Can that be made to work reasonably?
> > > 
> > > 							Thanx, Paul
> > > 
> > > > thanks,
> > > > 
> > > >  - Joel
> > > > 
> > > > 
> > > > > 
> > > > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > > > ---
> > > > >  kernel/rcu/tree_plugin.h | 14 +++++++-------
> > > > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > > > > 
> > > > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > > > index 097635c41135..523570469864 100644
> > > > > --- a/kernel/rcu/tree_plugin.h
> > > > > +++ b/kernel/rcu/tree_plugin.h
> > > > > @@ -1909,7 +1909,7 @@ static void do_nocb_bypass_wakeup_timer(struct timer_list *t)
> > > > >  	struct rcu_data *rdp = from_timer(rdp, t, nocb_bypass_timer);
> > > > >  
> > > > >  	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Timer"));
> > > > > -	rcu_nocb_lock_irqsave(rdp, flags);
> > > > > +	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
> > > > >  	smp_mb__after_spinlock(); /* Timer expire before wakeup. */
> > > > >  	__call_rcu_nocb_wake(rdp, true, flags);
> > > > >  }
> > > > > @@ -1942,7 +1942,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
> > > > >  	 */
> > > > >  	for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_cb_rdp) {
> > > > >  		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
> > > > > -		rcu_nocb_lock_irqsave(rdp, flags);
> > > > > +		raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
> > > > >  		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> > > > >  		if (bypass_ncbs &&
> > > > >  		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
> > > > > @@ -1951,7 +1951,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
> > > > >  			(void)rcu_nocb_try_flush_bypass(rdp, j);
> > > > >  			bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> > > > >  		} else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
> > > > > -			rcu_nocb_unlock_irqrestore(rdp, flags);
> > > > > +			raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
> > > > >  			continue; /* No callbacks here, try next. */
> > > > >  		}
> > > > >  		if (bypass_ncbs) {
> > > > > @@ -1996,7 +1996,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
> > > > >  		} else {
> > > > >  			needwake = false;
> > > > >  		}
> > > > > -		rcu_nocb_unlock_irqrestore(rdp, flags);
> > > > > +		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
> > > > >  		if (needwake) {
> > > > >  			swake_up_one(&rdp->nocb_cb_wq);
> > > > >  			gotcbs = true;
> > > > > @@ -2084,7 +2084,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
> > > > >  	rcu_do_batch(rdp);
> > > > >  	local_bh_enable();
> > > > >  	lockdep_assert_irqs_enabled();
> > > > > -	rcu_nocb_lock_irqsave(rdp, flags);
> > > > > +	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
> > > > >  	if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
> > > > >  	    rcu_seq_done(&rnp->gp_seq, cur_gp_seq) &&
> > > > >  	    raw_spin_trylock_rcu_node(rnp)) { /* irqs already disabled. */
> > > > > @@ -2092,7 +2092,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
> > > > >  		raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
> > > > >  	}
> > > > >  	if (rcu_segcblist_ready_cbs(&rdp->cblist)) {
> > > > > -		rcu_nocb_unlock_irqrestore(rdp, flags);
> > > > > +		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
> > > > >  		if (needwake_gp)
> > > > >  			rcu_gp_kthread_wake();
> > > > >  		return;
> > > > > @@ -2100,7 +2100,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
> > > > >  
> > > > >  	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("CBSleep"));
> > > > >  	WRITE_ONCE(rdp->nocb_cb_sleep, true);
> > > > > -	rcu_nocb_unlock_irqrestore(rdp, flags);
> > > > > +	raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
> > > > >  	if (needwake_gp)
> > > > >  		rcu_gp_kthread_wake();
> > > > >  	swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
> > > > > -- 
> > > > > 2.25.0
> > > > > 
