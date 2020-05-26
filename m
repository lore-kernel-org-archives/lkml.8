Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94048C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60DC220787
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="yCPuq6Xg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbgEZPVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 11:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729310AbgEZPVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 11:21:40 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AFCC03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 08:21:39 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id ee19so9571453qvb.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 08:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cvp/jtonGRcCbB4B5H5sLrzMrHZeN0tXo7vMN9lNjPE=;
        b=yCPuq6XgoFBn/PLyW9LzL5HLPlkDbY2MslUmtKgfnbJdevp58A5O/AKd/bjTY52xPT
         bglt91GyAbZo6dLSmqzictKAGBYFEwqKynQPLbRUbaa++B+ab4Gl+tSuQHagw3PzWkYI
         zFtw2MxRQ2Re6pPxHLN1NyKXgq6yH8m77pIvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cvp/jtonGRcCbB4B5H5sLrzMrHZeN0tXo7vMN9lNjPE=;
        b=WQ4Nu+8VxcPWDeqCvlo23cMmfCuN6Owx51ylaA0jFMt0wPfs/d0OMqK8gIcN9jbxxc
         wGZI19I0qO8HBxIPKdM9zerJlL1LDOFT6hxU4oOf882BTdzJFO0yqfSRM6HXjOM3dMmD
         J7K3Eydf8OvIU7aFW1Z6VeBqPhxNpmjdhTP0X/gyXInnGMkUlYhquMANN61fe/Ycipu6
         uizLG/B+JOpOhjdUkJR5yGzJx7Lc1rAPgiKwdJkIUEXdbrv5V1r2vlns7Tif167+vcxp
         sPGUWJDLaTh5oXJKw+tQlYDfoNrE4q3ZmGl1NOekjkHRlD/hhVoFisjwEwI1lqy/V95n
         otcA==
X-Gm-Message-State: AOAM530BhOzrGC9WSg6WwY31eZ6XZEyDYO9I0K0CiQAZQr1BOC1PChvQ
        HF6+W5uo5+EKJFnHvlkiw5wWKQ==
X-Google-Smtp-Source: ABdhPJyO0gEhvrkwe//ziqmWITn9mzfU0NjnDgtsUe1jMqwJCOsEB6VLizI4cqKe6Eo+vZqY3/1icA==
X-Received: by 2002:ad4:58cb:: with SMTP id dh11mr19138455qvb.211.1590506498866;
        Tue, 26 May 2020 08:21:38 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j188sm15643846qkd.118.2020.05.26.08.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 08:21:37 -0700 (PDT)
Date:   Tue, 26 May 2020 11:21:37 -0400
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
Message-ID: <20200526152137.GB76276@google.com>
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-2-frederic@kernel.org>
 <20200520122949.GB16672@google.com>
 <20200522175739.GM2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522175739.GM2869@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Fri, May 22, 2020 at 10:57:39AM -0700, Paul E. McKenney wrote:
> On Wed, May 20, 2020 at 08:29:49AM -0400, Joel Fernandes wrote:
> > On Wed, May 13, 2020 at 06:47:05PM +0200, Frederic Weisbecker wrote:
> > > Pure NOCB code entrypoints (nocb_cb kthread, nocb_gp kthread, nocb
> > > timers) can unconditionally lock rdp->nocb_lock as they always execute
> > > in the context of an offloaded rdp.
> > > 
> > > This also prepare for toggling CPUs to/from callback's offloaded mode
> > > where the offloaded state will possibly change when rdp->nocb_lock
> > > isn't taken. We'll still want the entrypoints to lock the rdp in any
> > > case.
> > 
> > Suggested rewrite for change log:
> > <wordsmithing>
> > Make pure NOCB code entrypoints (nocb_cb kthread, nocb_gp kthread, nocb
> > timers) unconditionally lock rdp->nocb_lock as they always execute in the
> > context of an offloaded rdp.
> > 
> > This prepares for future toggling of CPUs to/from callback's offloaded mode
> > where the offloaded state can change when rdp->nocb_lock is not held. We'll
> > still want the entrypoints to lock the rdp in any case.
> > </wordsmithing>
> > 
> > Also, can we inline rcu_nocb_lock_irqsave() into
> > do_nocb_deferred_wakeup_common() since that's the only user, and then delete
> > rcu_nocb_lock_irqsave() and the corresponding unlock? That would also remove
> > confusion about which API to use for nocb locking (i.e. whether to directly
> > acquire lock or call rcu_nocb_lock_irqsave()).
> > 
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Thank you for looking this over, Joel!
> 
> Is it feasible to make rcu_nocb_lock*() and rcu_nocb_unlock*() "do the
> right thing", even when things are changing?

One way to prevent things from changing could be to employ Steven's
poor-man's RCU to mediate the "changing state" itself assuming the switch
from the fast-path to the slow-path does not happen often. :) So whichever
path is changing the state needs to wait for that poor-man's GP.

