Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7B3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94B5E2065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589471230;
	bh=VdNGNytUoEDqByba4R9ST8kEqlNqY6M19e3zbSRuc/8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=b5lbHlgBB2EqsgwHjhAlPJOA2cxGBw+saq3FjohDsaage20hcaAH22pX/iD8mafVF
	 J7ldKoaZGIMxlP8aKpYR3h/YW6yj7Vy0e/BeI0qg5KuZOPWHNHQLS3Tf9+bHxSJoWv
	 JUc2U3L1EMTWtP2UWaWwF9RzI1/8Em7gmJE0acpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgENPrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 11:47:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgENPrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 11:47:09 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29FC920657;
        Thu, 14 May 2020 15:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589471228;
        bh=VdNGNytUoEDqByba4R9ST8kEqlNqY6M19e3zbSRuc/8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iPs0Ot0Jz8Lr3N/DIQe+XwjCn9ILcTojcQoM7Yx3CRRZ2ux7tKv75GCqI0dPmL4Zc
         pN0HV0z8bkkyFu6luIwgWjsMu9uANH0c+lpXNiQDQAYkYaPD87b+GjFCpD+rM+w692
         mWFltUN5b2rGlI0nu59UmUdAQnAPkmxs1zWXn5V4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id ADB3635229C5; Thu, 14 May 2020 08:47:07 -0700 (PDT)
Date:   Thu, 14 May 2020 08:47:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 08/10] rcu: Allow to deactivate nocb on a CPU
Message-ID: <20200514154707.GL2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-9-frederic@kernel.org>
 <20200513183831.GV2869@paulmck-ThinkPad-P72>
 <20200513224525.GA18303@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513224525.GA18303@lenoir>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 12:45:26AM +0200, Frederic Weisbecker wrote:
> On Wed, May 13, 2020 at 11:38:31AM -0700, Paul E. McKenney wrote:
> > On Wed, May 13, 2020 at 06:47:12PM +0200, Frederic Weisbecker wrote:
> > > +static void __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
> > > +{
> > > +	unsigned long flags;
> > > +	struct rcu_node *rnp = rdp->mynode;
> > > +
> > > +	printk("De-offloading %d\n", rdp->cpu);
> > > +	kthread_park(rdp->nocb_cb_kthread);
> > 
> > I am a bit concerned about this, because from this point until the
> > end of this function, no RCU callbacks can be invoked for this CPU.
> > This could be a problem if there is a callback flood in progress, and
> > such callback floods are in fact one reason that the sysadm might want
> > to be switching from offloaded to non-offloaded.  Is it possible to
> > move this kthread_park() to the end of this function?  Yes, this can
> > result in concurrent invocation of different callbacks for this CPU,
> > but because we have excluded rcu_barrier(), that should be OK.
> > 
> > Or is there some failure mode that I am failing to see?  (Wouldn't
> > be the first time...)
> 
> Heh I actually worried about that. Ok the issue is that it leaves
> a window where nocb_cb and local caller of rcu_do_batch() can
> compete but the local caller doesn't lock the nocb_lock.

Indeed, my nightmare scenario involves some sort of preemption or
similar long delay at that point.  Callbacks pile up, and then OOM!

> So there are two ways to solve that.:
> 
> 1)  - set cblist->offloaded = 0 locally
>     - From the kthread while calling rcu_do_batch():
>       check the value of cblist->offloaded everytime after
>       we call rcu_nocb_lock() and stop messsing with the
>       cblist and return when we see cblist->offloaded == 0
>     - Allow to handle cblist locally without taking the nocb_lock
>     - Park kthread
> 
> But there I'm worried about races. Imagine we have:
> 
> 
>       Kthread                     Local
>       --------                   -------
>       rcu_do_batch() {
>           rcu_nocb_lock()
>           do stuff with cblist
>           rcu_nocb_unlock()
>                                  rcu_nocb_lock()
>                                  set cblist->offloaded = 0
>                                  rcu_nocb_unlock()
>                                  ===> INT or preemption
>                                  rcu_do_batch() {
>                                      do stuff with cblist
> 
> Are we guaranteed that the Local CPU will see the updates from
> the kthread while calling rcu_do_batch()? I would tend to say
> yes but I'm not entirely sure...
> 
> Oh wait, that solution also implies that we can't re-enqueue
> extracted callbacks if we spent took much time in threaded
> rcu_do_batch(), as the cblist may have been offloaded while
> we executed the extracted callbacks.
> 
> That's a lot of corner cases to handle, which is why I prefer
> the other solution:
> 
> 2) enum cblist_offloaded {
>         CBLIST_NOT_OFFLOADED,
>         CBLIST_(DE)OFFLOADING,
>         CBLIST_OFFLOADED
>    }
> 
>  - Locally set cblist->offloaded =  CBLIST_DEOFFLOADING
>  - From the kthread while calling rcu_do_batch(), do as
>    usual.
>  - Local CPU can call rcu_do_batch() and if it sees CBLIST_DEOFFLOADING,
>    rcu_nocb_lock() will take the lock.
>  - Park kthread
>  - Locally set cblist->offloaded =  CBLIST_NOT_OFFLOADED
>  - Local calls to rcu_do_batch() won't take the lock anymore.

This last seems best to me.  The transition from CBLIST_NOT_OFFLOADED
to CBLIST_OFFLOADING of course needs to be on the CPU in question with
at least bh disabled.  Probably best to be holding rcu_nocb_lock(),
but that might just be me being overly paranoid.

> > > +static long rcu_nocb_rdp_deoffload(void *arg)
> > > +{
> > > +	struct rcu_data *rdp = arg;
> > > +
> > > +	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
> > > +	__rcu_nocb_rdp_deoffload(rdp);
> > > +
> > > +	return 0;
> > > +}
> > 
> > For example, is the problem caused by invocations of this
> > rcu_nocb_rdp_deoffload() function?
> 
> How so?

It looked to me like it wasn't excluding either rcu_barrier() or CPU
hotplug.  It might also not have been pinning onto the CPU in question,
but that might just be me misremembering.  Then again, I didn't see a
call to it, so maybe its callers set things up appropriately.

OK, I will bite...  What is the purpose of rcu_nocb_rdp_deoffload()?  ;-)

> > But if so, do we really need to acquire rcu_state.barrier_mutex?
> 
> Indeed it was probably not needed if we parked the kthread before
> anything, as we would have kept the callbacks ordering.
> 
> But now if we allow concurrent callbacks execution during the small
> window, we'll need it.

Agreed!  And I do believe that concurrent callback execution will
prove better than a possibly indefinite gap in callback execution.

> > That aside, if it is possible to do the switch without interrupting
> > callback invocation?  Or is your idea that because we are always executing
> > on the CPU being deoffloaded, that CPU has been prevented from posting
> > callbacks in any case?
> 
> No in the tiny window between kthread_park() and the irqs being disabled,
> the workqueue can be preempted and thus call_rcu() can be called anytime.

Agreed!  ;-)

> > If the latter, does that mean that it is not
> > possible to deoffload offlined CPUs?  (Not sure whether this restriction
> > is a real problem, but figured that I should ask.)
> 
> Ah in the case of offlined CPUs I simply call the function directly from the CPU
> that disables the nocb remotely. So we remotely park the kthread (that we
> always do anyway) and set offlined.

And the cpus_read_lock() in rcu_nocb_cpu_deoffload() prevents that CPU
from coming back online, so looks good!

							Thanx, Paul
