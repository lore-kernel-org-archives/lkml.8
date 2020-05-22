Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7247AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 469CE20738
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590170262;
	bh=9Genvb3O1N1R0zLjO/oBc7tjpegsmQURROh97vGYeu0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=b/5j/xvRdER7eG3xvAic7qsErpMql7dYcfJvwgIwzrW/CYjaLNLpl46Ra6xUmEU4b
	 R9+NVs88qOEyWXKtvL1+wAYfPHxLTH4OHsJrRnxlq0+2QlXU44VhZ9ol36W+IbZHGW
	 6Z7WREaWDpywB78FQWhYdR5YxOpfkGDvZ9DsXB60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730856AbgEVR5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 13:57:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730702AbgEVR5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 13:57:40 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D4F9206D5;
        Fri, 22 May 2020 17:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590170259;
        bh=9Genvb3O1N1R0zLjO/oBc7tjpegsmQURROh97vGYeu0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=11KxaZX5IvlbOvxF7TASIoiAKnN6Bb5JU5bidlh7PSaoOaU27Xw/Q68Xf4MfzdSrr
         +XXcVi5h+Ss1V/giXF0bGJUxqsF5jcrn7oglknd3cgu6D40Z7oyK//ZlkbQb9fLnEA
         I/CONNoaOIJoRbj5ia5rPBgfSI6Vox5If7fdnPhU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 71B8D3522E41; Fri, 22 May 2020 10:57:39 -0700 (PDT)
Date:   Fri, 22 May 2020 10:57:39 -0700
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
Message-ID: <20200522175739.GM2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-2-frederic@kernel.org>
 <20200520122949.GB16672@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520122949.GB16672@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 08:29:49AM -0400, Joel Fernandes wrote:
> On Wed, May 13, 2020 at 06:47:05PM +0200, Frederic Weisbecker wrote:
> > Pure NOCB code entrypoints (nocb_cb kthread, nocb_gp kthread, nocb
> > timers) can unconditionally lock rdp->nocb_lock as they always execute
> > in the context of an offloaded rdp.
> > 
> > This also prepare for toggling CPUs to/from callback's offloaded mode
> > where the offloaded state will possibly change when rdp->nocb_lock
> > isn't taken. We'll still want the entrypoints to lock the rdp in any
> > case.
> 
> Suggested rewrite for change log:
> <wordsmithing>
> Make pure NOCB code entrypoints (nocb_cb kthread, nocb_gp kthread, nocb
> timers) unconditionally lock rdp->nocb_lock as they always execute in the
> context of an offloaded rdp.
> 
> This prepares for future toggling of CPUs to/from callback's offloaded mode
> where the offloaded state can change when rdp->nocb_lock is not held. We'll
> still want the entrypoints to lock the rdp in any case.
> </wordsmithing>
> 
> Also, can we inline rcu_nocb_lock_irqsave() into
> do_nocb_deferred_wakeup_common() since that's the only user, and then delete
> rcu_nocb_lock_irqsave() and the corresponding unlock? That would also remove
> confusion about which API to use for nocb locking (i.e. whether to directly
> acquire lock or call rcu_nocb_lock_irqsave()).
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thank you for looking this over, Joel!

Is it feasible to make rcu_nocb_lock*() and rcu_nocb_unlock*() "do the
right thing", even when things are changing?  If it is feasible, that
would prevent any number of "interesting" copy-pasta and "just now became
common code" bugs down the road.  And because irqs are disabled while
holding the lock, it should be possible to keep state on a per-CPU basis.

The ugliest scenario is callback adoption, where there are two ->cblist
structures in need of being locked.  In that case, changes are excluded
(because that is in CPU hotplug code), but is it possible to take
advantage of that reasonably?

Maybe these changes are the best we can do, but it would be good to
if the same primitive locked a ->cblist regardless of context.

Can that be made to work reasonably?

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > ---
> >  kernel/rcu/tree_plugin.h | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index 097635c41135..523570469864 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -1909,7 +1909,7 @@ static void do_nocb_bypass_wakeup_timer(struct timer_list *t)
> >  	struct rcu_data *rdp = from_timer(rdp, t, nocb_bypass_timer);
> >  
> >  	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Timer"));
> > -	rcu_nocb_lock_irqsave(rdp, flags);
> > +	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
> >  	smp_mb__after_spinlock(); /* Timer expire before wakeup. */
> >  	__call_rcu_nocb_wake(rdp, true, flags);
> >  }
> > @@ -1942,7 +1942,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
> >  	 */
> >  	for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_cb_rdp) {
> >  		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
> > -		rcu_nocb_lock_irqsave(rdp, flags);
> > +		raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
> >  		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> >  		if (bypass_ncbs &&
> >  		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
> > @@ -1951,7 +1951,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
> >  			(void)rcu_nocb_try_flush_bypass(rdp, j);
> >  			bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> >  		} else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
> > -			rcu_nocb_unlock_irqrestore(rdp, flags);
> > +			raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
> >  			continue; /* No callbacks here, try next. */
> >  		}
> >  		if (bypass_ncbs) {
> > @@ -1996,7 +1996,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
> >  		} else {
> >  			needwake = false;
> >  		}
> > -		rcu_nocb_unlock_irqrestore(rdp, flags);
> > +		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
> >  		if (needwake) {
> >  			swake_up_one(&rdp->nocb_cb_wq);
> >  			gotcbs = true;
> > @@ -2084,7 +2084,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
> >  	rcu_do_batch(rdp);
> >  	local_bh_enable();
> >  	lockdep_assert_irqs_enabled();
> > -	rcu_nocb_lock_irqsave(rdp, flags);
> > +	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
> >  	if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
> >  	    rcu_seq_done(&rnp->gp_seq, cur_gp_seq) &&
> >  	    raw_spin_trylock_rcu_node(rnp)) { /* irqs already disabled. */
> > @@ -2092,7 +2092,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
> >  		raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
> >  	}
> >  	if (rcu_segcblist_ready_cbs(&rdp->cblist)) {
> > -		rcu_nocb_unlock_irqrestore(rdp, flags);
> > +		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
> >  		if (needwake_gp)
> >  			rcu_gp_kthread_wake();
> >  		return;
> > @@ -2100,7 +2100,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
> >  
> >  	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("CBSleep"));
> >  	WRITE_ONCE(rdp->nocb_cb_sleep, true);
> > -	rcu_nocb_unlock_irqrestore(rdp, flags);
> > +	raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
> >  	if (needwake_gp)
> >  		rcu_gp_kthread_wake();
> >  	swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
> > -- 
> > 2.25.0
> > 