Any case, are you concerned with the performance issues with the
unconditional locking and that's why you suggest still keeping it conditional?

Also, coming back to my point of inline the helper into the last caller -
do_nocb_deferred_wakeup_common(). I think since we don't need to check if the
rdp is offloaded and do any conditional locking. The timer can be called only
with offloaded rdp. So we can directly do the unconditional spinlock instead
of using the rcu_nocb_lock helper there.

> would prevent any number of "interesting" copy-pasta and "just now became
> common code" bugs down the road.  And because irqs are disabled while
> holding the lock, it should be possible to keep state on a per-CPU basis.

Agreed, that would be nice. Though if we could keep simple, that'd be nice
too.

> The ugliest scenario is callback adoption, where there are two ->cblist
> structures in need of being locked.  In that case, changes are excluded
> (because that is in CPU hotplug code), but is it possible to take
> advantage of that reasonably?

Could you describe this a bit more? Thanks.

> Maybe these changes are the best we can do, but it would be good to
> if the same primitive locked a ->cblist regardless of context.

Here you are comparing 2 primitives. Do you mean that just IRQs being
disabled is another primitive, and rcu_nocb_lock is another one?

BTW, I'm really itching to give it a try to make the scheduler more deadlock
resilient (that is, if the scheduler wake up path detects a deadlock, then it
defers the wake up using timers, or irq_work on its own instead of passing
the burden of doing so to the callers). Thoughts?

thanks,

 - Joel


> Can that be made to work reasonably?
> 
> 							Thanx, Paul
> 
> > thanks,
> > 
> >  - Joel
> > 
> > 
> > > 
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > ---
> > >  kernel/rcu/tree_plugin.h | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > index 097635c41135..523570469864 100644
> > > --- a/kernel/rcu/tree_plugin.h
> > > +++ b/kernel/rcu/tree_plugin.h
> > > @@ -1909,7 +1909,7 @@ static void do_nocb_bypass_wakeup_timer(struct timer_list *t)
> > >  	struct rcu_data *rdp = from_timer(rdp, t, nocb_bypass_timer);
> > >  
> > >  	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Timer"));
> > > -	rcu_nocb_lock_irqsave(rdp, flags);
> > > +	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
> > >  	smp_mb__after_spinlock(); /* Timer expire before wakeup. */
> > >  	__call_rcu_nocb_wake(rdp, true, flags);
> > >  }
> > > @@ -1942,7 +1942,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
> > >  	 */
> > >  	for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_cb_rdp) {
> > >  		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
> > > -		rcu_nocb_lock_irqsave(rdp, flags);
> > > +		raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
> > >  		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> > >  		if (bypass_ncbs &&
> > >  		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
> > > @@ -1951,7 +1951,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
> > >  			(void)rcu_nocb_try_flush_bypass(rdp, j);
> > >  			bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> > >  		} else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
> > > -			rcu_nocb_unlock_irqrestore(rdp, flags);
> > > +			raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
> > >  			continue; /* No callbacks here, try next. */
> > >  		}
> > >  		if (bypass_ncbs) {
> > > @@ -1996,7 +1996,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
> > >  		} else {
> > >  			needwake = false;
> > >  		}
> > > -		rcu_nocb_unlock_irqrestore(rdp, flags);
> > > +		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
> > >  		if (needwake) {
> > >  			swake_up_one(&rdp->nocb_cb_wq);
> > >  			gotcbs = true;
> > > @@ -2084,7 +2084,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
> > >  	rcu_do_batch(rdp);
> > >  	local_bh_enable();
> > >  	lockdep_assert_irqs_enabled();
> > > -	rcu_nocb_lock_irqsave(rdp, flags);
> > > +	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
> > >  	if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
> > >  	    rcu_seq_done(&rnp->gp_seq, cur_gp_seq) &&
> > >  	    raw_spin_trylock_rcu_node(rnp)) { /* irqs already disabled. */
> > > @@ -2092,7 +2092,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
> > >  		raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
> > >  	}
> > >  	if (rcu_segcblist_ready_cbs(&rdp->cblist)) {
> > > -		rcu_nocb_unlock_irqrestore(rdp, flags);
> > > +		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
> > >  		if (needwake_gp)
> > >  			rcu_gp_kthread_wake();
> > >  		return;
> > > @@ -2100,7 +2100,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
> > >  
> > >  	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("CBSleep"));
> > >  	WRITE_ONCE(rdp->nocb_cb_sleep, true);
> > > -	rcu_nocb_unlock_irqrestore(rdp, flags);
> > > +	raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
> > >  	if (needwake_gp)
> > >  		rcu_gp_kthread_wake();
> > >  	swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
> > > -- 
> > > 2.25.0
> > > 
